namespace Kappashell {

    public errordomain ParseError {
        INVALID_FORMAT
    }

    public string[] list_to_array(GLib.List<weak string> list) {
        string[] result = new string[list.length()];
        int i = 0;
        foreach (var item in list) {
            result[i++] = item;
        }
        return result;
    }

    public delegate void HandleCommand(Context ctx);

    public class Context {
        private HashTable<string, GLib.Value?> args = new HashTable<string, GLib.Value?>(str_hash, str_equal);
        private ApplicationCommandLine cmdline;

        public Context(ApplicationCommandLine cmdline) {
            this.cmdline = cmdline;
        }

        [PrintfFormat]
        public void print(string format, ...) {
            var args = va_list();
            string message = format.vprintf(args);
            cmdline.print_literal(message);
        }

        [PrintfFormat]
        public void printerr(string format, ...) {
            var args = va_list();
            string message = format.vprintf(args);
            cmdline.printerr_literal(message);
        }

        public void set(string arg, GLib.Value value) {
            args.insert(arg, value);
        }

        public string get_string(string arg) {
            var stored = args.lookup(arg);
            assert_true(stored.type() == GLib.Type.STRING);
            return stored.get_string();
        }

        public int get_int(string arg) {
            var stored = args.lookup(arg);
            assert_true(stored.type() == GLib.Type.INT);
            return stored.get_int();
        }

        public float get_float(string arg) {
            var stored = args.lookup(arg);
            assert_true(stored.type() == GLib.Type.FLOAT);
            return stored.get_float();
        }
    }

    public enum CommandType {
        NODE, 
        LEAF,
    }

    public class Command {
        private string name;
        private string description = "";
        private HashTable<string, Command> subcommands = new HashTable<string, Command>(str_hash, str_equal);
        private List<Argument> args = new List<Argument>();
        private HandleCommand handler;
        private CommandType kind = CommandType.LEAF;

        public class Builder {
            private Command instance;

            public Builder(string name) {
                instance = new Command(name);
            }

            public Builder description(string description) {
                instance.description = description;
                return this;
            }

            public Builder subcommand(string identifier, Command command) {
                instance.subcommands.insert(identifier, command);
                instance.kind = CommandType.NODE;
                return this;
            }

            public Builder argument(Argument arg) {
                instance.args.append(arg);
                instance.kind = CommandType.LEAF;
                return this;
            }

            public Builder handler(HandleCommand handler) {
                instance.handler = handler;
                instance.kind = CommandType.LEAF;
                return this;
            }

            public Command build() {
                return instance;
            }
        }

        private Command(string name) {
            this.name = name;
        }
        
        public void execute(ApplicationCommandLine cmdline) {
            execute_internal("", cmdline.get_arguments(), cmdline);
        }

        private void execute_internal(string prefix, string[] argv, ApplicationCommandLine cmdline) {
            var cmd = prefix + " " + argv[0];
            argv = argv[1:argv.length];

            if(this.kind == CommandType.LEAF) 
                try {
                    execute_leaf(argv, cmd, cmdline);
                } catch(ParseError e) {
                    print_usage(e, cmd, cmdline);
                }
            else
                try {
                    execute_node(argv, cmd, cmdline);
                } catch(ParseError e) {
                    print_usage(e, cmd, cmdline);
                }

        }

        private void execute_leaf(string[] argv, string cmd, ApplicationCommandLine cmdline) throws ParseError {
            var ctx = new Context(cmdline);

            if(argv.length != args.length()) {
                throw new ParseError.INVALID_FORMAT("Incorrect Number of arguments!");
            }

            int i = 0;
            foreach(var decl in args) {
                var arg = argv[i];

                ctx.set(decl.name, decl.parse(arg));
                
                i++;
            }

            handler(ctx);
        }

        private void execute_node(string[] argv, string cmd, ApplicationCommandLine cmdline) throws ParseError {
            if(argv.length == 0) {
                throw new ParseError.INVALID_FORMAT("No subcommand provided!");
            }
            var subcommand = subcommands.lookup(argv[0]);

            if(subcommand == null) {
                throw new ParseError.INVALID_FORMAT("Unknown subcommand %s".printf(argv[0]));
            }

            subcommand.execute_internal(cmd, argv, cmdline);
        }

        private void print_usage(ParseError e, string cmd, ApplicationCommandLine cmdline) {
            cmdline.printerr("Error: %s\n", e.message);
            cmdline.printerr("\n");
            cmdline.printerr("%s Help:\n", name);
            
            if(kind == CommandType.LEAF) {
                cmdline.printerr("%s ", cmd);
                args.foreach((arg) => {
                    cmdline.printerr("%s ", arg.format());
                });
                cmdline.printerr("\n\n");
                args.foreach((arg) => {
                    cmdline.printerr("  %s\n", arg.details());
                    if(arg.desc != null) {
                        cmdline.printerr("    %s\n", arg.desc);
                    }
                });
            } else {
                cmdline.printerr("%s %s\n", cmd, string.joinv("|", list_to_array(subcommands.get_keys())));
                cmdline.printerr("\n");
                subcommands.foreach((name, cmd) => {
                    cmdline.printerr("  %s\n", name);
                    if(cmd.description != null) {
                        cmdline.printerr("    %s\n", cmd.description);
                    }
                });
            }
        }
    }

    public abstract class Argument {
        public string name {public get; private set; }
        public string desc {public get; private set; }

        protected Argument(string name) {
            this.name = name;
        }

        public Argument description(string description) {
            this.desc = description;
            return this;
        }
        
        public abstract GLib.Value parse(string value) throws ParseError;
        public abstract string format();
        public abstract string details();
    }

    public class StringArgument : Argument {
        public StringArgument(string name) {
            base(name);
        }
        public override GLib.Value parse(string value) throws ParseError {
            return value;
        }
        public override string format() {
            return "<%s>".printf(name);
        }
        public override string details() {
            return "<%s> : string".printf(name);
        }
    }

    public class EnumArgument : Argument {
        private string[] options;

        public EnumArgument(string name, string[] options) {
            base(name);
            this.options = options;
        }
        
        public override GLib.Value parse(string value) throws ParseError {
            foreach(var option in options) {
                if(value == option) {
                    return value;
                }
            }

            throw new ParseError.INVALID_FORMAT("Argument %s: must be one of %s".printf(name, string.join("|", options)));
        }

        public override string format() {
            return "<%s>".printf(name);
        }
        public override string details() {
            return "<%s> : string - one of %s".printf(name, string.joinv(", ", options));
        }
    }

    public class IntegerArgument : Argument {
        public IntegerArgument(string name) {
            base(name);
        }
        public override GLib.Value parse(string value) throws ParseError {
            int result;
            if(!int.try_parse(value, out result)) {
                throw new ParseError.INVALID_FORMAT("Argument %s: must be of type integer".printf(name));
            }

            return result;
        }
        public override string format() {
            return "<%s>".printf(name);
        }
        public override string details() {
            return "<%s> : int".printf(name);
        }
    }

    public class IntegerRangeArgument : Argument {
        private int min;
        private int max;
        
        public IntegerRangeArgument(string name, int min = int.MIN, int max = int.MAX) {
            base(name);
            this.min = min;
            this.max = max;
        }

        
        public override GLib.Value parse(string value) throws ParseError {
            int result;
            if(!int.try_parse(value, out result)) {
                throw new ParseError.INVALID_FORMAT("Argument %s: must be of type integer".printf(name));
            }

            if(result < min || result > max) {
                throw new ParseError.INVALID_FORMAT("Argument %s: must be in the range %d:%d".printf(name, min, max));
            }

            return result;
        }
        public override string format() {
            return "<%s>".printf(name);
        }
        public override string details() {
            return "<%s> : int - in range %d:%d".printf(name, min, max);
        }
    }

    public class FloatArgument : Argument {
        public FloatArgument(string name) {
            base(name);
        }
        public override GLib.Value parse(string value) throws ParseError {
            float result;
            if(!float.try_parse(value, out result)) {
                throw new ParseError.INVALID_FORMAT("Argument %s: must be of type float".printf(name));
            }

            return result;
        }
        public override string format() {
            return "<%s>".printf(name);
        }
        public override string details() {
            return "<%s> : float".printf(name);
        }
    }

    public class FloatRangeArgument : Argument {
        private float min;
        private float max;
        
        public FloatRangeArgument(string name, float min = float.MIN, float max = float.MAX) {
            base(name);
            this.min = min;
            this.max = max;
        }

        public override GLib.Value parse(string value) throws ParseError {
            float result;
            if(!float.try_parse(value, out result)) {
                throw new ParseError.INVALID_FORMAT("Argument %s: must be of type float".printf(name));
            }

            if(result < min || result > max) {
                throw new ParseError.INVALID_FORMAT("Argument %s: must be in the range %f:%f".printf(name, min, max));
            }

            return result;
        }
        public override string format() {
            return "<%s>".printf(name);
        }
        public override string details() {
            return "<%s> : float - in range %f:%f".printf(name, min, max);
        }
    }
}

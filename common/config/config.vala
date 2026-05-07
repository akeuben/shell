namespace Kappashell {
    public class Config {

        public signal void config_changed(ConfigNode node);
        public signal void config_error(GLib.Error error);

        public Config(string path) {
            this.setup_config_monitor(path);
        }

        private void setup_config_monitor(string path) {
            var file = GLib.File.new_for_path(path);
            try {
                var monitor = file.monitor(GLib.FileMonitorFlags.NONE, null);
                monitor.ref();
                monitor.rate_limit = 100;

                monitor.changed.connect((file, other, type) => {
                    if(type != GLib.FileMonitorEvent.CHANGED) 
                        return;
                    read_config(path);
                });
            } catch(GLib.Error e) {
                this.config_error(e);
                return;
            }
            
            GLib.Timeout.add_once(0, () => {
                read_config(path);
            });
        }

        private void read_config(string path) {
            var fileStream = GLib.FileStream.open(path, "r");
            if (fileStream == null) {
                warning("Failed to open config: %s", path);
                return;
            }

            var parser = Yaml.Parser();
            parser.set_input_file(fileStream);

            Yaml.Document document;
            parser.load(out document);

            Yaml.Node* root = (Yaml.Node*) document.get_root_node();
            if (root != null) {
                var ast = ConfigNode.fromYaml(document, *root);

                this.config_changed(ast);
            }
        }
    }
}

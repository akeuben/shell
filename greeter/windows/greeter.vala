public class Greeter : Astal.Window {

    private Gtk.Box content;

    private AstalGreet.Greeter greeter;
    
    public Greeter() {
        namespace = "kappashell.greeter.greeter";
        exclusivity = Astal.Exclusivity.IGNORE;
        layer = Astal.Layer.TOP;
        keymode = Astal.Keymode.ON_DEMAND;
        gdkmonitor = null;
        anchor = Astal.WindowAnchor.NONE;

        greeter = new AstalGreet.Greeter();

        content = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 30);
        content.homogeneous = true;

        content.append(new InfoPane());
        content.append(new LoginPane());

        set_child(content);

        add_css_class("greeter");
        content.add_css_class("greeter");
        present();
    }
}

public class InfoPane : Astal.Bin {
    public InfoPane() {

        var content = new Gtk.Box(Gtk.Orientation.VERTICAL, 10);

        content.margin_top = 30;
        content.margin_bottom = 30;
        content.margin_start = 30;
        content.margin_end = 30;

        var header = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 10);
        var icon = new Gtk.Image.from_icon_name("nix-snowflake-white");
        icon.pixel_size = 64;
        icon.add_css_class("hostname");
        header.append(icon);
        var greeting = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
        var message = new Gtk.Label("Welcome to");
        message.add_css_class("welcome");
        message.hexpand = false;
        message.halign = Gtk.Align.START;
        greeting.append(message);
        var hostname = new Gtk.Label(GLib.Environment.get_host_name());
        hostname.add_css_class("hostname");
        hostname.hexpand = false;
        hostname.halign = Gtk.Align.START;
        greeting.append(hostname);
        header.append(greeting);
        content.append(header);

        var quotebox = new Gtk.CenterBox();
        quotebox.add_css_class("quotebox");
        quotebox.vexpand = true;
        var quote = new Gtk.Label("Small steps make big changes");
        quote.wrap = true;
        quote.wrap_mode = Pango.WrapMode.WORD_CHAR;
        quote.max_width_chars = 20;
        quote.justify = Gtk.Justification.CENTER;
        quote.xalign = 0.5f;
        quote.halign = Gtk.Align.CENTER;
        quote.margin_top = 20;
        quote.margin_bottom = 20;
        quote.add_css_class("quote");
        quotebox.center_widget = quote;
        var openQuote = new Gtk.Label("“");
        openQuote.add_css_class("quote-mark");
        openQuote.yalign = 0.0f;
        openQuote.margin_top = 12;
        openQuote.vexpand = true;
        var closeQuote = new Gtk.Label("”");
        closeQuote.add_css_class("quote-mark");
        closeQuote.yalign = 1.0f;
        closeQuote.vexpand = true;
        quotebox.start_widget = openQuote;
        quotebox.end_widget = closeQuote;
        content.append(new Gtk.Separator(Gtk.Orientation.HORIZONTAL));
        content.append(quotebox);
        content.append(new Gtk.Separator(Gtk.Orientation.HORIZONTAL));

        child = content;
        add_css_class("greeter-box");
    }
}

public class LoginPane : Astal.Bin {
    
    public LoginPane() {
        var content = new Gtk.Box(Gtk.Orientation.VERTICAL, 10);

        content.margin_top = 20;
        content.margin_bottom = 30;
        content.margin_start = 30;
        content.margin_end = 30;

        var tabs = new Gtk.Stack();
        tabs.notify["visible-child-name"].connect(() => {
            LoginTab tab = (LoginTab) tabs.get_visible_child();
            print("Switched to tab: %s\n", tabs.get_visible_child_name());
            tab.onVisible();
        });

        var sessions = DesktopSession.getSessions();

        var sessionDropdown = new Gtk.DropDown(sessions, new Gtk.PropertyExpression(typeof(DesktopSession), null, "name"));

        var greeter = new AstalGreet.Greeter();

        var main = new LoginMainTab();
        main.selector.other_selected.connect(() => tabs.set_visible_child_name("username"));
        main.selector.user_selected.connect((_, user) => {
            KappashellGreeter.updateCurrentWallpaper(user.username);
            greeter.create_session(user.username);
            tabs.set_visible_child_name("loading");
        });

        var username = new LoginUsernameTab();
        username.username_entered.connect((_, username) => {
            KappashellGreeter.updateCurrentWallpaper(username);
            greeter.create_session(username);
            tabs.set_visible_child_name("loading");
        });

        var visibleTab = new LoginVisibleTab();
        visibleTab.value_entered.connect((_, value) => {
            greeter.post_auth(value);
            tabs.set_visible_child_name("loading");
        });
        var secretTab = new LoginSecretTab();
        secretTab.value_entered.connect((_, value) => {
            greeter.post_auth(value);
            tabs.set_visible_child_name("loading");
        });

        greeter.visible_request.connect((message) => {
            visibleTab.setTitle(message.replace(":", "").strip());
            tabs.set_visible_child_name("visible");
        });

        greeter.secret_request.connect((message) => {
            secretTab.setTitle(message.replace(":", "").strip());
            tabs.set_visible_child_name("secret");
        });

        greeter.info_message.connect((message) => {
        });

        greeter.error_message.connect((message) => {
            tabs.transition_type = Gtk.StackTransitionType.SLIDE_RIGHT;
            tabs.set_visible_child_name("main");
            tabs.transition_type = Gtk.StackTransitionType.SLIDE_LEFT;
        });

        greeter.cancelled.connect((error) => {
            tabs.transition_type = Gtk.StackTransitionType.SLIDE_RIGHT;
            tabs.set_visible_child_name("main");
            tabs.transition_type = Gtk.StackTransitionType.SLIDE_LEFT;
        });

        greeter.authenticated.connect(() => {
            try {
                string[] argv;
                GLib.Shell.parse_argv(((DesktopSession) sessionDropdown.selected_item).exec, out argv);
                greeter.start_session.begin(argv, new string[0], (_, res) => {
                    greeter.start_session.end(res);
                    GLib.Process.exit(0);
                });
            } catch(Error e) {
                tabs.transition_type = Gtk.StackTransitionType.SLIDE_RIGHT;
                tabs.set_visible_child_name("main");
                tabs.transition_type = Gtk.StackTransitionType.SLIDE_LEFT;
            }
        });

        tabs.add_named(main, "main");
        tabs.add_named(username, "username");
        tabs.add_named(visibleTab, "visible");
        tabs.add_named(secretTab, "secret");
        tabs.add_named(new LoginLoadingTab(), "loading");
        tabs.set_visible_child_name("main");
        tabs.transition_type = Gtk.StackTransitionType.SLIDE_LEFT;
        tabs.hhomogeneous = true;
        tabs.vhomogeneous = true;

        content.append(tabs);
        content.append(new Gtk.Separator(Gtk.Orientation.HORIZONTAL));
        content.append(sessionDropdown);

        child = content;
        add_css_class("greeter-box");
    }
}

public abstract class LoginTab : Gtk.Box {
    private Gtk.Label label;
    protected LoginTab(string title) {
        Object(orientation: Gtk.Orientation.VERTICAL, spacing: 20);
        var header = new Gtk.Overlay();
        var sep = new Gtk.Separator(Gtk.Orientation.HORIZONTAL);
        header.child = sep;
        header.margin_top = 10;
        var labelBox = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
        labelBox.add_css_class("bg");

        label = new Gtk.Label(title);
        labelBox.hexpand = false;
        labelBox.halign = Gtk.Align.CENTER;
        labelBox.valign = Gtk.Align.CENTER;
        label.margin_start = 10;
        label.margin_end = 10;
        labelBox.append(label);
        header.add_overlay(labelBox);

        vexpand = true;

        append(header);
    }
    public void setTitle(string title) {
        this.label.set_text(title);
    }
    public abstract void onVisible();
}

public class LoginMainTab : LoginTab {
    public LoginSelector selector;
    public Gtk.PasswordEntry password;
    
    public LoginMainTab() {
        base("Select a user");

        selector = new LoginSelector();
        password = new Gtk.PasswordEntry();
        password.placeholder_text = "Password";

        append(selector);
    }

    public override void onVisible() {
        selector.autoSelect();
        password.text = "";
        KappashellGreeter.updateCurrentWallpaper(null);
    }
}

public class LoginUsernameTab : LoginTab {
    public Gtk.Entry entry;

    public signal void username_entered(string username);

    public LoginUsernameTab() {
        base("Enter username");

        entry = new Gtk.Entry();
        entry.placeholder_text = "Username";
        entry.activate.connect(() => {
            username_entered(entry.text);
        });
        entry.valign = Gtk.Align.CENTER;
        entry.vexpand = true;

        append(entry);
    }

    public override void onVisible() {
        entry.text = "";
        entry.grab_focus();
        KappashellGreeter.updateCurrentWallpaper(null);
    }
}

public class LoginVisibleTab : LoginTab {
    public Gtk.Entry entry;

    public signal void value_entered(string value);

    public LoginVisibleTab() {
        base("Enter login");

        entry = new Gtk.Entry();
        entry.valign = Gtk.Align.CENTER;
        entry.vexpand = true;

        entry.activate.connect(() => {
            value_entered(entry.text);
        });

        append(entry);
    }

    public new void setTitle(string title) {
        base.setTitle(title);
        entry.placeholder_text = title;
    }

    public override void onVisible() {
        entry.text = "";
        entry.grab_focus();
    }
}

public class LoginSecretTab : LoginTab {
    public Gtk.PasswordEntry entry;

    public signal void value_entered(string value);

    public LoginSecretTab() {
        base("Enter login");

        entry = new Gtk.PasswordEntry();
        entry.valign = Gtk.Align.CENTER;
        entry.vexpand = true;

        entry.activate.connect(() => {
            value_entered(entry.text);
        });

        append(entry);
    }

    public new void setTitle(string title) {
        base.setTitle(title);
        entry.placeholder_text = title;
    }

    public override void onVisible() {
        entry.text = "";
        entry.grab_focus();
    }
}

public class LoginLoadingTab : LoginTab {
    public LoginLoadingTab() {
        base("Please wait...");

        vexpand = true;

        var spinner = new Gtk.Spinner();
        spinner.halign = Gtk.Align.CENTER;
        spinner.valign = Gtk.Align.CENTER;
        spinner.vexpand = true;

        append(spinner);

        spinner.start();
    }

    public override void onVisible() {
    }
}

public class LoginSelector : Gtk.Box {

    private LoginCard selectedCard;

    public LoginUser selected {public get; private set;}

    public signal void user_selected(LoginUser user);
    public signal void other_selected();

    private Gtk.Box content;
    
    public LoginSelector() {
        valign = Gtk.Align.CENTER;
        vexpand = true;
        var scroller = new Gtk.ScrolledWindow();
        content = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 10);

        scroller.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.NEVER);
        scroller.hexpand = true;
        scroller.min_content_height = 150;

        var users = LoginUser.getUsers();

        foreach (var user in users) {
            var card = new LoginCard(user);
            card.clicked.connect(() => {
                selectUser(user, card);
                user_selected(user);
            });

            content.append(card);
        }
        
        var other = new LoginCard(new LoginUser("other", "other", "", "kappashellinternal::otheruser"));
        other.clicked.connect(() => {
            other_selected();
        });

        content.append(other);

        autoSelect();

        scroller.child = content;
        append(scroller);
    }

    public void autoSelect() {
        LoginCard current = (LoginCard) content.get_first_child();

        selectedCard = null;
        selected = null;

        do {
            if(GreeterSettings.instance.last_user == current.user.username) {
                selectUser(current.user, current);
            }
        } while((current = (LoginCard) current.get_next_sibling()) != null);

        if(selected == null) {
            current = (LoginCard) content.get_first_child();
            selectUser(current.user, current);
        }
    }

    private void selectUser(LoginUser user, LoginCard card) {
        if(selectedCard != null) {
            selectedCard.deselect();
        }

        card.select();
        selectedCard = card;
        selected = user;
        GreeterSettings.instance.last_user = user.username;
    }
}

public class LoginCard : Gtk.Button {
    public LoginUser user {public get; private set;}
    
    public LoginCard(LoginUser user) {
        this.user = user;
        var box = new Gtk.Box(Gtk.Orientation.VERTICAL, 10);
        box.margin_start = 10;
        box.margin_end = 10;
        box.margin_top = 10;
        box.margin_bottom = 10;
        var icon = new Gtk.Image.from_icon_name(user.shell == "kappashellinternal::otheruser" ? "feather-users-symbolic" : "feather-user-symbolic");
        icon.pixel_size = 48;
        var label = new Gtk.Label(user.real_name);

        box.append(icon);
        box.append(label);

        child = box;

        add_css_class("login-card");
        cursor = new Gdk.Cursor.from_name("pointer", null);
    }

    public void select() {
        add_css_class("selected");
    }

    public void deselect() {
        remove_css_class("selected");
    }
}

public class GreeterSettings : Object {
    private GLib.Settings settings;

    private static GreeterSettings? _instance = null;

    public static GreeterSettings instance {
        get {
            if (_instance == null) {
                _instance = new GreeterSettings();
            }

            return _instance;
        }
    }

    private GreeterSettings() {
        settings = new GLib.Settings("ca.kappashell.greeter");
    }

    public string last_user {
        owned get {
            return settings.get_string("last-user");
        }
        set {
            settings.set_string("last-user", value);
        }
    }
}

public class DesktopSession : Object {
    public string name { get; construct; }
    public string exec { get; construct; }
    public bool wayland { get; construct; }

    public DesktopSession(string name, string exec, bool wayland) {
        Object(
            name: name,
            exec: exec,
            wayland: wayland
        );
    }

    private static bool get_boolean_or_default(GLib.KeyFile file, string group, string key, bool default_value = false) {
        try {
            if (!file.has_key(group, key))
                return default_value;
            return file.get_boolean(group, key);
        } catch (GLib.Error e) {
            warning("Invalid boolean %s in %s: %s", key, group, e.message);
            return default_value;
        }
    }

    public static GLib.ListStore getSessions() {
        var sessions = new GLib.ListStore(typeof(DesktopSession));

        string data_dirs = GLib.Environment.get_variable("XDG_DATA_DIRS")
            ?? "/usr/local/share:/usr/share";

        string[] session_types = {
            "wayland-sessions",
            "xsessions"
        };

        // Higher-priority directories are checked first.
        var seen = new GLib.HashTable<string, bool>(
            GLib.str_hash,
            GLib.str_equal
        );

        foreach (string data_dir in data_dirs.split(":")) {
            print("Found data dir: %s\n", data_dir);
            foreach (string session_type in session_types) {
                string directory = GLib.Path.build_filename(
                    data_dir,
                    session_type
                );

                try {
                    var dir = GLib.Dir.open(directory);

                    string? filename;
                    while ((filename = dir.read_name()) != null) {
                        if (!filename.has_suffix(".desktop"))
                            continue;

                        string key = session_type + "/" + filename;

                        print("Found desktop session: %s\n", key);

                        if (seen.contains(key))
                            continue;

                        seen.insert(key, true);

                        string path = GLib.Path.build_filename(
                            directory,
                            filename
                        );

                        try {
                            var file = new GLib.KeyFile();
                            file.load_from_file(
                                path,
                                GLib.KeyFileFlags.NONE
                            );

                            if (file.get_string("Desktop Entry", "Type") != "Application")
                                continue;

                            if (get_boolean_or_default(file, "Desktop Entry", "Hidden"))
                                continue;

                            if (get_boolean_or_default(file, "Desktop Entry", "NoDisplay"))
                                continue;

                            string name = file.get_locale_string(
                                "Desktop Entry",
                                "Name"
                            );

                            string exec = file.get_string(
                                "Desktop Entry",
                                "Exec"
                            );

                            if (name.strip() == "" || exec.strip() == "")
                                continue;

                            sessions.append(new DesktopSession(
                                name,
                                exec,
                                session_type == "wayland-sessions"
                            ));

                        } catch (GLib.Error e) {
                            warning("Could not read session %s: %s", path, e.message);
                        }
                    }
                } catch (GLib.Error e) {
                    // Directory doesn't exist or isn't accessible.
                    continue;
                }
            }
        }

        return sessions;
    }
}

public class LoginUser : Object {
    public string username { get; construct; }
    public string real_name { get; construct; }
    public string home_directory { get; construct; }
    public string shell { get; construct; }

    public LoginUser(
        string username,
        string real_name,
        string home_directory,
        string shell
    ) {
        Object(
            username: username,
            real_name: real_name,
            home_directory: home_directory,
            shell: shell
        );
    }

    public static GLib.List<LoginUser> getUsers() {
        var users = new GLib.List<LoginUser>();

        Passwd.setpwent();
        unowned Passwd.PasswdEntry? entry;
        while((entry = Passwd.getpwent()) != null) {
            if(entry.pw_uid < 1000)
                continue;

            string shell = entry.pw_shell ?? "";

            if(shell.has_suffix("/nologin") || shell.has_suffix("/false"))
                continue;

            string real_name = entry.pw_gecos.strip();
            if (real_name == "")
                real_name = entry.pw_name;

            users.append(new LoginUser(entry.pw_name, real_name, entry.pw_dir ?? "", shell));
        }

        Passwd.endpwent();

        return users;
    }
}

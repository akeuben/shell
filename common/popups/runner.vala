namespace Kappashell {
    public class RunnerPopup : PopupContent {

        private List<PopupDataSource> sources;

        public RunnerPopup() {
            sources = new List<PopupDataSource>();
            sources.append(new ApplicationDataSource());
        }

        private List<Result> search(string query) {
            List<Result> results = new List<Result?>();
            sources.foreach(source => {
                source.find_results(query).foreach(result => {
                    results.append(result);
                });
            });

            results.sort((a, b) => (int) (1000 * (b.score - a.score)));
            return (owned) results;
        }

        private delegate void Action();
        
        public override Gtk.Widget build (Kappashell.PopupEnvironment environment) {
            Gtk.Widget? highlight_widget = null;

            var result_box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 10);
            var list_box = new Gtk.Box(Gtk.Orientation.VERTICAL, 10);
            list_box.hexpand = true;
            var details_box = new Astal.Bin();
            details_box.hexpand = true;

            var box = new Gtk.Box(Gtk.Orientation.VERTICAL, 10);
            var search = new Gtk.SearchEntry();
            search.placeholder_text = "Search Anything...";
            search.width_chars = 75;

            search.map.connect (() => {
                print("grab\n");
                var res = search.grab_focus();
                print("result: %s\n", res.to_string());
            });

            Action next = () => {
                print("Next %s %s\n", (highlight_widget != null).to_string(), (highlight_widget.get_next_sibling() != null).to_string());
                if(highlight_widget != null && highlight_widget.get_next_sibling() != null) {
                    highlight_widget.remove_css_class("selected");
                    highlight_widget = highlight_widget.get_next_sibling();
                    highlight_widget.add_css_class("selected");
                    unowned var result = highlight_widget.get_data<Result>("result");
                    details_box.child = generate_details_result(result);
                }
            };

            Action prev = () => {
                print("Prev %s %s\n", (highlight_widget != null).to_string(), (highlight_widget.get_prev_sibling() != null).to_string());
                if(highlight_widget != null && highlight_widget.get_prev_sibling() != null) {
                    highlight_widget.remove_css_class("selected");
                    highlight_widget = highlight_widget.get_prev_sibling();
                    highlight_widget.add_css_class("selected");
                    unowned var result = highlight_widget.get_data<Result>("result");
                    details_box.child = generate_details_result(result);
                }
            };

            search.activate.connect(() => {
                print("Activate\n");
                if(highlight_widget == null) return;
                print("Found selected!\n");

                unowned var result = highlight_widget.get_data<Result>("result");
                print("Launching application: %s\n", result.title);
                result.action();
                environment.popup.close_popup();
            });

            var controller = new Gtk.EventControllerKey();
            controller.key_released.connect((keyval) => {
                if(keyval == Gdk.Key.Up) {
                    prev();
                } else if(keyval == Gdk.Key.Down) {
                    next();
                }
            });

            search.next_match.connect(() => prev());
            search.previous_match.connect(() => next());
            search.add_controller(controller);

            result_box.append(list_box);
            result_box.append(details_box);

            box.append(result_box);
            box.append(search);

            search.search_changed.connect(() => {
                clear_children(list_box);

                if(search.text.strip().length == 0) {
                    details_box.child = null;
                    return;
                }

                var results = this.search(search.text);
                int i = 0;
                foreach (var result in results) {
                    if (i++ >= 5) break;
                    var item = generate_list_result(result);
                    item.set_data<Result>("result", result);
                    item.add_css_class("result");
                    if(i == 1) {
                        highlight_widget = item;
                        item.add_css_class("selected");
                        details_box.child = generate_details_result(result);
                    }
                    list_box.prepend(item);
                }
            });

            return box;
        }

        private Gtk.Box generate_list_result(Result result) {
            var box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 10);
            box.hexpand = true;
            var icon = new Gtk.Image.from_icon_name(result.icon_name);
            icon.pixel_size = 32;
            box.append(icon);

            var details = new Gtk.Box(Gtk.Orientation.VERTICAL, 5);
            details.hexpand = true;

            var title = new Gtk.Label(result.title);
            title.halign = Gtk.Align.START;
            title.hexpand = false;
            title.max_width_chars = 30;
            title.width_chars = 30;
            title.ellipsize = Pango.EllipsizeMode.END;

            details.append(title);

            if(result.description != null && result.description.strip().length != 0) {
                var desc = new Gtk.Label(result.description);
                desc.halign = Gtk.Align.START;
                desc.hexpand = false;
                desc.max_width_chars = 30;
                desc.width_chars = 30;
                desc.ellipsize = Pango.EllipsizeMode.END;
                details.append(desc);
            }

            box.append(details);

            return box;
        }

        private Gtk.Box generate_details_result(Result result) {
            var box = new Gtk.Box(Gtk.Orientation.VERTICAL, 10);
            box.hexpand = true;
            var icon = new Gtk.Image.from_icon_name(result.icon_name);
            icon.halign = Gtk.Align.CENTER;
            icon.pixel_size = 32;
            box.append(icon);

            var title = new Gtk.Label(result.title);
            title.max_width_chars = 30;
            title.width_chars = 30;
            title.wrap = true;
            title.wrap_mode = Pango.WrapMode.WORD_CHAR;
            title.vexpand = false;
            title.valign = Gtk.Align.CENTER;

            box.append(title);

            if(result.description != null && result.description.strip().length != 0) {
                var desc = new Gtk.Label(result.description);
                desc.max_width_chars = 30;
                desc.width_chars = 30;
                desc.wrap = true;
                desc.wrap_mode = Pango.WrapMode.WORD_CHAR;
                box.append(desc);
            }

            return box;
        }
    }

    delegate void ResultAction();

    class Result {
        public string icon_name;
        public string title;
        public string description;
        public double score;
        public ResultAction action;
    }

    abstract class PopupDataSource {
        public abstract List<Result> find_results(string search);
    }

    class ApplicationDataSource : PopupDataSource {
        AstalApps.Apps apps = new AstalApps.Apps();

        public ApplicationDataSource() {
            apps.name_multiplier = 2;
            apps.entry_multiplier = 0;
            apps.executable_multiplier = 2;
        }

        public override List<Result> find_results(string search) {
            var applications = apps.fuzzy_query(search);

            var results = new List<Result>();
            applications.foreach((app) => {
                var captured_app = app;
                Result result = new Result();
                result.icon_name = captured_app.icon_name;
                result.title = captured_app.name;
                result.description = captured_app.description;
                result.score = apps.fuzzy_score(search, captured_app);
                result.action = () => {
                    print("Launching: %s\n", captured_app.name);
                    captured_app.launch();
                };
                results.append(result);
            });

            return (owned) results;
        }
    }
}

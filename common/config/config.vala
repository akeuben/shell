
namespace Kappashell {
    public class Config {

        public ConfigNode current_config { public get; private set; }

        public signal void config_changed(ConfigNode node);
        public signal void config_error(GLib.Error error);

        private string config_path;
        private string default_resource;

        private GLib.FileMonitor? monitor;

        public Config(
            string path,
            string default_resource = "/config/config.yaml"
        ) {
            this.config_path = path;
            this.default_resource = default_resource;

            this.setup_config_monitor(path);
        }

        public static void EnsureExists(string path, string default_resource) {
            var config_file = GLib.File.new_for_path(path);

            if (config_file.query_exists()) {
                return;
            }

            try {
                var parent = config_file.get_parent();

                if (parent != null) {
                    parent.make_directory_with_parents(null);
                }

                var resource_stream = GLib.resources_open_stream(
                    default_resource,
                    GLib.ResourceLookupFlags.NONE
                );

                var dest_stream = config_file.create(
                    GLib.FileCreateFlags.NONE
                );

                dest_stream.splice(
                    resource_stream,
                    GLib.OutputStreamSpliceFlags.CLOSE_SOURCE |
                    GLib.OutputStreamSpliceFlags.CLOSE_TARGET
                );

            } catch (GLib.Error e) {
                warning("Failed to create default config: %s", e.message);
            }
        }

        private void setup_config_monitor(string path) {
            var file = GLib.File.new_for_path(path);

            try {
                this.monitor = file.monitor(
                    GLib.FileMonitorFlags.NONE,
                    null
                );

                this.monitor.rate_limit = 100;

                this.monitor.changed.connect((file, other, type) => {
                    if (type == GLib.FileMonitorEvent.CHANGED ||
                        type == GLib.FileMonitorEvent.CHANGES_DONE_HINT ||
                        type == GLib.FileMonitorEvent.CREATED ||
                        type == GLib.FileMonitorEvent.DELETED ||
                        type == GLib.FileMonitorEvent.MOVED_IN ||
                        type == GLib.FileMonitorEvent.MOVED_OUT) {
                        this.read_config();
                    }
                });

            } catch (GLib.Error e) {
                warning("Failed to monitor config: %s", e.message);
                this.config_error(e);
            }

            GLib.Timeout.add_once(0, () => {
                this.read_config();
            });
        }

        private void read_config() {
            // Try the external configuration first.
            try {
                var file = GLib.File.new_for_path(this.config_path);

                uint8[] contents;
                file.load_contents(null, out contents, null);

                debug("Loading configuration: %s", this.config_path);

                if (this.parse_config(contents)) {
                    return;
                }

            } catch (GLib.Error e) {
                debug("Unable to load external config: %s", e.message);
            }

            // Fall back to the embedded resource.
            try {
                var resource = GLib.resources_lookup_data(
                    this.default_resource,
                    GLib.ResourceLookupFlags.NONE
                );

                unowned uint8[] contents = resource.get_data();

                debug("Loading embedded default config: %s",
                    this.default_resource);

                this.parse_config(contents);

            } catch (GLib.Error e) {
                warning("Failed to load embedded config: %s", e.message);
                this.config_error(e);
            }
        }

        private bool parse_config(uint8[] contents) {
            var parser = Yaml.Parser();
            parser.set_input_string(contents);

            Yaml.Document document;

            if (parser.load(out document) == 0) {
                warning("Failed to parse YAML configuration");
                return false;
            }

            Yaml.Node* root = (Yaml.Node*) document.get_root_node();

            if (root == null) {
                warning("Configuration contains an empty YAML document");
                return false;
            }

            var ast = ConfigNode.fromYaml(document, *root);

            this.current_config = ast;
            this.config_changed(ast);

            return true;
        }
    }
}


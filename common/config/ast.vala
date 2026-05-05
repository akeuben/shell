namespace Kappashell {
    public enum ConfigNodeType {
        None,
        Object,
        Array,
        String,
        Integer,
        Float,
        Bool,
    }

    public abstract class ConfigNode : Object {
        protected ConfigNodeType kind;

        public static ConfigNode fromYaml(Yaml.Document document, Yaml.Node root) {
            switch (root.type) {
                case Yaml.NodeType.NO:
                    return new NoneConfigNode.yaml(document, root);
                case Yaml.NodeType.SCALAR:
                    if(root.data_scalar_style == Yaml.ScalarStyle.SINGLE_QUOTED || root.data_scalar_style == Yaml.ScalarStyle.DOUBLE_QUOTED) {
                        return new StringConfigNode.yaml(document, root);
                    }
                    if(int.try_parse(root.data_scalar_value)) {
                        return new IntegerConfigNode.yaml(document, root);
                    }
                    if(float.try_parse(root.data_scalar_value)) {
                        return new FloatConfigNode.yaml(document, root);
                    }
                    if(bool.try_parse(root.data_scalar_value)) {
                        return new BoolConfigNode.yaml(document, root);
                    }
                    return new StringConfigNode.yaml(document, root);
                case Yaml.NodeType.SEQUENCE:
                    return new ArrayConfigNode.yaml(document, root);
                case Yaml.NodeType.MAPPING:
                    return new ObjectConfigNode.yaml(document, root);
            }

            return new NoneConfigNode();
        }

        public ConfigNodeType get_node_type() {
            return kind;
        }

        public ObjectConfigNode get_object() {
            assert_true(kind == ConfigNodeType.Object);
            return (ObjectConfigNode) this;
        }

        
        public ArrayConfigNode get_array() {
            assert_true(kind == ConfigNodeType.Array);
            return (ArrayConfigNode) this;
        }

        public StringConfigNode get_string() {
            assert_true(kind == ConfigNodeType.String);
            return (StringConfigNode) this;
        }

        public IntegerConfigNode get_integer() {
            assert_true(kind == ConfigNodeType.Integer);
            return (IntegerConfigNode) this;
        }

        public FloatConfigNode get_float() {
            assert_true(kind == ConfigNodeType.Float);
            return (FloatConfigNode) this;
        }

        public BoolConfigNode get_bool() {
            assert_true(kind == ConfigNodeType.Bool);
            return (BoolConfigNode) this;
        }

        public NoneConfigNode get_none() {
            assert_true(kind == ConfigNodeType.None);
            return (NoneConfigNode) this;
        }

        public virtual string to_string() {
            return "(unknown)";
        }
    }

    public class NoneConfigNode : ConfigNode {

        construct {
            kind = ConfigNodeType.None;
        }

        public NoneConfigNode() {}

        public NoneConfigNode.yaml(Yaml.Document document, Yaml.Node node) {
            assert_true(node.type == Yaml.NodeType.NO);
        }

        public override string to_string() {
            return "Null";
        }
    }

    public class ObjectConfigNode : ConfigNode {

        construct {
            kind = ConfigNodeType.Object;
        }

        public HashTable<string, ConfigNode> mappings {get; private set;}

        public ObjectConfigNode.yaml(Yaml.Document document, Yaml.Node node) {
            assert_true(node.type == Yaml.NodeType.MAPPING);
            mappings = new HashTable<string, ConfigNode>(str_hash, str_equal);

            Yaml.NodePair* pair = (Yaml.NodePair*) node.data_mapping_pairs_start;
            Yaml.NodePair* top  = (Yaml.NodePair*) node.data_mapping_pairs_top;

            while (pair < top) {
                unowned Yaml.Node* key = (Yaml.Node*) document.get_node(pair->key);
                unowned Yaml.Node* val = (Yaml.Node*) document.get_node(pair->value);

                if (key != null && val != null) {
                    assert_true(key->type == Yaml.NodeType.SCALAR);
                    string key_str = key.data_scalar_value;
                    ConfigNode value = ConfigNode.fromYaml(document, *val);

                    mappings.insert(key_str, value);
                }

                pair++;
            }
        }

        public bool has_member(string key) {
            return mappings.contains(key);
        }

        public ConfigNode get_member(string key) {
            assert_true(mappings.contains(key));
            return mappings.get(key);
        }

        public ObjectConfigNode get_object_member(string key) {
            return get_member(key).get_object();
        }

        public ArrayConfigNode get_array_member(string key) {
            return get_member(key).get_array();
        }

        public string get_string_member(string key) {
            return get_member(key).get_string().value;
        }

        public int get_integer_member(string key) {
            return get_member(key).get_integer().value;
        }

        public float get_float_member(string key) {
            return get_member(key).get_float().value;
        }

        public bool get_bool_member(string key) {
            return get_member(key).get_bool().value;
        }

        public ConfigNode get_member_with_default(string key, ConfigNode default_value) {
            return mappings.contains(key) ? mappings.get(key) : default_value;
        }

        public ObjectConfigNode get_object_member_with_default(string key, ObjectConfigNode default_value) {
            if (!mappings.contains(key)) return default_value;
            return get_member(key).get_object();
        }

        public ArrayConfigNode get_array_member_with_default(string key, ArrayConfigNode default_value) {
            if (!mappings.contains(key)) return default_value;
            return get_member(key).get_array();
        }

        public string get_string_member_with_default(string key, string default_value) {
            if (!mappings.contains(key)) return default_value;
            return get_member(key).get_string().value;
        }

        public int get_integer_member_with_default(string key, int default_value) {
            if (!mappings.contains(key)) return default_value;
            return get_member(key).get_integer().value;
        }

        public float get_float_member_with_default(string key, float default_value) {
            if (!mappings.contains(key)) return default_value;
            return get_member(key).get_float().value;
        }

        public bool get_bool_member_with_default(string key, bool default_value) {
            if (!mappings.contains(key)) return default_value;
            return get_member(key).get_bool().value;
        }


        public override string to_string() {
            var sb = new StringBuilder();
            sb.append("Object { ");

            bool first = true;
            mappings.foreach((key, val) => {
                if (!first) sb.append(", ");
                sb.append("%s: %s".printf(key, val.to_string()));
                first = false;
            });

            sb.append(" }");
            return sb.str;
        }
    }

    public class ArrayConfigNode : ConfigNode {

        construct {
            kind = ConfigNodeType.Array;
        }

        public Gee.ArrayList<ConfigNode> children {get; private set;}

        public ArrayConfigNode.yaml(Yaml.Document document, Yaml.Node node) {
            assert_true(node.type == Yaml.NodeType.SEQUENCE);
            children = new Gee.ArrayList<ConfigNode>();

            Yaml.NodeItem* item = (Yaml.NodeItem*) node.data_sequence_items_start;
            Yaml.NodeItem* top  = (Yaml.NodeItem*) node.data_sequence_items_top;

            while (item < top) {
                unowned Yaml.Node* val = (Yaml.Node*) document.get_node(*item);

                if (val != null) {
                    ConfigNode value = ConfigNode.fromYaml(document, *val);

                    children.add(value);
                }

                item++;
            }
        }

        public override string to_string() {
            var sb = new StringBuilder();
            sb.append("Array [");

            bool first = true;
            foreach (var child in children) {
                if (!first) sb.append(", ");
                sb.append(child.to_string());
                first = false;
            }

            sb.append("]");
            return sb.str;
        }
    }

    public class StringConfigNode : ConfigNode {

        construct {
            kind = ConfigNodeType.String;
        }

        public string value {get; private set;} 

        public StringConfigNode.yaml(Yaml.Document document, Yaml.Node node) {
            assert_true(node.type == Yaml.NodeType.SCALAR);

            value = node.data_scalar_value;
        }

        public override string to_string() {
            return "String \"%s\"".printf(value);
        }
    }

    public class IntegerConfigNode : ConfigNode {

        construct {
            kind = ConfigNodeType.Integer;
        }

        public int value {get; private set;} 

        public IntegerConfigNode.yaml(Yaml.Document document, Yaml.Node node) {
            assert_true(node.type == Yaml.NodeType.SCALAR);

            value = int.parse(node.data_scalar_value);
        }

        public override string to_string() {
            return "Integer %d".printf(value);
        }
    }

    public class FloatConfigNode : ConfigNode {

        construct {
            kind = ConfigNodeType.Float;
        }

        public float value {get; private set;} 

        public FloatConfigNode.yaml(Yaml.Document document, Yaml.Node node) {
            assert_true(node.type == Yaml.NodeType.SCALAR);

            value = float.parse(node.data_scalar_value);
        }

        public override string to_string() {
            return "Float %g".printf(value);
        }
    }

    public class BoolConfigNode : ConfigNode {

        construct {
            kind = ConfigNodeType.Bool;
        }

        public bool value {get; private set;} 

        public BoolConfigNode.yaml(Yaml.Document document, Yaml.Node node) {
            assert_true(node.type == Yaml.NodeType.SCALAR);

            value = bool.parse(node.data_scalar_value);
        }

        public override string to_string() {
            return "Bool %s".printf(value.to_string());
        }
    }
}

namespace Kappashell {
    public class QuoteManager {
        private static QuoteManager instance;

        public string quote { public get; private set; }
        private string path;

        public static QuoteManager get_default() {
            if(instance == null) {
                instance = new QuoteManager("/etc/kappashell/quotes.txt");
            }
            return instance;
        }

        public QuoteManager(string path) {
            this.path = path;
            quote = "Add custom quotes at %s\n".printf(path);

            var now = new DateTime.now_local();
            var seed = now.get_year() * 10000;
            seed += now.get_month() * 100;
            seed += now.get_day_of_month();

            print("%d\n", seed);

            var rng = new Rand.with_seed(seed);

            int count = 0;
            try {
                var file = File.new_for_path(path);
                var stream = new DataInputStream(file.read());

                string? line;
                while((line = stream.read_line()) != null) {
                    count++;

                    if(rng.int_range(0, count) == 0) {
                        quote = line;
                    }
                }

                stream.close();
            } catch(Error _) {
                // File not found. Ignore.
            }
        }
    }
}

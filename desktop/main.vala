using Kappashell.Common;

public class KappashellDesktop : Gtk.Application {
    public KappashellDesktop() {

    }

    public override void activate() {
        var win = new Gtk.ApplicationWindow(this);
        var btn = new Gtk.Button.with_label("Hello, World!");
        btn.clicked.connect(() => {
            greet("Desktop");
        });

        win.child = btn;
        win.present();
    }
}

public int main(string[] args) {
    var app = new KappashellDesktop();
    return app.run(args);
}

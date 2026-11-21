public class WallpaperConfig : Object {
    // env override is handy when developing outside NixOS
    private static string path () {
        return Environment.get_variable ("KAPPASHELL_WALLPAPERS")
            ?? "/etc/kappashell/wallpapers.ini";
    }

    private KeyFile kf = new KeyFile ();

    public WallpaperConfig () {
        try {
            kf.load_from_file (path (), KeyFileFlags.NONE);
        } catch (Error e) {
            warning ("Could not load wallpaper config: %s", e.message);
        }
    }

    public string? default_wallpaper () {
        try { return kf.get_string ("general", "default"); } catch (Error e) { return null; }
    }

    public string? for_user (string username) {
        try { return kf.get_string ("users", username); } catch (Error e) { return null; }
    }

    public string[] all_paths () {
        string[] result = {};
        var d = default_wallpaper ();
        if (d != null) result += d;
        try {
            foreach (var key in kf.get_keys ("users"))
                result += kf.get_string ("users", key);
        } catch (Error e) {}
        return result;
    }
}

public class WallpaperView : Gtk.Widget {
    public uint duration_ms { get; set; default = 600; }

    private HashTable<string, Gdk.Texture> cache = new HashTable<string, Gdk.Texture> (str_hash, str_equal);
    private Gdk.Texture? from_tex = null;
    private Gdk.Texture? to_tex = null;
    private double progress = 1.0;
    private uint tick_id = 0;
    private int64 start_time = 0;

    construct {
        hexpand = true;
        vexpand = true;
        overflow = Gtk.Overflow.HIDDEN;
    }

    public void preload (string path) {
        load(path);
    }

    private Gdk.Texture? load (string path) {
        var cached = cache.lookup(path);
        if (cached != null) return cached;
        try {
            var tex = Gdk.Texture.from_filename(path);
            cache.insert (path, tex);
            return tex;
        } catch (Error e) {
            warning ("Failed to load %s: %s", path, e.message);
            return null;
        }
    }

    public void set_wallpaper (string path, bool animate = true) {
        var tex = load (path);
        if (tex == null || tex == to_tex) return;

        stop_tick();
        // If interrupted mid-fade, snap to the target and fade from there.
        from_tex = to_tex;
        to_tex = tex;

        if (!animate || from_tex == null) {
            from_tex = null;
            progress = 1.0;
            queue_draw();
            return;
        }

        progress = 0.0;
        start_time = 0;
        tick_id = add_tick_callback ((w, clock) => {
            var now = clock.get_frame_time();
            if (start_time == 0) start_time = now;
            double t = (double) (now - start_time) / (duration_ms * 1000.0);
            if (t >= 1.0) {
                progress = 1.0;
                from_tex = null;
                tick_id = 0;
                queue_draw ();
                return Source.REMOVE;
            }
            progress = t * t * (3.0 - 2.0 * t); // smoothstep
            queue_draw ();
            return Source.CONTINUE;
        });
    }

    private void stop_tick () {
        if (tick_id != 0) {
            remove_tick_callback(tick_id);
            tick_id = 0;
        }
    }

    public override void dispose() {
        stop_tick ();
        base.dispose ();
    }

    public override void snapshot (Gtk.Snapshot s) {
        float w = (float) get_width();
        float h = (float) get_height();
        if (w <= 0 || h <= 0) return;

        if (from_tex != null && progress < 1.0)
            draw_cover(s, from_tex, w, h);

        if (to_tex != null) {
            s.push_opacity(progress);
            draw_cover(s, to_tex, w, h);
            s.pop();
        }
    }

    // CSS "background-size: cover", centered
    private void draw_cover (Gtk.Snapshot s, Gdk.Texture t, float w, float h) {
        float iw = t.get_width();
        float ih = t.get_height();
        float scale = float.max(w / iw, h / ih);
        float dw = iw * scale;
        float dh = ih * scale;

        var bounds = Graphene.Rect();
        bounds.init((w - dw) / 2, (h - dh) / 2, dw, dh);
        s.append_texture(t, bounds);
    }
}

public class Background : Astal.Window {
    private WallpaperView view = new WallpaperView ();
    private WallpaperConfig config;

    public Background (Gtk.Application app, WallpaperConfig config, Gdk.Monitor? monitor = null) {
        Object(application: app);
        this.config = config;

        namespace = "kappashell-background";
        layer = Astal.Layer.BACKGROUND;
        exclusivity = Astal.Exclusivity.IGNORE;
        anchor = Astal.WindowAnchor.TOP | Astal.WindowAnchor.BOTTOM
               | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.RIGHT;
        if (monitor != null) gdkmonitor = monitor;

        child = view;

        // Decode everything up front so user switches never stall on I/O
        foreach (var p in config.all_paths())
            view.preload (p);

        var def = config.default_wallpaper();
        if (def != null) view.set_wallpaper(def, false);

        present();
    }

    public void show_user(string? username) {
        var path = (username != null ? config.for_user(username) : null)
                   ?? config.default_wallpaper();
        if (path != null) view.set_wallpaper(path, true);
    }
} 

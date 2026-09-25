namespace Kappashell {
    public class MusicPopup : PopupContent {

        private static AstalMpris.Mpris mpris = AstalMpris.get_default();

        public static MusicPopup create(ConfigNode config) throws PopupConfigError {
            return new MusicPopup();
        }

        public override Gtk.Widget build (Kappashell.PopupEnvironment environment) {
            var box = new Gtk.Box(environment.orientation, 10);
            box.add_css_class("inset");

            var carousel = new Adw.Carousel();
            box.append(carousel);

            foreach(var player in mpris.players) {
                carousel.append(createPlayer(player, environment));
            }

            if(carousel.get_n_pages() == 0) {
                carousel.append(new Gtk.Label("No active audio players."));
            }

            mpris.player_added.connect((player) => {
                carousel.append(createPlayer(player, environment));
            });

            return box;
        }

        public Gtk.Widget createPlayer(AstalMpris.Player player, Kappashell.PopupEnvironment environment) {
            var overlay = new Gtk.Overlay();
            overlay.hexpand = true;
            overlay.vexpand = true;
            overlay.set_child(new PlaybackBackgroundWidget(player));
            var controls = new PlaybackControlsWidget(player);
            overlay.add_overlay(controls);

            return overlay;
        }
    }

    public class PlaybackControlsWidget : Gtk.Box {
        AstalMpris.Player player;

        Gtk.CssProvider cover_css_provider;
        Gtk.Label title_label;
        Gtk.Label album_artist_label;
        Gtk.Button prev_btn;
        Gtk.Button next_btn;
        Gtk.Button toggle_btn;
        Gtk.Scale slider;

        ulong cover_art_notify_id;
        ulong title_notify_id;
        ulong album_notify_id;
        ulong artist_notify_id;
        ulong can_go_next_notify_id;
        ulong length_notify_id;
        ulong position_notify_id;
        ulong playback_status_notify_id;

        public PlaybackControlsWidget(AstalMpris.Player player) {
            Object(orientation: Gtk.Orientation.HORIZONTAL, spacing: 20);

            this.player = player;

            add_css_class("playback-controls");
            margin_top = 20;
            margin_bottom = 20;
            margin_start = 20;
            margin_end = 20;

            // --- Cover art ---
            var cover = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
            cover.add_css_class("playback-widget");
            cover.set_size_request(80, 80);
            cover.valign = Gtk.Align.CENTER;

            cover_css_provider = new Gtk.CssProvider();
            add_widget_css(cover, cover_css_provider);
            update_cover_css(player.cover_art);
            cover_art_notify_id = player.notify["cover-art"].connect(() => update_cover_css(player.cover_art));

            append(cover);

            // --- Title / artist / transport ---
            var info_box = new Gtk.Box(Gtk.Orientation.VERTICAL, 10);
            info_box.valign = Gtk.Align.CENTER;
            info_box.hexpand = true;

            title_label = new Gtk.Label(player.title);
            title_label.add_css_class("connectable-title");
            title_notify_id = player.notify["title"].connect(() => title_label.label = player.title);
            info_box.append(title_label);

            album_artist_label = new Gtk.Label(compute_album_artist(player.album, player.artist));
            album_notify_id = player.notify["album"].connect(() => update_album_artist());
            artist_notify_id = player.notify["artist"].connect(() => update_album_artist());
            info_box.append(album_artist_label);

            var transport_box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);

            // NOTE: both buttons gate on `can_go_next` in the original JSX —
            // kept as-is below, but the previous button probably wants `can_go_previous`.
            prev_btn = new Gtk.Button();
            prev_btn.icon_name = "media-skip-backward";
            prev_btn.visible = player.can_go_next;
            prev_btn.clicked.connect(() => player.previous());
            transport_box.append(prev_btn);

            slider = new Gtk.Scale.with_range(Gtk.Orientation.HORIZONTAL, 0, double.max(player.length, 1), 1);
            slider.hexpand = true;
            slider.draw_value = false;
            slider.set_range(0, player.length > 0 ? player.length : 100);
            slider.set_value(player.position);
            slider.change_value.connect((scroll, val) => {
                if (player.can_seek) {
                    player.position = val;
                }
                return false; // let the slider's own value still update visually
            });
            length_notify_id = player.notify["length"].connect(() => slider.set_range(0, player.length > 0 ? player.length : 100));
            position_notify_id = player.notify["position"].connect(() => slider.set_value(player.position));
            transport_box.append(slider);

            next_btn = new Gtk.Button();
            next_btn.icon_name = "media-skip-forward";
            next_btn.visible = player.can_go_next;
            next_btn.clicked.connect(() => player.next());
            transport_box.append(next_btn);

            can_go_next_notify_id = player.notify["can-go-next"].connect(() => {
                prev_btn.visible = player.can_go_next;
                next_btn.visible = player.can_go_next;
            });

            info_box.append(transport_box);
            append(info_box);

            // --- Play/pause toggle ---
            toggle_btn = new Gtk.Button();
            toggle_btn.icon_name = playback_status_icon(player.playback_status);
            toggle_btn.add_css_class("playback-toggle");
            toggle_btn.valign = Gtk.Align.CENTER;
            toggle_btn.clicked.connect(() => player.play_pause());
            playback_status_notify_id = player.notify["playback-status"].connect(() => {
                toggle_btn.icon_name = playback_status_icon(player.playback_status);
            });
            append(toggle_btn);
        }

        void update_cover_css(string cover_art) {
            cover_css_provider.load_from_string(
                @".playback-widget { 
                    background-image: url(\"file://$cover_art\"); 
                    background-position: center;
                    background-repeat: no-repeat;
                    background-size: contain;
                    border-radius: 10px;
                }"
            );
        }

        void update_album_artist() {
            album_artist_label.label = compute_album_artist(player.album, player.artist);
        }

        string compute_album_artist(string? album, string? artist) {
            if (album != null && album != "" && artist != null && artist != "")
                return @"$album - $artist";
            if (album != null && album != "")
                return album;
            if (artist != null && artist != "")
                return artist;
            return "Unknown Artist";
        }

        private string playback_status_icon(AstalMpris.PlaybackStatus status) {
            switch(status) {
                case AstalMpris.PlaybackStatus.PAUSED:
                case AstalMpris.PlaybackStatus.STOPPED:
                    return "media-playback-start-symbolic";
                case AstalMpris.PlaybackStatus.PLAYING:
                    return "media-playback-pause-symbolic";
            }
            return "";
        }

        public override void dispose() {
            if (cover_art_notify_id != 0) { player.disconnect(cover_art_notify_id); cover_art_notify_id = 0; }
            if (title_notify_id != 0) { player.disconnect(title_notify_id); title_notify_id = 0; }
            if (album_notify_id != 0) { player.disconnect(album_notify_id); album_notify_id = 0; }
            if (artist_notify_id != 0) { player.disconnect(artist_notify_id); artist_notify_id = 0; }
            if (can_go_next_notify_id != 0) { player.disconnect(can_go_next_notify_id); can_go_next_notify_id = 0; }
            if (length_notify_id != 0) { player.disconnect(length_notify_id); length_notify_id = 0; }
            if (position_notify_id != 0) { player.disconnect(position_notify_id); position_notify_id = 0; }
            if (playback_status_notify_id != 0) { player.disconnect(playback_status_notify_id); playback_status_notify_id = 0; }
            base.dispose();
        }
    }

    private class PlaybackBackgroundWidget : Gtk.Box {
        AstalMpris.Player player;
        Gtk.CssProvider css_provider;
        ulong cover_art_notify_id;

        public PlaybackBackgroundWidget(AstalMpris.Player player) {
            this.player = player;

            set_size_request(200, 100);

            add_css_class("playback-background-widget");

            css_provider = new Gtk.CssProvider();
            add_widget_css(this, css_provider);

            update_css(player.cover_art);

            cover_art_notify_id = player.notify["cover-art"].connect(() => {
                update_css(player.cover_art);
            });
        }

        void update_css(string cover_art) {
            css_provider.load_from_string(
                @".playback-background-widget { 
                    background-image: url(\"file://$cover_art\"); filter: brightness(0.125); 
                    background-position: center;
                    background-repeat: no-repeat;
                    background-size: cover;
                    border-radius: 20px;
                    box-shadow: inset -2px -2px 10px shade(@base-color, 0.5);
                }"
            );
        }

        public override void dispose() {
            if (cover_art_notify_id != 0) {
                player.disconnect(cover_art_notify_id);
                cover_art_notify_id = 0;
            }
            base.dispose();
        }
    }
}

pub const ext = @import("ext.zig");
const astalmpris = @This();

const std = @import("std");
const compat = @import("compat");
const glib = @import("glib2");
const gio = @import("gio2");
const gobject = @import("gobject2");
const gmodule = @import("gmodule2");
/// Manager object that monitors the session DBus for Mpris players to appear and disappear.
pub const Mpris = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{gio.ListModel};
    pub const Class = astalmpris.MprisClass;
    f_parent_instance: gobject.Object,
    f_priv: ?*astalmpris.MprisPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// List of currently available players.
        pub const players = struct {
            pub const name = "players";

            pub const Type = ?**glib.List;
        };
    };

    pub const signals = struct {
        /// Emitted when a new mpris Player appears.
        pub const player_added = struct {
            pub const name = "player-added";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_player: **astalmpris.Player, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Mpris, p_instance))),
                    gobject.signalLookup("player-added", Mpris.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };

        /// Emitted when a Player disappears.
        pub const player_closed = struct {
            pub const name = "player-closed";

            pub fn connect(p_instance: anytype, comptime P_Data: type, p_callback: *const fn (@TypeOf(p_instance), p_player: **astalmpris.Player, P_Data) callconv(.c) void, p_data: P_Data, p_options: gobject.ext.ConnectSignalOptions(P_Data)) c_ulong {
                return gobject.signalConnectClosureById(
                    @ptrCast(@alignCast(gobject.ext.as(Mpris, p_instance))),
                    gobject.signalLookup("player-closed", Mpris.getGObjectType()),
                    glib.quarkFromString(p_options.detail orelse null),
                    gobject.CClosure.new(@ptrCast(p_callback), p_data, @ptrCast(p_options.destroyData)),
                    @intFromBool(p_options.after),
                );
            }
        };
    };

    /// Gets the default singleton Mpris instance.
    extern fn astal_mpris_mpris_get_default() *astalmpris.Mpris;
    pub const getDefault = astal_mpris_mpris_get_default;

    extern fn astal_mpris_mpris_new() *astalmpris.Mpris;
    pub const new = astal_mpris_mpris_new;

    extern fn astal_mpris_mpris_get_players(p_self: *Mpris) *glib.List;
    pub const getPlayers = astal_mpris_mpris_get_players;

    extern fn astal_mpris_mpris_get_type() usize;
    pub const getGObjectType = astal_mpris_mpris_get_type;

    extern fn g_object_ref(p_self: *astalmpris.Mpris) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalmpris.Mpris) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Mpris, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Object which tracks players through their mpris DBus interface. The most simple way is to use `astalmpris.Mpris` which tracks
/// every player, but `astalmpris.Player` can be constructed for dedicated players too.
pub const Player = extern struct {
    pub const Parent = gobject.Object;
    pub const Implements = [_]type{};
    pub const Class = astalmpris.PlayerClass;
    f_parent_instance: gobject.Object,
    f_priv: ?*astalmpris.PlayerPrivate,

    pub const virtual_methods = struct {};

    pub const properties = struct {
        /// Full dbus nama of this player.
        pub const bus_name = struct {
            pub const name = "bus-name";

            pub const Type = ?[*:0]u8;
        };

        /// Indicates if `astalmpris.Player.properties.bus_name` is available on dbus.
        pub const available = struct {
            pub const name = "available";

            pub const Type = c_int;
        };

        /// Indicates if `astalmpris.Player.quit` has any effect.
        pub const can_quit = struct {
            pub const name = "can-quit";

            pub const Type = c_int;
        };

        /// Indicates if the player is occupying the fullscreen. This is typically used for videos. Use `astalmpris.Player.toggleFullscreen`
        /// to toggle fullscreen state.
        pub const fullscreen = struct {
            pub const name = "fullscreen";

            pub const Type = c_int;
        };

        /// Indicates if `astalmpris.Player.toggleFullscreen` has any effect.
        pub const can_set_fullscreen = struct {
            pub const name = "can-set-fullscreen";

            pub const Type = c_int;
        };

        /// Indicates if `astalmpris.Player.raise` has any effect.
        pub const can_raise = struct {
            pub const name = "can-raise";

            pub const Type = c_int;
        };

        /// A human friendly name to identify the player.
        pub const identity = struct {
            pub const name = "identity";

            pub const Type = ?[*:0]u8;
        };

        /// The base name of a .desktop file
        pub const entry = struct {
            pub const name = "entry";

            pub const Type = ?[*:0]u8;
        };

        /// The URI schemes supported by the media player. This can be viewed as protocols supported by the player in almost all cases. Almost every media
        /// player will include support for the "file" scheme. Other common schemes are "http" and "rtsp".
        pub const supported_uri_schemes = struct {
            pub const name = "supported-uri-schemes";

            pub const Type = ?[*][*:0]u8;
        };

        /// The mime-types supported by the player.
        pub const supported_mime_types = struct {
            pub const name = "supported-mime-types";

            pub const Type = ?[*][*:0]u8;
        };

        /// The current loop/repeat status.
        pub const loop_status = struct {
            pub const name = "loop-status";

            pub const Type = astalmpris.Loop;
        };

        /// The current shuffle status.
        pub const shuffle_status = struct {
            pub const name = "shuffle-status";

            pub const Type = astalmpris.Shuffle;
        };

        /// The current playback rate.
        pub const rate = struct {
            pub const name = "rate";

            pub const Type = f64;
        };

        /// The current volume level between 0 and 1 or -1 when it is unsupported.
        pub const volume = struct {
            pub const name = "volume";

            pub const Type = f64;
        };

        /// The current position of the track in seconds or -1 when it is unsupported. To get a progress percentage simply divide this with [property
        /// `AstalMpris`.Player:length].
        pub const position = struct {
            pub const name = "position";

            pub const Type = f64;
        };

        /// The current playback status.
        pub const playback_status = struct {
            pub const name = "playback-status";

            pub const Type = astalmpris.PlaybackStatus;
        };

        /// The minimum value which the `astalmpris.Player.properties.rate` can take.
        pub const minimum_rate = struct {
            pub const name = "minimum-rate";

            pub const Type = f64;
        };

        /// The maximum value which the `astalmpris.Player.properties.rate` can take.
        pub const maximum_rate = struct {
            pub const name = "maximum-rate";

            pub const Type = f64;
        };

        /// Indicates if invoking `astalmpris.Player.next` has effect.
        pub const can_go_next = struct {
            pub const name = "can-go-next";

            pub const Type = c_int;
        };

        /// Indicates if invoking `astalmpris.Player.previous` has effect.
        pub const can_go_previous = struct {
            pub const name = "can-go-previous";

            pub const Type = c_int;
        };

        /// Indicates if invoking `astalmpris.Player.play` has effect.
        pub const can_play = struct {
            pub const name = "can-play";

            pub const Type = c_int;
        };

        /// Indicates if invoking `astalmpris.Player.pause` has effect.
        pub const can_pause = struct {
            pub const name = "can-pause";

            pub const Type = c_int;
        };

        /// Indicates if setting `astalmpris.Player.properties.position` has effect.
        pub const can_seek = struct {
            pub const name = "can-seek";

            pub const Type = c_int;
        };

        /// Indicates if the player can be controlled with methods such as `astalmpris.Player.playPause`.
        pub const can_control = struct {
            pub const name = "can-control";

            pub const Type = c_int;
        };

        /// Metadata of this player.
        pub const metadata = struct {
            pub const name = "metadata";

            pub const Type = ?**glib.Variant;
        };

        /// Currently playing track's id.
        pub const trackid = struct {
            pub const name = "trackid";

            pub const Type = ?[*:0]u8;
        };

        /// Length of the currently playing track in seconds.
        pub const length = struct {
            pub const name = "length";

            pub const Type = f64;
        };

        /// The location of an image representing the track or album. You might prefer using `astalmpris.Player.properties.cover_art`.
        pub const art_url = struct {
            pub const name = "art-url";

            pub const Type = ?[*:0]u8;
        };

        /// Title of the currently playing album.
        pub const album = struct {
            pub const name = "album";

            pub const Type = ?[*:0]u8;
        };

        /// Artists of the currently playing album.
        pub const album_artist = struct {
            pub const name = "album-artist";

            pub const Type = ?[*:0]u8;
        };

        /// Artists of the currently playing track.
        pub const artist = struct {
            pub const name = "artist";

            pub const Type = ?[*:0]u8;
        };

        /// Lyrics of the currently playing track.
        pub const lyrics = struct {
            pub const name = "lyrics";

            pub const Type = ?[*:0]u8;
        };

        /// Title of the currently playing track.
        pub const title = struct {
            pub const name = "title";

            pub const Type = ?[*:0]u8;
        };

        /// Composers of the currently playing track.
        pub const composer = struct {
            pub const name = "composer";

            pub const Type = ?[*:0]u8;
        };

        /// Comments of the currently playing track.
        pub const comments = struct {
            pub const name = "comments";

            pub const Type = ?[*:0]u8;
        };

        /// Path of the cached `astalmpris.Player.properties.art_url`.
        pub const cover_art = struct {
            pub const name = "cover-art";

            pub const Type = ?[*:0]u8;
        };
    };

    pub const signals = struct {};

    /// Construct a Player that tracks a dbus name. For example "org.mpris.MediaPlayer2.spotify". The "org.mpris.MediaPlayer2."
    /// prefix can be omitted so simply "spotify" would mean the same. `astalmpris.Player.properties.available` indicates whether the player
    /// is actually running or not.
    extern fn astal_mpris_player_new(p_name: [*:0]const u8) *astalmpris.Player;
    pub const new = astal_mpris_player_new;

    /// Brings the player's user interface to the front using any appropriate mechanism available. The media player may be unable to control how
    /// its user interface is displayed, or it may not have a graphical user interface at all. In this case, the [property@
    /// AstalMpris.Player:can_raise] is `false` and this method does nothing.
    extern fn astal_mpris_player_raise(p_self: *Player) void;
    pub const raise = astal_mpris_player_raise;

    /// Causes the media player to stop running. The media player may refuse to allow clients to shut it down. In this case, the [property@
    /// AstalMpris.Player:can_quit] property is false and this method does nothing.
    extern fn astal_mpris_player_quit(p_self: *Player) void;
    pub const quit = astal_mpris_player_quit;

    /// Toggle `astalmpris.Player.properties.fullscreen` state.
    extern fn astal_mpris_player_toggle_fullscreen(p_self: *Player) void;
    pub const toggleFullscreen = astal_mpris_player_toggle_fullscreen;

    /// Skips to the next track in the tracklist. If there is no next track (and endless playback and track repeat are both off), stop
    /// playback. If `astalmpris.Player.properties.can_go_next` is `false` this method has no effect.
    extern fn astal_mpris_player_next(p_self: *Player) void;
    pub const next = astal_mpris_player_next;

    /// Skips to the previous track in the tracklist. If there is no previous track (and endless playback and track repeat are both off),
    /// stop playback. If `astalmpris.Player.properties.can_go_previous` is `false` this method has no effect.
    extern fn astal_mpris_player_previous(p_self: *Player) void;
    pub const previous = astal_mpris_player_previous;

    /// Pauses playback. If playback is already paused, this has no effect. If `astalmpris.Player.properties.can_pause` is `false` this method has
    /// no effect.
    extern fn astal_mpris_player_pause(p_self: *Player) void;
    pub const pause = astal_mpris_player_pause;

    /// Pauses playback. If playback is already paused, resumes playback. If playback is stopped, starts playback.
    extern fn astal_mpris_player_play_pause(p_self: *Player) void;
    pub const playPause = astal_mpris_player_play_pause;

    /// Stops playback. If playback is already stopped, this has no effect. If `astalmpris.Player.properties.can_control` is `false` this method
    /// has no effect.
    extern fn astal_mpris_player_stop(p_self: *Player) void;
    pub const stop = astal_mpris_player_stop;

    /// Starts or resumes playback. If already playing, this has no effect. If paused, playback resumes from the current position. If [property@
    /// AstalMpris.Player:can_play] is `false` this method has no effect.
    extern fn astal_mpris_player_play(p_self: *Player) void;
    pub const play = astal_mpris_player_play;

    /// uri scheme should be an element of `astalmpris.Player.properties.supported_uri_schemes` and the mime-type should match one of the elements
    /// of `astalmpris.Player.properties.supported_mime_types`.
    extern fn astal_mpris_player_open_uri(p_self: *Player, p_uri: [*:0]const u8) void;
    pub const openUri = astal_mpris_player_open_uri;

    /// Change `astalmpris.Player.properties.loop_status` from none to track, from track to playlist, from playlist to none.
    extern fn astal_mpris_player_loop(p_self: *Player) void;
    pub const loop = astal_mpris_player_loop;

    /// Toggle `astalmpris.Player.properties.shuffle_status`.
    extern fn astal_mpris_player_shuffle(p_self: *Player) void;
    pub const shuffle = astal_mpris_player_shuffle;

    /// Lookup a key from `astalmpris.Player.properties.metadata`. This method is useful for languages that fail to introspect hashtables.
    extern fn astal_mpris_player_get_meta(p_self: *Player, p_key: [*:0]const u8) ?*glib.Variant;
    pub const getMeta = astal_mpris_player_get_meta;

    extern fn astal_mpris_player_get_bus_name(p_self: *Player) [*:0]const u8;
    pub const getBusName = astal_mpris_player_get_bus_name;

    extern fn astal_mpris_player_get_available(p_self: *Player) c_int;
    pub const getAvailable = astal_mpris_player_get_available;

    extern fn astal_mpris_player_get_can_quit(p_self: *Player) c_int;
    pub const getCanQuit = astal_mpris_player_get_can_quit;

    extern fn astal_mpris_player_get_fullscreen(p_self: *Player) c_int;
    pub const getFullscreen = astal_mpris_player_get_fullscreen;

    extern fn astal_mpris_player_get_can_set_fullscreen(p_self: *Player) c_int;
    pub const getCanSetFullscreen = astal_mpris_player_get_can_set_fullscreen;

    extern fn astal_mpris_player_get_can_raise(p_self: *Player) c_int;
    pub const getCanRaise = astal_mpris_player_get_can_raise;

    extern fn astal_mpris_player_get_identity(p_self: *Player) [*:0]const u8;
    pub const getIdentity = astal_mpris_player_get_identity;

    extern fn astal_mpris_player_get_entry(p_self: *Player) [*:0]const u8;
    pub const getEntry = astal_mpris_player_get_entry;

    extern fn astal_mpris_player_get_supported_uri_schemes(p_self: *Player, p_result_length1: *c_int) [*][*:0]u8;
    pub const getSupportedUriSchemes = astal_mpris_player_get_supported_uri_schemes;

    extern fn astal_mpris_player_get_supported_mime_types(p_self: *Player, p_result_length1: *c_int) [*][*:0]u8;
    pub const getSupportedMimeTypes = astal_mpris_player_get_supported_mime_types;

    extern fn astal_mpris_player_get_loop_status(p_self: *Player) astalmpris.Loop;
    pub const getLoopStatus = astal_mpris_player_get_loop_status;

    extern fn astal_mpris_player_set_loop_status(p_self: *Player, p_value: astalmpris.Loop) void;
    pub const setLoopStatus = astal_mpris_player_set_loop_status;

    extern fn astal_mpris_player_get_shuffle_status(p_self: *Player) astalmpris.Shuffle;
    pub const getShuffleStatus = astal_mpris_player_get_shuffle_status;

    extern fn astal_mpris_player_set_shuffle_status(p_self: *Player, p_value: astalmpris.Shuffle) void;
    pub const setShuffleStatus = astal_mpris_player_set_shuffle_status;

    extern fn astal_mpris_player_get_rate(p_self: *Player) f64;
    pub const getRate = astal_mpris_player_get_rate;

    extern fn astal_mpris_player_set_rate(p_self: *Player, p_value: f64) void;
    pub const setRate = astal_mpris_player_set_rate;

    extern fn astal_mpris_player_get_volume(p_self: *Player) f64;
    pub const getVolume = astal_mpris_player_get_volume;

    extern fn astal_mpris_player_set_volume(p_self: *Player, p_value: f64) void;
    pub const setVolume = astal_mpris_player_set_volume;

    extern fn astal_mpris_player_get_position(p_self: *Player) f64;
    pub const getPosition = astal_mpris_player_get_position;

    extern fn astal_mpris_player_set_position(p_self: *Player, p_value: f64) void;
    pub const setPosition = astal_mpris_player_set_position;

    extern fn astal_mpris_player_get_playback_status(p_self: *Player) astalmpris.PlaybackStatus;
    pub const getPlaybackStatus = astal_mpris_player_get_playback_status;

    extern fn astal_mpris_player_get_minimum_rate(p_self: *Player) f64;
    pub const getMinimumRate = astal_mpris_player_get_minimum_rate;

    extern fn astal_mpris_player_get_maximum_rate(p_self: *Player) f64;
    pub const getMaximumRate = astal_mpris_player_get_maximum_rate;

    extern fn astal_mpris_player_get_can_go_next(p_self: *Player) c_int;
    pub const getCanGoNext = astal_mpris_player_get_can_go_next;

    extern fn astal_mpris_player_get_can_go_previous(p_self: *Player) c_int;
    pub const getCanGoPrevious = astal_mpris_player_get_can_go_previous;

    extern fn astal_mpris_player_get_can_play(p_self: *Player) c_int;
    pub const getCanPlay = astal_mpris_player_get_can_play;

    extern fn astal_mpris_player_get_can_pause(p_self: *Player) c_int;
    pub const getCanPause = astal_mpris_player_get_can_pause;

    extern fn astal_mpris_player_get_can_seek(p_self: *Player) c_int;
    pub const getCanSeek = astal_mpris_player_get_can_seek;

    extern fn astal_mpris_player_get_can_control(p_self: *Player) c_int;
    pub const getCanControl = astal_mpris_player_get_can_control;

    extern fn astal_mpris_player_get_metadata(p_self: *Player) *glib.Variant;
    pub const getMetadata = astal_mpris_player_get_metadata;

    extern fn astal_mpris_player_get_trackid(p_self: *Player) [*:0]const u8;
    pub const getTrackid = astal_mpris_player_get_trackid;

    extern fn astal_mpris_player_get_length(p_self: *Player) f64;
    pub const getLength = astal_mpris_player_get_length;

    extern fn astal_mpris_player_get_art_url(p_self: *Player) [*:0]const u8;
    pub const getArtUrl = astal_mpris_player_get_art_url;

    extern fn astal_mpris_player_get_album(p_self: *Player) [*:0]const u8;
    pub const getAlbum = astal_mpris_player_get_album;

    extern fn astal_mpris_player_get_album_artist(p_self: *Player) [*:0]const u8;
    pub const getAlbumArtist = astal_mpris_player_get_album_artist;

    extern fn astal_mpris_player_get_artist(p_self: *Player) [*:0]const u8;
    pub const getArtist = astal_mpris_player_get_artist;

    extern fn astal_mpris_player_get_lyrics(p_self: *Player) [*:0]const u8;
    pub const getLyrics = astal_mpris_player_get_lyrics;

    extern fn astal_mpris_player_get_title(p_self: *Player) [*:0]const u8;
    pub const getTitle = astal_mpris_player_get_title;

    extern fn astal_mpris_player_get_composer(p_self: *Player) [*:0]const u8;
    pub const getComposer = astal_mpris_player_get_composer;

    extern fn astal_mpris_player_get_comments(p_self: *Player) [*:0]const u8;
    pub const getComments = astal_mpris_player_get_comments;

    extern fn astal_mpris_player_get_cover_art(p_self: *Player) [*:0]const u8;
    pub const getCoverArt = astal_mpris_player_get_cover_art;

    extern fn astal_mpris_player_get_type() usize;
    pub const getGObjectType = astal_mpris_player_get_type;

    extern fn g_object_ref(p_self: *astalmpris.Player) void;
    pub const ref = g_object_ref;

    extern fn g_object_unref(p_self: *astalmpris.Player) void;
    pub const unref = g_object_unref;

    pub fn as(p_instance: *Player, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MprisClass = extern struct {
    pub const Instance = astalmpris.Mpris;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *MprisClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const MprisPrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PlayerClass = extern struct {
    pub const Instance = astalmpris.Player;

    f_parent_class: gobject.ObjectClass,

    pub fn as(p_instance: *PlayerClass, comptime P_T: type) *P_T {
        return gobject.ext.as(P_T, p_instance);
    }

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PlayerPrivate = *opaque {
    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const PlaybackStatus = enum(c_int) {
    playing = 0,
    paused = 1,
    stopped = 2,
    _,

    extern fn astal_mpris_playback_status_get_type() usize;
    pub const getGObjectType = astal_mpris_playback_status_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Loop = enum(c_int) {
    unsupported = 0,
    none = 1,
    track = 2,
    playlist = 3,
    _,

    extern fn astal_mpris_loop_get_type() usize;
    pub const getGObjectType = astal_mpris_loop_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

pub const Shuffle = enum(c_int) {
    unsupported = 0,
    on = 1,
    off = 2,
    _,

    extern fn astal_mpris_shuffle_get_type() usize;
    pub const getGObjectType = astal_mpris_shuffle_get_type;

    test {
        @setEvalBranchQuota(100_000);
        std.testing.refAllDecls(@This());
    }
};

/// Gets the default singleton Mpris instance.
extern fn astal_mpris_get_default() *astalmpris.Mpris;
pub const getDefault = astal_mpris_get_default;

pub const MAJOR_VERSION = 0;
pub const MINOR_VERSION = 1;
pub const MICRO_VERSION = 0;
pub const VERSION = "0.1.0";

test {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(ext);
}

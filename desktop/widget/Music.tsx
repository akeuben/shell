import { Astal, Gdk, Gtk } from "ags/gtk4";
import Adw from "gi://Adw?version=1";
import AstalMpris from "gi://AstalMpris?version=0.1"
import { Accessor, createBinding, createComputed, createState, For, onCleanup, With } from "gnim";
import { WrappedMarqueeLabel } from "./Marquee";
import { IconButton } from "./IconButton";
import { KappashellMPD } from "../lib/mpd/mpd";
import { pointer } from "../util/cursor";
import Gio from "gi://Gio?version=2.0";
import GLib from "gi://GLib?version=2.0";
import { AsyncMutex } from "./AsyncMutex";


const mpris = AstalMpris.get_default();

const mpd = KappashellMPD.get_default();

const playbackStatusIcon = (status: AstalMpris.PlaybackStatus): string => {
    switch(status) {
        case AstalMpris.PlaybackStatus.PAUSED:
        case AstalMpris.PlaybackStatus.STOPPED:
            return "media-playback-start-symbolic";
        case AstalMpris.PlaybackStatus.PLAYING:
            return "media-playback-pause-symbolic";
    }
}

const PlaybackWidget = ({player, name}: {player: AstalMpris.Player, name: Accessor<string>}) => {
    const album_artist = createComputed([
        createBinding(player, "album"),
        createBinding(player, "artist"),
    ], (album, artist) => {
        if(album && artist) 
            return `${album} - ${artist}`
        if(album)
            return album;
        if(artist)
            return artist;
        return "Unknown Artist";
    })

    const can_seek = createComputed([
        createBinding(player, "can_seek"),
        createBinding(player, "entry")
    ], (can_seek, identity) => can_seek && (!identity || !identity.includes("g4music")))

    const overlay = Gtk.Overlay.new();
    overlay.hexpand = true;
    overlay.vexpand = true;
    overlay.css_classes = ["top-section-no-padding", "playback-overlay"];
    
    overlay.set_child(
        <box class="playback-widget" css={createBinding(player, "cover_art").as(c => `background-image: url(file://${c}); filter: brightness(0.125);`)}>
        </box> as Gtk.Widget
    )

    overlay.add_overlay(
        <box class="playback-controls" margin_bottom={20} margin_end={20} margin_top={20} margin_start={20} spacing={20}>
            <box class="playback-widget" css={createBinding(player, "cover_art").as(c => `background-image: url(file://${c});`)} width_request={64} height_request={64} valign={Gtk.Align.CENTER}/>
            <box orientation={Gtk.Orientation.VERTICAL} spacing={10} valign={Gtk.Align.CENTER} hexpand>
                <WrappedMarqueeLabel label={createBinding(player, "title")} cssClass="connectable-title" />
                <WrappedMarqueeLabel label={album_artist} />
                <box>
                    <With value={createBinding(player, "can_go_next")}>
                        {(can: boolean) => can && <IconButton className="" icon_name="media-skip-backward" pixel_size={16} onClicked={() => {player.previous()}} />}
                    </With>
                    <slider hexpand min={0} max={createBinding(player, "length")} value={createBinding(player, "position")} onChangeValue={(_a, _b, value) => {
                    if(can_seek.get()) {
                        player.set_position(value);
                    }
                }} />
                    <With value={createBinding(player, "can_go_next")}>
                        {(can: boolean) => can && <IconButton className="" icon_name="media-skip-forward" pixel_size={16} onClicked={() => {player.next();}} />}
                    </With>
                </box>
            </box>
            <IconButton className="playback-toggle"  valign={Gtk.Align.CENTER} icon_name={createBinding(player, "playback_status").as(playbackStatusIcon)} pixel_size={32} onClicked={() => {
                player.play_pause();
            }}/>
        </box> as Gtk.Widget
    );
    return overlay;
}

const MPRISWidget = () => {
    const [current, setCurrent] = createState<number>(-1);
    const players = createBinding(mpris, "players");

    mpris.connect("player-closed", () => {
        const c = current.get();
        if(c && c >= mpris.players.length - 1) {
            if(mpris.players.length === 0) {
                setCurrent(_ => -1);
                return;
            }
            setCurrent(mpris.players.length - 1);
        }
    })

    mpris.connect("player-added", () => {
        if(mpris.players.length === 1) {
            setCurrent(_ => 0);
        }
    })

    return <box class="top-section-no-padding" hexpand>
        <overlay hexpand>
            <Adw.Carousel hexpand vexpand>
                <With value={players}>
                    {players => players.length === 0 && <label label="nothing playing" />}
                </With>
                <For each={players}>
                    {(player, i) => <PlaybackWidget player={player} name={i.as(i => `${i}`)} $type="named" />}
                </For>
            </Adw.Carousel>
        </overlay>
    </box>
}

const TrackView = ({name, menu}: {name: string, menu: Gio.Menu}) => {
    const [tracklist, setTracklist] = createState<KappashellMPD.Song[]>([]);
    return <box name={name} orientation={Gtk.Orientation.VERTICAL} class="top-section" vexpand>
        <Gtk.Entry placeholder_text="Search All Tracks" hexpand onNotifyText={async (self) => {
            if(self.text.length >= 3) {
                try {
                    const songs = await mpd.search_songs(self.text, 'title');
                    setTracklist(songs);
                } catch(e) {
                    console.log(e);
                }
            } else {
                setTracklist([]);
            }
        }}/>
        <scrolledwindow vexpand hexpand vscrollbarPolicy={Gtk.PolicyType.AUTOMATIC} hscrollbar_policy={Gtk.PolicyType.NEVER}>
            <box orientation={Gtk.Orientation.VERTICAL} spacing={5}>
                <For each={tracklist}>
                    {(song: KappashellMPD.Song, index) => 
                        <MPDSongElement song={song} index={index} model={menu}/>
                    }
                </For>
            </box>
        </scrolledwindow>
    </box>
}

const PlaylistEditButton = ({playlist, setSelectedPlaylist}: {playlist: KappashellMPD.Playlist, setSelectedPlaylist: (arg0: KappashellMPD.Playlist | null) => void}) => {
    const popover = new Gtk.Popover();
    const popoverBox = new Gtk.Box();
    popover.set_child(popoverBox);

    const menuButton = new Gtk.MenuButton();
    menuButton.icon_name = "edit-symbolic";
    menuButton.popover = popover;

    const entry = new Gtk.Entry();
    entry.placeholder_text = "Rename Playlist";
    entry.connect("activate", () => {
        playlist.name = entry.text;
        popover.popdown();
    })

    const button = IconButton({className: "", icon_name: "remove-symbolic", pixel_size: 16, onClicked: () => {
        playlist.delete();
        popover.popdown();
        setSelectedPlaylist(null);
    }}) as Gtk.Button;

    popoverBox.append(entry);
    popoverBox.append(button as any);
    
    return menuButton;
}

const PlaylistEntry = ({playlist, setSelectedPlaylist}: {playlist: KappashellMPD.Playlist, selectedPlaylist: Accessor<KappashellMPD.Playlist | null>, setSelectedPlaylist: (pl: KappashellMPD.Playlist | null) => void}) => {
    return <box>
        <button cursor={pointer} hexpand onClicked={() => {
            setSelectedPlaylist(playlist);
        }}>
            <label label={createBinding(playlist, "name")} />
        </button>
        <PlaylistEditButton playlist={playlist} setSelectedPlaylist={setSelectedPlaylist} />
    </box>
}

const PlaylistView = ({name, menu}: {name: string, menu: Gio.Menu}) => {
    const [selectedPlaylist, setSelectedPlaylist] = createState<KappashellMPD.Playlist | null>(null);

    return <stack name={name} visible_child_name={selectedPlaylist.as(p => p ? "list" : "null")} transition_type={Gtk.StackTransitionType.SLIDE_LEFT_RIGHT} class="top-section">
        <box $type="named" name="null" orientation={Gtk.Orientation.VERTICAL} vexpand>
            <scrolledwindow vexpand hexpand vscrollbarPolicy={Gtk.PolicyType.AUTOMATIC} hscrollbar_policy={Gtk.PolicyType.NEVER}>
                <box orientation={Gtk.Orientation.VERTICAL} spacing={5}>
                    <For each={createBinding(mpd, "playlists")}>
                        {(playlist: KappashellMPD.Playlist) => <PlaylistEntry playlist={playlist} selectedPlaylist={selectedPlaylist} setSelectedPlaylist={setSelectedPlaylist} />}
                   </For>
                </box>
            </scrolledwindow>
        </box>
        <box $type="named" name={"list"} orientation={Gtk.Orientation.VERTICAL} vexpand>
            <With value={selectedPlaylist}>
                {playlist => !playlist ? <Astal.Bin /> :
                <box orientation={Gtk.Orientation.VERTICAL}>
                    <box>
                        <IconButton className="" icon_name="carousel-arrow-back-symbolic" pixel_size={24} onClicked={() => {
                            setSelectedPlaylist(null);
                        }} />
                        <label label={createBinding(playlist, "name")} hexpand />
                        <PlaylistEditButton playlist={playlist} setSelectedPlaylist={setSelectedPlaylist} />
                        <IconButton className="" icon_name="media-playback-start-symbolic" pixel_size={24} onClicked={() => {
                            playlist.play();
                        }} />
                    </box>
                    <scrolledwindow vexpand hexpand vscrollbarPolicy={Gtk.PolicyType.AUTOMATIC} hscrollbar_policy={Gtk.PolicyType.NEVER}>
                        <box orientation={Gtk.Orientation.VERTICAL}>
                            <For each={createBinding(playlist, "songs")}>
                                {(song: KappashellMPD.Song, index) => 
                                    <MPDSongElement song={song} index={index} currentPlaylist={selectedPlaylist} model={menu} />
                                }
                            </For>
                        </box>
                    </scrolledwindow>
                </box>
                }
            </With>
        </box>
    </stack>
}

const addAction = (group: Gio.SimpleActionGroup, name: string, paramType: null | string, actionCallback: (arg0: GLib.Variant | null) => void) => {
    try {
        let action = null;
        if(paramType) action = new Gio.SimpleAction({name, parameter_type: new GLib.VariantType(paramType)});
        else action = new Gio.SimpleAction({name});

        action.connect("activate", (_, param) => actionCallback(param));
        group.add_action(action);
    } catch(e) {
        console.log(e);
    }
}

function isWidgetVisibleInScrolledWindow(widget: Gtk.Widget, scrolledWindow: Gtk.ScrolledWindow) {
    let allocation = widget.get_allocation();
    let adj = scrolledWindow.get_vadjustment();
    let viewportTop = adj.get_value();
    let viewportBottom = viewportTop + adj.get_page_size();

    // Simple vertical intersection check
    return (
        allocation.y + allocation.height > viewportTop &&
        allocation.y < viewportBottom
    );
}

const albumArtMutex = new AsyncMutex();

function setupLazyAlbumArt(songWidget: Gtk.Widget, image: Gtk.Picture, song: KappashellMPD.Song, scrolledWindow: Gtk.ScrolledWindow | null) {
    let loaded = false;

    const tryLoad = async () => {
        if (loaded) return;
        if (!scrolledWindow || isWidgetVisibleInScrolledWindow(songWidget, scrolledWindow)) {
            loaded = true;
            try {
                await song.load_album_art();
                image.set_paintable(song.album_art);
            } catch(_) {}
        }
    };

    if(!scrolledWindow) {
        albumArtMutex.withLock(tryLoad);
        return;
    }

    // Re-check when scrolling or resizing happens
    let vadj = scrolledWindow.get_vadjustment();
    vadj.connect("value-changed", () => {
        albumArtMutex.withLock(tryLoad);
    });
    if(songWidget.get_mapped()) {
        albumArtMutex.withLock(tryLoad);
    } else {
        songWidget.connect("map", () => {
            albumArtMutex.withLock(tryLoad);
        });
    }
}

const MPDSongElement = ({song, currentPlaylist, index, model}: {song: KappashellMPD.Song, currentPlaylist?: Accessor<null | KappashellMPD.Playlist>, index: Accessor<number>, model: Gio.Menu}) => {
    const album_artist = createComputed([
        createBinding(song, "album"),
        createBinding(song, "artist"),
    ], (album, artist) => {
        if(album && artist) 
            return `${album} - ${artist}`
        if(album)
            return album;
        if(artist)
            return artist;
        return "Unknown Artist";
    })

    const addToQueue = () => mpd.queue.add(song);
    const playNext = () => mpd.queue.add(song, "+0");
    const playNow = async () => {
        await mpd.queue.add(song, "+0");
        await mpd.next();
    }
    const addToPlaylist = async (playlist: GLib.Variant | null) => {
        const pl = mpd.playlists.find(pl => pl.name === playlist?.get_string()[0] as string);

        if(!pl) {
            return await mpd.sendCommand("playlistadd", playlist?.get_string()[0] as string, song.file);
        }
        
        pl.add_song(song);
    }
    const removeFromPlaylist = async () => {
        if(!currentPlaylist) return;
        const playlist = currentPlaylist.get();
        if(!playlist) return;

        playlist.remove_song(index.get());
    }

    const newPlaylistEntry = new Gtk.Entry();
    newPlaylistEntry.set_placeholder_text("Enter playlist name");
    const connection = newPlaylistEntry.connect("activate", (self) => {
        addToPlaylist(GLib.Variant.new_string(self.text));
        newPlaylistEntry.text = "";
        const parent = newPlaylistEntry.parent.parent as Gtk.Popover;
        parent.popdown();
    });
    onCleanup(() => {
        newPlaylistEntry.disconnect(connection);
    })

    const popover = new Gtk.PopoverMenu();
    popover.set_menu_model(model);

    const picture = <Gtk.Picture content_fit={Gtk.ContentFit.COVER} can_shrink $={() => {
        onCleanup(() => console.log("Picture was destroyed"));
    }}/> as Gtk.Picture;

    const overlay = new Gtk.Overlay();
    overlay.set_child(
        <Gtk.AspectFrame ratio={1} width_request={70} class="album-art">
            {picture}
        </Gtk.AspectFrame> as Gtk.Widget 
    );
    overlay.add_overlay(
        <label class="album_art_placeholder" label={createComputed([createBinding(song, "album"), createBinding(song, "art_loaded")], (album, has_art) => {
            if(has_art) return "";
            return album ? album[0].toUpperCase() : "?";
        })}/> as Gtk.Widget
    )

    return <box class="queue-item" hexpand vexpand={false} valign={Gtk.Align.START} spacing={10} onMap={(self) => {
        let widget: Gtk.Widget = self;
        while(!(widget instanceof Gtk.ScrolledWindow)) {
            widget = widget.parent;

            if(widget === widget.root) {
                setupLazyAlbumArt(self, picture, song, null);
            }
        }
        setupLazyAlbumArt(self, picture, song, widget as Gtk.ScrolledWindow);
    }} $={() => {
        onCleanup(() => console.log("Song was destroyed"));
    }}>
        {overlay}
        <box orientation={Gtk.Orientation.VERTICAL} margin_end={5}>
            <IconButton className="" icon_name="list-add-symbolic" pixel_size={16} onClicked={addToQueue} />
            <IconButton className="" icon_name="media-playback-start-symbolic" pixel_size={16} onClicked={playNow} />
        </box>
        <box valign={Gtk.Align.CENTER} hexpand orientation={Gtk.Orientation.VERTICAL}>
            <WrappedMarqueeLabel label={song.title} />
            <WrappedMarqueeLabel label={album_artist} />
        </box>
        <menubutton valign={Gtk.Align.CENTER} icon_name="ui-menu-symbolic" popover={popover} $={(self) => {
            const newPlaylistPopover = new Gtk.Popover();
            newPlaylistPopover.set_child(newPlaylistEntry);
            newPlaylistPopover.set_parent(self);

            const group = new Gio.SimpleActionGroup();
            addAction(group, "add-to-playlist", "s", addToPlaylist)
            addAction(group, "play-next", null, playNext);
            addAction(group, "add-to-queue", null, addToQueue);
            addAction(group, "new-playlist", null, () => {
                newPlaylistPopover.popup();
                popover.popdown();
            })
            addAction(group, "remove-playlist", null, removeFromPlaylist);

            self.insert_action_group("menu", group);

            onCleanup(() => {
                newPlaylistPopover.unparent();
            });
        }}/>
    </box>
}

const MPDQueueElement = ({queue, song, current}: {queue: KappashellMPD.Queue, song: KappashellMPD.Song, current: Accessor<KappashellMPD.Song>}) => {
    const album_artist = createComputed([
        createBinding(song, "album"),
        createBinding(song, "artist"),
    ], (album, artist) => {
        if(album && artist) 
            return `${album} - ${artist}`
        if(album)
            return album;
        if(artist)
            return artist;
        return "Unknown Artist";
    })

    const isCurrent = current.as(c => c.id === song.id);
    const [hovered, setHovered] = createState<boolean>(false);

    const visible_child = createComputed([isCurrent, hovered], (isCurrent, hovered) => {
        if(isCurrent)
            return "selected";
        if(hovered)
            return "hovered";
        return "not_hovered";
    })

    return <box class={isCurrent.as(current => current ? "queue-current queue-item" : "queue-item")} hexpand vexpand={false} valign={Gtk.Align.START} name={song.pos} spacing={10} $={(self) => {
        const drag = Gtk.DragSource.new();
        drag.set_actions(Gdk.DragAction.MOVE);

        drag.connect("prepare", (_source, _x, _y) => {
            return Gdk.ContentProvider.new_for_value(song.pos);
        })

        self.add_controller(drag)
    }}>
        <stack visible_child_name={visible_child} $={(self) => {
            const controller = new Gtk.EventControllerMotion();

            controller.connect("enter", () => {
                setHovered(true);
            });
            controller.connect("leave", () => {
                setHovered(false);
            });

            self.add_controller(controller);
        }}>
            <image $type="named" name="selected" icon_name="view-media-playcount" />
            <label $type="named" name="not_hovered" label={song.pos} />
            <Astal.Bin $type="named" name="hovered">
                <IconButton icon_name="media-playback-start-symbolic" className="" pixel_size={16} onClicked={() => {
                    mpd.play(song.pos);
                }} />
            </Astal.Bin>
        </stack>
        <box hexpand orientation={Gtk.Orientation.VERTICAL}>
            <WrappedMarqueeLabel label={song.title} cssClass="connectable-title" />
            <WrappedMarqueeLabel label={album_artist} />
        </box>
        <IconButton className="" icon_name="remove-symbolic" pixel_size={16} onClicked={() => {
            queue.remove(song.pos);
        }} />
    </box>
}

const MusicPageWithMDP = ({name}: {name: string}) => {
    const grid = Gtk.Grid.new();
    grid.name = name;
    grid.row_homogeneous = true;
    grid.column_homogeneous = true;
    grid.set_column_spacing(10);
    grid.set_row_spacing(10);
    grid.margin_bottom = 10;
    grid.margin_top = 10;

    const current_song = createBinding(mpd, "current_song");

    const playlists = new Gio.Menu();
    for(const playlist of mpd.playlists) {
        playlists.append(playlist.name, `menu.add-to-playlist('${playlist.name}')`);
    }

    playlists.append("Create New Playlist", "menu.new-playlist");


    const connection = mpd.connect("notify::playlists", () => {
        playlists.remove_all();

        for(const playlist of mpd.playlists) {
            playlists.append(playlist.name, `menu.add-to-playlist('${playlist.name}')`);
        }

        playlists.append("Create New Playlist", "menu.new-playlist");
    });
    onCleanup(() => {
        mpd.disconnect(connection);
    });

    const playlistMenuModel = new Gio.Menu();
    const menuModel = new Gio.Menu();

    playlistMenuModel.append("Play Next", "menu.play-next");
    playlistMenuModel.append("Add To Queue", "menu.add-to-queue");
    playlistMenuModel.append("See Artist", "menu.artist");
    playlistMenuModel.append("See Album", "menu.album");
    menuModel.append("Play Next", "menu.play-next");
    menuModel.append("Add To Queue", "menu.add-to-queue");
    menuModel.append("See Artist", "menu.artist");
    menuModel.append("See Album", "menu.album");

    playlistMenuModel.append("Remove from Playlist", "menu.remove-playlist");
    menuModel.append_submenu("Add to Playlist", playlists);


    const queue = <scrolledwindow class="top-section" hexpand vscrollbarPolicy={Gtk.PolicyType.AUTOMATIC} hscrollbar_policy={Gtk.PolicyType.NEVER} $={(self) => {
        current_song.subscribe(() => {
            let current_child: Gtk.Widget | null = self.child.get_first_child()?.get_first_child() || null;
            for(; current_child !== null; current_child = current_child?.get_next_sibling() as Gtk.Widget) {
                if(current_child.name === current_song.get().pos) break;
            }

            if(current_child === null) {
                return;
            }
            
            const alloc = current_child.get_allocation();

            self.vadjustment.value = alloc.y;
        })
    }}> 
        <box orientation={Gtk.Orientation.VERTICAL} spacing={10} $={(self) => {
            const drop = new Gtk.DropTarget({
                actions: Gdk.DragAction.MOVE,
                formats: Gdk.ContentFormats.new_for_gtype(String.$gtype),
            });

            let indicator = new Gtk.Box(); // placeholder for line
            indicator.set_size_request(-1, 2);
            indicator.hexpand = true;
            indicator.set_css_classes(["drop-indicator"]);

            drop.connect("motion", (_target, _x, y) => {
                const scroll = self.get_parent() as Gtk.ScrolledWindow;
                const vadj = scroll.get_vadjustment();
                const alloc = scroll.get_allocation();
                const vy = y - vadj.value;
                const margin = 10;
                const step = 20;
                if (vy < margin) {
                    vadj.set_value(Math.max(vadj.get_lower(), vadj.get_value() - step));
                } else if (vy > alloc.height - margin) {
                    vadj.set_value(Math.min(vadj.get_upper() - vadj.get_page_size(), vadj.get_value() + step));
                }

                let insert_child = self.get_last_child() as Gtk.Widget;
                for (let child = self.get_first_child(); child !== null; child = child.get_next_sibling()) {
                    const alloc = child.get_allocation();
                    if (y < alloc.y + alloc.height) {
                        insert_child = child;
                        break;
                    }
                }

                if(indicator.get_prev_sibling() === insert_child) return Gdk.DragAction.MOVE;
                if(indicator.parent === self) 
                    self.remove(indicator);
                self.insert_child_after(indicator, insert_child);

                return Gdk.DragAction.MOVE;
            });

            drop.connect("drop", (target, source, x, y) => {
                self.remove(indicator);

                let insert_child = self.get_last_child() as Gtk.Widget;
                for (let child = self.get_first_child(); child !== null; child = child.get_next_sibling()) {
                    const alloc = child.get_allocation();
                    if (y < alloc.y + alloc.height) {
                        insert_child = child;
                        break;
                    }
                }

                mpd.queue.swap(source.toString(), insert_child.name);
            })

            self.add_controller(drop);
        }}>
            <For each={createBinding(mpd.queue, "songs")}>
                {(song: KappashellMPD.Song) => {
                    return <MPDQueueElement song={song} queue={mpd.queue} current={current_song} />
                }}
            </For>
        </box>
    </scrolledwindow>

    type BrowserStates = 'playlists' | 'albums' | 'artists' | 'tracks';

    const [browser_page, set_browser_page] = createState<BrowserStates>("tracks")

    const browser = <box orientation={Gtk.Orientation.VERTICAL} spacing={10}>
        <box hexpand class="top-subsubmenu-header">
            <IconButton hexpand className={browser_page.as(p => p === "playlists" ? "top-menu-selected-tab" : "")}  icon_name="playlist-queue-symbolic" pixel_size={24} onClicked={() => set_browser_page('playlists')} />
            <IconButton hexpand className={browser_page.as(p => p === "albums" ? "top-menu-selected-tab" : "")}  icon_name="com.github.neithern.g4music-symbolic" pixel_size={24} onClicked={() => set_browser_page('albums')} />
            <IconButton hexpand className={browser_page.as(p => p === "artists" ? "top-menu-selected-tab" : "")}  icon_name="music-artist-symbolic" pixel_size={24} onClicked={() => set_browser_page('artists')} />
            <IconButton hexpand className={browser_page.as(p => p === "tracks" ? "top-menu-selected-tab" : "")}  icon_name="music-note-symbolic" pixel_size={24} onClicked={() => set_browser_page('tracks')} />
            
        </box>
        <stack visible_child_name={browser_page}>
            <PlaylistView $type="named" name="playlists" menu={playlistMenuModel} />
            <TrackView $type="named" name="albums" menu={menuModel} />
            <TrackView $type="named" name="artists" menu={menuModel} />
            <TrackView $type="named" name="tracks" menu={menuModel} />
        </stack>
    </box>

    const quick_controls = <box class="top-section" vexpand>
        <box orientation={Gtk.Orientation.VERTICAL} vexpand>
            <IconButton vexpand className="" icon_name="edit-clear-all-symbolic" pixel_size={24} onClicked={() => {
                mpd.queue.clear();
            }} />
            <IconButton vexpand className="" icon_name="settings-symbolic" pixel_size={24} onClicked={() => {
            }} />
        </box>
    </box>

    const mprisWidget = <MPRISWidget />

    grid.attach(mprisWidget as any, 0, 0, 6, 1);
    grid.attach(queue as any, 0, 1, 5, 1);
    grid.attach(browser as any, 6, 0, 4, 2);

    grid.attach(quick_controls as any, 5, 1, 1, 1);

    return grid;
}

export const MusicPage = ({name}: {name: string}) => {
    return <box name={name}>
        <With value={createBinding(mpd, "connected")}>
            {connected => connected ?
                <MusicPageWithMDP name={name} /> :
                <MPRISWidget />
            }
        </With>
    </box>
}



import { Gdk, Gtk } from "ags/gtk4";
import Adw from "gi://Adw?version=1";
import AstalMpris from "gi://AstalMpris?version=0.1"
import Graphene from "gi://Graphene?version=1.0";
import Gsk from "gi://Gsk?version=4.0";
import { Accessor, createBinding, createComputed, createState, For, With } from "gnim";
import { property, register } from "gnim/gobject";
import { WrappedMarqueeLabel } from "./Marquee";
import Atspi20 from "gi://Atspi";
import { IconButton } from "./IconButton";
import { Icon } from "astal/gtk3/widget";

const mpris = AstalMpris.get_default();

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
    console.log(`${name.get()}: ${player.title}`)
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
    overlay.css_classes = ["top-section-no-padding"];

    overlay.set_child(
        <box class="playback-widget" css={createBinding(player, "cover_art").as(c => `background-image: url(file://${c}); filter: brightness(0.125);`)}>
        </box> as Gtk.Widget
    )

    overlay.add_overlay(
        <box margin_bottom={20} margin_end={20} margin_top={20} margin_start={20} spacing={20}>
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
                console.log("Lost last client!")
                setCurrent(_ => -1);
                return;
            }
            setCurrent(mpris.players.length - 1);
        }
    })

    mpris.connect("player-added", () => {
        console.log("player added: " + mpris.players.length)
        if(mpris.players.length === 1) {
            console.log("Set current to 0")
            setCurrent(_ => 0);
        }
    })

    current.subscribe(() => {
        console.log("CURRENT: " + current.as(c => `${c}`).get())
    })

    return <box class="top-section-no-padding">
        <overlay>
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

export const MusicPage = ({name}: {name: string}) => {
    const grid = Gtk.Grid.new();
    grid.name = name;
    grid.row_homogeneous = true;
    grid.column_homogeneous = true;
    grid.row_spacing = 10;
    grid.column_spacing = 10;
    grid.margin_bottom = 10;
    grid.margin_top = 10;

    const queue = <box class="top-section">
        <label label="Queue is empty" />
    </box>
    const browser = <box class="top-section">
        <label label="todo" />
    </box>

    const mprisWidget = <MPRISWidget />

    grid.attach(mprisWidget as any, 0, 0, 3, 1);
    grid.attach(queue as any, 0, 1, 3, 1);
    grid.attach(browser as any, 3, 0, 2, 2);

    return grid;
}

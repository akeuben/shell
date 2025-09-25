import { Gtk } from "ags/gtk4";
import Adw from "gi://Adw?version=1";
import AstalMpris from "gi://AstalMpris?version=0.1"
import { Accessor, createBinding, createComputed, createState, For, With } from "gnim";
import { WrappedMarqueeLabel } from "./Marquee";
import { IconButton } from "./IconButton";
import { property, register } from "gnim/gobject";
import GObject from "gi://GObject?version=2.0";
import { Gio, GLib } from "astal";

@register()
class KappashellMPD extends GObject.Object {
    private static instance: KappashellMPD;

    @property(Number)
    test: number = 5;

    private client: Gio.SocketClient;
    private connection: Gio.SocketConnection;
    private socket: Gio.Socket;

    private encoder = new TextEncoder();
    private decoder = new TextDecoder();
    
    private receiveInterval: GLib.Source;

    private prev_message_part: string = "";
    
    constructor(props: {host?: string, port?: number}) {
        super();

        this.client = Gio.SocketClient.new();
        this.connection = this.client.connect_to_host(props.host || "localhost", props.port || 6600, null);
        this.socket = this.connection.socket;

        this.receiveInterval = setInterval(this._receiveMessages.bind(this), 100);

        this.sendCommand("play");
    }

    _receiveMessages() {
        try {
            const bytes = this.connection.get_socket().receive_bytes(1000, 1000, null);
            const msg = this.decoder.decode(bytes.get_data() as any);

            let parts = msg.split("\n");
            parts[0] = this.prev_message_part + parts[0];
            this.prev_message_part = parts.pop() || "";

            parts = parts.filter(a => a!=="OK")

            console.log(parts);
            
            this._sendCommand("idle");
        } catch {
        }
    }

    _sendCommand(cmd: string, ...args: string[]) {
        let msg = cmd;

        for(const arg of args) {
            msg += ` "${arg}"`;
        }

        const encoded = this.encoder.encode(msg + "\n");

        this.socket.send(encoded, null);
    }

    private sendCommand(cmd: string, ...args: string[]) {
        this._sendCommand("noidle");
        this._sendCommand(cmd, ...args);
    }

    static get_default() {
        if(!this.instance) {
            this.instance = new KappashellMPD({host: "localhost", port: 6600});
        }

        return this.instance;
    }

    vfunc_dispose(): void {
        super.vfunc_dispose();
        this.connection.close();
        clearInterval(this.receiveInterval);
    }
}

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

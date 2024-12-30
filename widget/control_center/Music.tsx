import AstalMpris from "gi://AstalMpris?version=0.1"
import { bind } from "gjs/binding";
import { Astal, Gtk } from "gjs/gtk3";
import Variable from "gjs/variable";

const get_playback_icon = (status: AstalMpris.PlaybackStatus) => {
    switch(status) {
        case AstalMpris.PlaybackStatus.STOPPED: 
        case AstalMpris.PlaybackStatus.PAUSED: 
            return "media-playback-start-symbolic";
        case AstalMpris.PlaybackStatus.PLAYING:
            return "media-playback-pause-symbolic";
    }
}

const PlayerPlayback = ({player, name}: {player: AstalMpris.Player, name: string}) => {

    let target_value = 0;
    let timeout: any;

    return <overlay className="widget-playback" name={name}>
        <box className="background" css={bind(player, "cover_art").as(cover_art => `background-image: url("${cover_art}")`)} hexpand={true} vexpand={true}/>
        <box className="darken" hexpand={true} vexpand={true}/>
        <box orientation={Gtk.Orientation.VERTICAL} margin={10} spacing={10}>
            <button cursor="pointer" className="raise-button" margin={10} vexpand={false} valign={Gtk.Align.START} halign={Gtk.Align.START} onClickRelease={() => player.raise()}>
                <icon className="app-icon"
                    icon={bind(player, "entry").as(entry => Astal.Icon.lookup_icon(entry) ? entry : "audio-x-generic-symbolic")} />
            </button>
            <box vexpand={true} valign={Gtk.Align.CENTER} className="details-box">
                <box orientation={Gtk.Orientation.VERTICAL} hexpand={true} halign={Gtk.Align.START}>
                    <label className="track" hexpand={true} halign={Gtk.Align.START} label={bind(player, "title").as(title => title.substring(0, 22) + (title.length > 22 ? "..." : ""))} />
                    <label className="artist" hexpand={true} halign={Gtk.Align.START} label={bind(player, "artist")} />
                </box>
                {<button cursor="pointer" className="play-pause-button" hexpand={false} onClick={() => {
                    player.play_pause();
                }}>
                    <icon icon={bind(player, "playback_status").as(get_playback_icon)} hexpand={true} vexpand={true} halign={Gtk.Align.CENTER} valign={Gtk.Align.CENTER}/>
                </button>}
            </box>
            <box margin={10} vexpand={false} valign={Gtk.Align.START} spacing={10} className="controls">
                {bind(player, "can_go_previous").as(can => can ? <button onClick={() => player.previous()} cursor="pointer"><icon cursor="pointer" icon="media-skip-backward-symbolic"/></button> : <></>)}
                <slider min={0} max={bind(player, "length").as(l => l)} value={bind(player, "position")} hexpand={true} onDragged={(slider) => {
                    if(player.can_seek && !player.entry.includes("g4music")) {
                        console.log("New position " + slider.value);
                        player.position = slider.value;
                    } else {
                        slider.set_value(player.position);
                    }
                }}/>
                {bind(player, "can_go_next").as(can => can ? <button onClick={() => player.next()} cursor="pointer"><icon icon="media-skip-forward-symbolic"/></button> : <></>)}
            </box>
        </box>
    </overlay>
}

export const PlaybackWidget = () => {
    const mpris = AstalMpris.get_default();
    const page = new Variable(0);
    return <overlay>
        {
            bind(mpris, "players").as(p => p.length > 0 ? 
                <stack shown={page(p => p + "")} transitionType={Gtk.StackTransitionType.SLIDE_LEFT_RIGHT}>
                {
                    bind(mpris, "players").as(players => players.map((player, i) => <PlayerPlayback name={i + ""} player={player} />))
                }
                </stack> : 
                <box className="widget-playback darken">
                    <label label="No media playing" hexpand={true} halign={Gtk.Align.CENTER}/>
                </box>
            )
        }
        <box vexpand={false} valign={Gtk.Align.END} hexpand={true} halign={Gtk.Align.CENTER}>
            {
                bind(mpris, "players").as(players => players.map((_, i) => <button cursor="pointer" className={page(p => `tab ${p === i ? "selected" : ""}`)} onClickRelease={() => {
                    page.set(i);
                }} />))
            }
        </box>
    </overlay>
}

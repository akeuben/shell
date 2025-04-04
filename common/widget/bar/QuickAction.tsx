import { execAsync } from "astal/process";
import Variable from "astal/variable"
import { openWeatherWMOToEmoji } from "../../utils/weather-codes";
import { moonPhaseAlt } from "../../utils/moon-phase";
import AstalMpris from "gi://AstalMpris?version=0.1";
import { bind } from "astal";
import { Gtk } from "astal/gtk3";
import { get_playback_icon } from "../../utils/icons";
import { EventBox } from "astal/gtk3/widget";

export const QuickActionWidget = () => {
    const mpris = AstalMpris.get_default();

    return <box className="bar-section">
        {
            bind(mpris, "players").as(players => {
                if(players.length == 0) {
                    return <WeatherWidget />
                } else {
                    return <QuickPlaybackWidget />
                }
            })
        }
    </box>
}

const PlayerPlayback = ({player, name}: {player: AstalMpris.Player, name: string}) => {

    return <box name={name}>
        <EventBox onClickRelease={() => {
            player.raise();
        }}>
            <box className="background" css={bind(player, "cover_art").as(cover_art => `background-image: url("${cover_art}")`)}/>
        </EventBox>
        <label label={bind(player, "title").as(title => title.length > 10 ? title.substring(0, 10) + "..." : title)} hexpand={true} halign={Gtk.Align.START}/>
        <button cursor="pointer" css="margin-left: 10px;" onClickRelease={() => {
            if(player.playbackStatus === AstalMpris.PlaybackStatus.PLAYING) {
                player.pause();
            } else {
                player.play();
            }
        }}>
            <icon icon={bind(player, "playback_status").as(get_playback_icon)} />
        </button>
    </box>
}

export const QuickPlaybackWidget = () => {
    const mpris = AstalMpris.get_default();
    const page = Variable(0);

    return <eventbox onScroll={(_, e) => {
        if(e.delta_y > 0) {
            page.set(Math.min(page.get() + 1, mpris.players.length - 1));
        } else {
            page.set(Math.max(page.get() - 1, 0));
        }
    }}>
        <stack shown={page(p => p + "")} transitionType={Gtk.StackTransitionType.SLIDE_LEFT_RIGHT}>
            {
                bind(mpris, "players").as(players => players.map((player, i) => <PlayerPlayback player={player} name={i + ""} />))
            }
        </stack>
    </eventbox>
}

export const WeatherWidget = () => {
    const weatherVar = new Variable("");

    const updateWeather = () => {
        execAsync('curl "http://ip-api.com/json?fields=lat,lon"').then(res => {
            const loc = JSON.parse(res);
            execAsync(`curl https://api.open-meteo.com/v1/forecast?latitude=${loc.lat}&longitude=${loc.lon}&current=temperature_2m,is_day,weather_code&models=gem_seamless`).then(weather_res => {
                const weather = JSON.parse(weather_res);
                const emoji = weather.current.is_day ? openWeatherWMOToEmoji(weather.current.weather_code).value : moonPhaseAlt().icon;

                weatherVar.set(`${emoji} ${weather.current.temperature_2m}°C`);
            }).catch(e => {
                console.warn(e);
            })
        }).catch(e => {
            console.warn(e);
        })
    }

    setInterval(updateWeather, 300E3)
    updateWeather();

    return <label label={weatherVar(w => w.replaceAll("+", ""))} />
}

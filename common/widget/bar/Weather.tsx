import { execAsync } from "astal/process";
import Variable from "astal/variable"
import { openWeatherWMOToEmoji } from "../../utils/weather-codes";
import { moonPhaseAlt } from "../../utils/moon-phase";

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

    return <label className="bar-section" label={weatherVar(w => w.replaceAll("+", ""))} />
}

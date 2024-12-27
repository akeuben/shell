import Variable from "gjs/variable"

export const WeatherWidget = () => {
    const weather = new Variable("...");
    weather.poll(300000, "curl https://wttr.in/?format=%c%t");

    return <label className="bar-section" label={weather()} />
}

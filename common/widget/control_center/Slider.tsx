import AstalWp from "gi://AstalWp?version=0.1";
import Binding, { bind } from "astal/binding";
import { Gtk } from "astal/gtk3";

let timeout: any = null;
let target_value = 0;

const Slider = ({value, disabled, set_value, click_action, icon}: {value: number | Binding<number>, disabled: boolean | Binding<boolean>, set_value: (arg0: number) => void, click_action: () => void, icon: string | Binding<string>}) => {
    const get_class_name = (disabled: boolean | Binding<Boolean>) => {
        if(typeof disabled === "boolean") {
            return `widget-slider ${disabled ? "disabled" : ""}`;
        }
        
        return disabled.as(d => `widget-slider ${d ? "disabled" : ""}`);
    }
    return <overlay className={get_class_name(disabled)}>
        <box className="sizing"/>
        <box className="underscale" vexpand={false} valign={Gtk.Align.CENTER}/>
        <slider drawValue={false} value={value} min={0} max={100} onDragged={(slider) => set_value(slider.value)}/>
        <button cursor="pointer" hexpand={false} halign={Gtk.Align.START} onClickRelease={click_action}><icon icon={icon}/></button>
    </overlay>
}

export const VolumeSlider = () => {
    const audio = AstalWp.get_default();
    if(!audio) return <></>
    const speaker = audio.default_speaker;
    const volume = bind(speaker, "volume").as(v => v * 100);
    const mute = bind(speaker, "mute");
    const audio_icon = bind(speaker, "volume_icon");

    return <Slider value={volume} 
        disabled={mute}
        set_value={(arg0: number) => {
            target_value = arg0/100;
            if(!timeout) {
                timeout = setTimeout(() => {
                    speaker.set_volume(target_value); 
                    speaker.set_mute(false)
                    timeout = null;
                }, 50)
            }
        }} 
        click_action={() => {speaker.set_mute(!speaker.mute)}}
        icon={audio_icon}
    />
}

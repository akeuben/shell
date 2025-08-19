import { Gdk, Gtk } from "ags/gtk4";
import { createPoll } from "ags/time"
import AstalTray from "gi://AstalTray?version=0.1";
import { createBinding, For, onCleanup } from "gnim";

export const Clock = () => {
    const hours = createPoll("00", 500, `date +"%H"`);
    const minutes = createPoll("00", 500, `date +"%M"`);

    return <box orientation={Gtk.Orientation.VERTICAL} class="clock">
        <label label={hours} class="hour" />
        <label label={minutes} class="minute" />
    </box>
}

const tray = AstalTray.get_default();

export const SystemTray = () => {
    function group<T>(arr: T[]): T[][] {
        const final = [];
        for(let i = 0; i < arr.length; i += 2) {
            final[i/2] = [arr[i], arr[i+1]];
        }

        return final;
    }


    return <box halign={Gtk.Align.CENTER} orientation={Gtk.Orientation.VERTICAL} >
        <For each={createBinding(tray, "items").as(group).as(a => a.toReversed())}>
            {(item: AstalTray.TrayItem[]) => <box spacing={5}>
                {item.map(item => {
                    if(!item) return <></>;
                    const popup = Gtk.PopoverMenu.new_from_model(item.menu_model);

                    function init(btn: Gtk.Button) {
                        popup.set_parent(btn);
                        popup.insert_action_group("dbusmenu", item.action_group);
                        popup.set_has_arrow(false);
                        const conns = [
                            item.connect("notify::menu-model", () => popup.set_menu_model(item.menu_model)),
                            item.connect("notify::action-group", () => popup.insert_action_group("dbusmenu", item.action_group))
                        ]

                        onCleanup(() => {
                            popup.unparent();
                            conns.map(id => item.disconnect(id));
                        })
                    }
                
                    return <button class="tray-item" cursor={Gdk.Cursor.new_from_name("pointer", null)} $={init}>
                        <Gtk.GestureClick
                            button={Gdk.BUTTON_PRIMARY}
                            onPressed={(_, x, y) => item.is_menu ? popup.popup() : item.activate(x, y)}
                          />
                        <Gtk.GestureClick
                            button={Gdk.BUTTON_SECONDARY}
                            onPressed={() => popup.popup()}
                          />
                        <image gicon={item.gicon} pixel_size={16} />
                    </button>
                })}
            </box>}
        </For>
    </box>
}

import { Gtk } from "ags/gtk4"
import { createPoll } from "ags/time"
import { createState } from "gnim"
import { IconButton } from "./IconButton"

const ClockPage = ({name}: {name: string}) => {
    const time = createPoll("00", 1000, `date +"%H:%M"`)
    const second = createPoll("00", 1000, `date +"%S"`)
    const date = createPoll("", 500, `date +"%A %B %d, %Y"`)
    return <box orientation={Gtk.Orientation.VERTICAL} valign={Gtk.Align.CENTER} halign={Gtk.Align.CENTER} hexpand={true} name={name}>
        <box spacing={5}>
            <label valign={Gtk.Align.BASELINE_CENTER} hexpand class="time" label={time} />
            <label valign={Gtk.Align.BASELINE_CENTER} hexpand class="second" label={second} margin_bottom={5} />
        </box>
        <label class="date" label={date} />
    </box>
}

const CalendarPage = ({name}: {name: string}) => {

    const [page, setPage] = createState(0);
    
    return <box name={name} spacing={10}>
        <Gtk.Calendar />
        <box orientation={Gtk.Orientation.VERTICAL}>
            <box hexpand class="top-subsubmenu-header">
                <IconButton hexpand className={page.as(p => p === 0 ? "top-menu-selected-tab" : "")} icon_name="text-calendar-symbolic" pixel_size={16} onClicked={() => setPage(0)} />
                <IconButton hexpand className={page.as(p => p === 1 ? "top-menu-selected-tab" : "")} icon_name="task-list-symbolic" pixel_size={16} onClicked={() => setPage(1)} />
            </box>
            <stack visible_child_name={page.as(p => `${p}`)} $type="named" transition_type={Gtk.StackTransitionType.SLIDE_LEFT_RIGHT} width_request={200} height_request={300}>
                <EventsPage name="0" $type="named" />
                <TodoPage name="1" $type="named" />
            </stack>
        </box>
    </box>
}

const EventsPage = ({name}: {name: string}) => {
    return <label label="events" name={name}/>
}

const TodoPage = ({name}: {name: string}) => {
    return <label label="todo" name={name}/>
}

const StopwatchPage = ({name}: {name: string}) => {
    return <box name={name}>
        <label label="stopwatch" />
        
    </box>
}

const TimerPage = ({name}: {name: string}) => {
    return <box name={name}>
        <label label="timer" />
        
    </box>
}

export const TimePage = ({name}: {name: string}) => {
    const [page, setPage] = createState(0);
    return <box name={name}>
        <box>
            <box margin_top={10} margin_bottom={10} class="top-submenu-selector">
                <Gtk.FlowBox max_children_per_line={1}>
                    <IconButton valign={Gtk.Align.CENTER} className={page.as(p => p === 0 ? "top-menu-selected-tab" : "")} icon_name="clock-app-symbolic" pixel_size={24} onClicked={() => setPage(0)} />
                    <IconButton valign={Gtk.Align.CENTER} className={page.as(p => p === 1 ? "top-menu-selected-tab" : "")} icon_name="text-calendar-symbolic" pixel_size={24} onClicked={() => setPage(1)} />
                    <IconButton valign={Gtk.Align.CENTER} className={page.as(p => p === 2 ? "top-menu-selected-tab" : "")} icon_name="stopwatch-symbolic" pixel_size={24} onClicked={() => setPage(2)} />
                    <IconButton valign={Gtk.Align.CENTER} className={page.as(p => p === 3 ? "top-menu-selected-tab" : "")} icon_name="tools-timer-symbolic" pixel_size={24} onClicked={() => setPage(3)} />
                </Gtk.FlowBox>
            </box>
            <stack visible_child_name={page.as(p => `${p}`)} $type="named" transition_type={Gtk.StackTransitionType.SLIDE_UP_DOWN}>
                <ClockPage name="0" $type="named" />
                <CalendarPage name="1" $type="named" />
                <StopwatchPage name="2" $type="named" />
                <TimerPage name="3" $type="named" />
            </stack>
        </box>
    </box>
}

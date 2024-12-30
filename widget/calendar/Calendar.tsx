import Binding, { bind } from "gjs/binding";
import { Gtk } from "gjs/gtk3";
import Variable from "gjs/variable"

function getFirstDayOfMonth(date: Date): number {
    const year = date.getFullYear();
    const month = date.getMonth();

    const firstDay = new Date(year, month, 1);
    
    return firstDay.getDay();
}

function getDaysInMonth(date: Date): number {
    const year = date.getFullYear();
    const month = date.getMonth();

    const nextMonth = new Date(year, month + 1, 1);

    const lastDayOfCurrentMonth = new Date(nextMonth.getTime() - 1);

    return lastDayOfCurrentMonth.getDate();
}

const months = [
    "January",
    "Feburary",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
]

const Days = [
    "Su",
    "Mo",
    "Tu",
    "We",
    "Th",
    "Fr",
    "Sa",
]

const calculateDateFromIndex = (index: number, month: Date) => {
    return new Date(month.getFullYear(), month.getMonth(), index + 1 - getFirstDayOfMonth(month));
}

const CalendarDate = ({month, today, selected, date}: {month: Variable<Date>, today: Variable<Date>, selected: Variable<Date>, date: Binding<Date>}) => {
    const calculate_class_name = (date: Date, month: Date, today: Date, selected: Date) => {
        let className = "";
        if(date.getMonth() < month.getMonth() || date.getFullYear() < month.getFullYear()) {
            className="prev";
        } else if(date.getMonth() > month.getMonth() || date.getFullYear() > month.getFullYear()) {
            className="next";
        }
        if(date.getDate() === today.getDate() && date.getMonth() === today.getMonth() && date.getFullYear() === today.getFullYear()) {
            className += " today"
        }
        if(date.getDate() === selected.getDate() && date.getMonth() === selected.getMonth() && date.getFullYear() === selected.getFullYear()) {
            className += " selected"
        }
        return className;
    }

    const className = Variable.derive([date, month, today, selected], calculate_class_name);

    return <button onClickRelease={() => {
        selected.set(date.get())
    }}
    className={className()}>
        <overlay>
            <label label={bind(date).as(d => d.getDate() + "")} />
        </overlay>
    </button>
}

export const MonthWidget = () => {
    const time = new Variable(new Date());
    time.poll(1000, `date +"%s"`, a => new Date(parseInt(a) * 1000));

    const displayed = new Variable(new Date(time.get().getFullYear(), time.get().getMonth()));

    const selected_date = new Variable(time.get());

    const seven = [0, 1, 2, 3, 4, 5, 6];
    const four = [1,2,3,4];

    return <box orientation={Gtk.Orientation.VERTICAL} className="calendar">
        <centerbox>
            <button cursor="pointer" hexpand={false} halign={Gtk.Align.START} onClickRelease={() => displayed.set(new Date(displayed.get().getFullYear(), displayed.get().getMonth() - 1))}><icon icon="go-previous-symbolic" /></button>
            <button cursor="pointer" hexpand={true} halign={Gtk.Align.CENTER} label={displayed(d => `${months[d.getMonth()]} ${d.getFullYear()}`)} onClickRelease={() => displayed.set(new Date(time.get().getFullYear(), time.get().getMonth()))}/>
            <button cursor="pointer" hexpand={false} halign={Gtk.Align.END} onClickRelease={() => displayed.set(new Date(displayed.get().getFullYear(), displayed.get().getMonth() + 1))}><icon icon="go-next-symbolic" /></button>
        </centerbox>
        <box className="week">
            {
                seven.map(i => <label label={Days[i]} />)
            }
        </box>
        <box className="week">
            {
                seven.map(i => <CalendarDate month={displayed} today={time} selected={selected_date} date={bind(displayed).as(month => calculateDateFromIndex(i, month))} />)
            }
        </box>
        {
            four.map(r => <box className="week">
                {
                    seven.map(i => <CalendarDate month={displayed} today={time} selected={selected_date} date={bind(displayed).as(month => calculateDateFromIndex(i + r * 7, month))} />)
                }
            </box>)
        }
    </box>
}

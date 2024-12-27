import Variable from "gjs/variable"

const time = Variable("").poll(1000, `date +"%a %e %b %I:%M%P"`)

export const TimeWidget = () => {
    return <box className="bar-section">
        <label label={time()}/>
    </box>
}

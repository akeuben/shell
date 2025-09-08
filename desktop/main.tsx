import { createBinding, For, This } from "gnim";
import { Bottom, Left, Right, Top } from "./widget/Bar";
import app from "ags/gtk4/app";
import { TopMenu } from "./widget/TopMenu";
import { PowerMenu, Runner, ScreenshotMenu } from "./widget/BottomMenu";

export const main = () => {
    const monitors = createBinding(app, "monitors");
    return <For each={monitors}>
        {monitor =>
            <This this={app}>
                <Top gdkmonitor={monitor} />
                <Left gdkmonitor={monitor} />
                <Right gdkmonitor={monitor} />
                <Bottom gdkmonitor={monitor} />
                <TopMenu gdkmonitor={monitor} />
                <Runner gdkmonitor={monitor} />
                <PowerMenu gdkmonitor={monitor} />
                <ScreenshotMenu gdkmonitor={monitor} />
            </This>
        }
    </For>
}

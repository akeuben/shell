import { createState } from "gnim";

export enum BottomMenuType {
    NONE,
    POWER_MENU,
    RUNNER,
}

export const [bottomMenu, setBottomMenu] = createState<BottomMenuType>(BottomMenuType.NONE);

import { execAsync } from "astal/process";
import { RunnerAction, RunnerSource } from "../../types/runner_sources/source";
// @ts-ignore
import * as math from "../math.js";

const search = (search_term: string) => {
    const evaluation = math.evaluate(search_term);
    const formated = math.format(evaluation, (val: number) => Math.round(val * 1000) / 1000);
    const results: RunnerAction[] = [
        {
            name: `= ${formated}`,
            description: math.parse(search_term).toString(),
            action: () => {
                execAsync(`wl-copy ${formated}`)
            },
            type: "result",
        }
    ];
    return results;
}

const has_results = (search_term: string) => {
    try {
        const parsed = math.parse(search_term);
        if(["ConstantNode", "SymbolNode"].includes(parsed.type)) {
            return false;
        }
        const result = math.evaluate(search_term);
        if(["undefined"].includes(typeof result)) {
            return false;
        }
        return true;
    } catch(_) {}
    return false;
}

const MathSource: RunnerSource = {
    search,
    has_results,
}

export default MathSource;

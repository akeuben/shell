import { RunnerAction } from "../types/runner_sources/source";
import AppSource from "./runner_sources/apps";
import MathSource from "./runner_sources/math";

const MAX_RESULTS = 5;

const sources = [
    MathSource,
    AppSource,
]

const find_all_results = (search_term: string) => {
    if(search_term.trim() === "") {
        return [];
    }
    let results: RunnerAction[] = [];
    for(const source of sources) {
        if(!source.has_results(search_term)) continue;
        const actions = source.search(search_term)
        results = results.concat(actions.splice(0, MAX_RESULTS - results.length));
    }
    return results;
}

export const RunnerSettings = {
    find_all_results
}

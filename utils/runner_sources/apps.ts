import AstalApps from "gi://AstalApps?version=0.1";
import { RunnerAction, RunnerSource } from "../../types/runner_sources/source";

const apps = new AstalApps.Apps({
    name_multiplier: 2,
    entry_multiplier: 0,
    executable_multiplier: 2,
})

const search = (search_term: string) => {
    const applications = apps.fuzzy_query(search_term);

    const results = [];
    for(const application of applications) {
        const result: RunnerAction = {
            name: application.name,
            description: application.description,
            icon: application.icon_name,
            type: "item",
            action: () => application.launch()
        }
        results.push(result)
    }

    return results;
}

const has_results = (search_term: string) => {
    return apps.fuzzy_query(search_term).length > 0;
}

const AppSource: RunnerSource = {
    search,
    has_results,
}

export default AppSource;

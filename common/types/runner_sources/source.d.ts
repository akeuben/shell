export type RunnerAction = {
    name: string,
    icon?: string,
    description: string,
    type: "item" | "result"
    action: () => void,
}

export type RunnerSource = {
    search: (search_term: string) => RunnerAction[]
    has_results: (search_term: string) => boolean
}

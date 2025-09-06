export type BaseResponse<P> = {
    type: "success",
    payload: P,
} | {
    type: "failure",
    message: string
}

export type BaseRequest<T extends string> = {
    type: T
}
export type RunnerRequest = BaseRequest<"runner">;
export type ScreenshotRequest = BaseRequest<"screenshot">;

export type RequestHandler<T extends BaseRequest<string>, P> = (request: T) => Promise<BaseResponse<P>>;

export type RequestHandlerRegistry = Record<string, RequestHandler<BaseRequest<any>, any>>

const fail = (error: string) => {
    return JSON.stringify({
        "type": "failure",
        "message": error
    })
}

export const handleRequest = (handlers: RequestHandlerRegistry, request: string[], response: (res: string) => void) => {
    const requestObject = JSON.parse(request.join(" ")) as BaseRequest<string>;

    const handler = handlers[requestObject.type];

    if(!handler) {
        response(fail("Unknown request type"));
        return;
    };

    handler(requestObject).then((r) => response(JSON.stringify(r)))
}

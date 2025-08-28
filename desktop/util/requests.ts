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

export type RequestHandler<T extends BaseRequest<string>, P> = (request: T) => Promise<BaseResponse<P>>;

export type RequestHandlerRegistry = Record<string, RequestHandler<BaseRequest<any>, any>>

export const handleRequest = (handlers: RequestHandlerRegistry, request: string, response: (res: BaseResponse<any>) => void) => {
    const requestObject = JSON.parse(request) as BaseRequest<string>;

    const handler = handlers[requestObject.type];

    if(!handler) {
        response({
            "type": "failure",
            "message": "Unknown request type",
        });
        return;
    };

    handler(requestObject).then(response)
}

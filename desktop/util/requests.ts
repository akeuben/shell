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

const lockedRequests: string[] = [];

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

    if(lockedRequests.includes(requestObject.type)) {
        response({
            "type": "failure",
            "message": "Request type is currently locked",
        });
        return;
    }

    handler(requestObject).then(response)
}

export const lockRequest = (requestType: string) => {
    if(lockedRequests.includes(requestType)) return;

    lockedRequests.push(requestType);
}

export const unlockRequest = (requestType: string) => {
    lockedRequests.splice(lockedRequests.indexOf(requestType));
}

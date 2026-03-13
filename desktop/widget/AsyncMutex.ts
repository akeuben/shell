export class AsyncMutex {
    private locked: boolean = false;
    private queue: Array<(a?: unknown) => void> = [];
    constructor() {
    }

    async lock() {
        if (this.locked) {
            return new Promise(resolve => this.queue.push(resolve));
        }
        this.locked = true;
        return Promise.resolve();
    }

    unlock() {
        if (this.queue.length > 0) {
            const nextResolve = this.queue.shift();
            if(!nextResolve) {
                this.locked = false;
                return;
            }
            nextResolve(); // Unlock and allow the next function to proceed
        } else {
            this.locked = false; // No more waiting functions, so unlock
        }
    }

    async withLock(fn: () => Promise<any>) {
        await this.lock();
        try {
            return await fn();  // Run the function while the mutex is locked
        } finally {
            this.unlock();  // Always unlock, whether success or failure
        }
    }
}


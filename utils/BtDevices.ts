import AstalBluetooth from "gi://AstalBluetooth?version=0.1";
import { Subscribable } from "gjs/binding";
import Variable from "gjs/variable";

const bluetooth = AstalBluetooth.get_default();

export class BtDevices implements Subscribable<AstalBluetooth.Device[]> {
    #list = Variable<AstalBluetooth.Device[]>([])
    #connection: number

    #getAvailableBluetoothDevices(): AstalBluetooth.Device[] {
        return bluetooth.devices;
    }

    #update() {
        this.#list.set(this.#getAvailableBluetoothDevices())
    }

    #handle_device_add(device: AstalBluetooth.Device) {
        const ids = [
            device.connect("notify::connected", () => this.#update()),
            device.connect("notify::connecting", () => this.#update()),
            device.connect("notify::paired", () => this.#update()),
        ]
        const id = bluetooth.connect("device-removed", (_, d) => {
            if(d === device) {
                ids.map(id => device.disconnect(id));
                bluetooth.disconnect(id);
                this.#update();
            }
        });
        this.#update();
    }

    constructor() {
        this.#connection = bluetooth.connect("device-added", (_, device) => this.#handle_device_add(device))
        for(const device of bluetooth.devices) {
            this.#handle_device_add(device);
        }
        this.#update();
    }

    drop() {
        bluetooth.disconnect(this.#connection);
        this.#list.drop();
    }

    subscribe(callback: (value: AstalBluetooth.Device[]) => void): () => void {
        this.#list.subscribe(callback);

        return () => {};
    }

    get(): AstalBluetooth.Device[] {
        return this.#list.get();
    }
}

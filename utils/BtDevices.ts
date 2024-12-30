import AstalBluetooth from "gi://AstalBluetooth?version=0.1";
import { Subscribable } from "gjs/binding";
import Variable from "gjs/variable";

const bluetooth = AstalBluetooth.get_default();

export class BtDevices implements Subscribable<AstalBluetooth.Device[]> {
    #list = Variable<AstalBluetooth.Device[]>([])
    #ids: Record<string, number[]> = {}
    #connection: [number, number] = [0, 0]

    #getAvailableBluetoothDevices(): AstalBluetooth.Device[] {
        return bluetooth.devices.sort((a, b) => {
            const priorityA = a.connected || a.connecting ? 0 : a.paired ? 1 : 2;
            const priorityB = b.connected || b.connecting ? 0 : b.paired ? 1 : 2;

            if (priorityA !== priorityB) {
                return priorityA - priorityB;
            }

            if (!a.name && !b.name) {
                return 0;
            } else if (!a.name) {
                return 1;
            } else if (!b.name) {
                return -1;
            }

            return a.name.localeCompare(b.name);
        });
    }

    #update() {
        this.#list.set(this.#getAvailableBluetoothDevices())
    }

    #handle_device_add(device: AstalBluetooth.Device) {
        this.#ids[device.address] = [
            device.connect("notify::connected", () => this.#update()),
            device.connect("notify::connecting", () => this.#update()),
            device.connect("notify::paired", () => this.#update()),
        ]
        this.#update();
    }

    #handle_device_remove(device: AstalBluetooth.Device) {
        this.#ids[device.address].forEach(id => device.disconnect(id));
        this.#update();
    }

    constructor() {
        this.#connection[0] = bluetooth.connect("device-added", (_, device) => this.#handle_device_add(device));
        this.#connection[1] = bluetooth.connect("device-removed", (_, device) => this.#handle_device_remove(device));

        for(const device of bluetooth.devices) {
            this.#handle_device_add(device);
        }
        this.#update();
    }

    drop() {
        bluetooth.disconnect(this.#connection[0]);
        bluetooth.disconnect(this.#connection[1]);
        this.#list.drop();
    }

    subscribe(callback: (value: AstalBluetooth.Device[]) => void): () => void {
        return this.#list.subscribe(callback);
    }

    get(): AstalBluetooth.Device[] {
        return this.#list.get();
    }
}

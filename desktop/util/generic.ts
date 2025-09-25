import { Accessor } from "gnim";

export function isAccessor<T>(value: any): value is Accessor<T> {
  return value && typeof value.get === "function" && typeof value.subscribe === "function";
}


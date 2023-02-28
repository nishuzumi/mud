import { StoreUserConfig, StoreConfig } from "./loadStoreConfig.js";
import { WorldUserConfig, WorldConfig } from "./loadWorldConfig.js";

export type { StoreUserConfig, StoreConfig, WorldUserConfig, WorldConfig };
export type MUDUserConfig = StoreUserConfig & WorldUserConfig;
export type MUDConfig = StoreConfig & WorldConfig;

export * from "./commonSchemas.js";
export * from "./loadConfig.js";
export * from "./loadStoreConfig.js";
export * from "./validation.js";
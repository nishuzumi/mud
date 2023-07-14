import { DynamicAbiType, StaticAbiType } from "@latticexyz/schema-type";
import { Address, Hex, getAddress } from "viem";
import initSqlJs from "sql.js";
import { drizzle, SQLJsDatabase } from "drizzle-orm/sql-js";
import { SQLiteTransaction, blob, integer, sqliteTable, text } from "drizzle-orm/sqlite-core";
import { DefaultLogger, and, eq, inArray, or, sql } from "drizzle-orm";
import { sqliteTableToSql } from "./sqliteTableToSql";
import { createSqliteTable } from "./createSqliteTable";
import { ChainId, Table, TableName, TableNamespace, WorldId } from "../common";
import { json } from "./columnTypes";
import { TableId } from "@latticexyz/common";

export const chainStateName = "__chainState";
export const chainState = sqliteTable(chainStateName, {
  chainId: integer("chainId").notNull().primaryKey(),
  lastUpdatedBlockNumber: blob("last_updated_block_number", { mode: "bigint" }),
  // TODO: last block hash?
  lastError: text("last_error"),
});

export const mudStoreTablesName = "__mud_store_tables";
export const mudStoreTables = sqliteTable(mudStoreTablesName, {
  tableId: text("table_id").notNull().primaryKey(),
  namespace: text("namespace").notNull(),
  name: text("name").notNull(),
  keyTupleSchema: json("key_schema").notNull(),
  valueSchema: json("value_schema").notNull(),
  lastUpdatedBlockNumber: blob("last_updated_block_number", { mode: "bigint" }),
  // TODO: last block hash?
  lastError: text("last_error"),
});

export let internalDatabase: SQLJsDatabase | null = null;
export const databases = new Map<WorldId, SQLJsDatabase>();

export function destroy(): void {
  databases.clear();
}

export async function getInternalDatabase(): Promise<SQLJsDatabase> {
  if (internalDatabase) {
    return internalDatabase;
  }

  const SqlJs = await initSqlJs();
  const db = drizzle(new SqlJs.Database(), {
    // logger: new DefaultLogger(),
  });

  db.run(sql.raw(sqliteTableToSql(chainStateName, chainState)));

  return (internalDatabase = db);
}

export async function getDatabase(chainId: ChainId, address: Address): Promise<SQLJsDatabase> {
  const worldId = getWorldId(chainId, address);
  if (databases.has(worldId)) {
    return databases.get(worldId)!;
  }

  // TODO: use sql.js in web, better-sqlite3 in node?
  // TODO: allow swapping for better-sqlite3 DB that writes to disk
  // TODO: type DB to include mudStoreTables
  const SqlJs = await initSqlJs();
  const db = drizzle(new SqlJs.Database(), {
    // logger: new DefaultLogger(),
  });

  db.run(sql.raw(sqliteTableToSql(mudStoreTablesName, mudStoreTables)));

  databases.set(worldId, db);
  return db;
}

export async function getTables(
  db: SQLJsDatabase,
  conditions: Pick<Table, "namespace" | "name">[] = []
): Promise<Table[]> {
  const tableIds = conditions.map((condition) => new TableId(condition.namespace, condition.name).toHex());
  const tables = db
    .select()
    .from(mudStoreTables)
    .where(tableIds.length ? inArray(mudStoreTables.tableId, tableIds) : undefined)
    .all();

  return tables.map((table) => ({
    tableId: new TableId(table.namespace, table.name).toHex(),
    namespace: table.namespace,
    name: table.name,
    keyTupleSchema: table.keyTupleSchema as Record<string, StaticAbiType>,
    valueSchema: table.valueSchema as Record<string, StaticAbiType | DynamicAbiType>,
    lastUpdatedBlockNumber: table.lastUpdatedBlockNumber,
  }));
}

export async function getTable(db: SQLJsDatabase, namespace: TableNamespace, name: TableName): Promise<Table | null> {
  return (await getTables(db, [{ namespace, name }]))[0] ?? null;
}

export async function createTable(
  dbOrTx: SQLJsDatabase | SQLiteTransaction<any, any, any, any>,
  table: Omit<Table, "tableId">
): Promise<Table> {
  return await dbOrTx.transaction(async (tx) => {
    const tableId = new TableId(table.namespace, table.name).toHex();
    const sqliteTable = createSqliteTable({
      namespace: table.namespace,
      name: table.name,
      keyTupleSchema: table.keyTupleSchema,
      valueSchema: table.valueSchema,
    });

    await tx.run(sql.raw(sqliteTableToSql(sqliteTable.tableName, sqliteTable.table)));

    await tx
      .insert(mudStoreTables)
      .values({
        tableId: new TableId(table.namespace, table.name).toHex(),
        namespace: table.namespace,
        name: table.name,
        keyTupleSchema: table.keyTupleSchema,
        valueSchema: table.valueSchema,
      })
      // sql.js doesn't like parallelism, so for now we just ignore duplicate tables
      // .onConflictDoNothing()
      .run();

    return {
      tableId,
      ...table,
    };
  });
}

export const getWorldId = (chainId: ChainId, address: Address): WorldId => {
  return `${chainId}:${getAddress(address)}`;
};

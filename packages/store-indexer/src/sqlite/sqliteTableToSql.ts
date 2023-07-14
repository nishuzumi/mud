import { AnySQLiteColumn, SQLiteTableWithColumns } from "drizzle-orm/sqlite-core";
import { ColumnDataType, Kysely, SqliteDialect } from "kysely";
import SqliteDatabase from "better-sqlite3";

const db = new Kysely<any>({
  dialect: new SqliteDialect({ database: new SqliteDatabase(":memory:") }),
});

// TODO: figure out how to extract table name from SQLiteTableWithColumns (it's in there just not exposed)
export function sqliteTableToSql(tableName: string, table: SQLiteTableWithColumns<any>): string {
  const columnNames = Object.getOwnPropertyNames(table);

  // sql.js doesn't like parallelism, so for now we just ignore duplicate tables
  let query = db.schema.createTable(tableName).ifNotExists();

  columnNames.forEach((columnName) => {
    const column = table[columnName] as AnySQLiteColumn;
    query = query.addColumn(column.name, column.getSQLType() as ColumnDataType, (col) => {
      if (column.notNull) {
        col = col.notNull();
      }
      if (column.hasDefault && typeof column.default !== "undefined") {
        // col = col.defaultTo(column.mapToDriverValue(column.default));
        col = col.defaultTo(column.default);
      }
      return col;
    });
  });

  const primaryKeys = columnNames
    .filter((columnName) => table[columnName].primary)
    .map((columnName) => (table[columnName] as AnySQLiteColumn).name);
  if (primaryKeys.length) {
    query = query.addPrimaryKeyConstraint(`${tableName}__primaryKey`, primaryKeys as any);
  }

  const { sql } = query.compile();
  return sql;
}
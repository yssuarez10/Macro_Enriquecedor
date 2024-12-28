interface Condition {
  field: string;
  operator: ">" | "<" | "<=" | ">=" | "IN";
  value: number | string | string[] | number[];
}

interface Conditions {
  operator: "AND" | "OR";
  conditions: Condition[] | Conditions[];
}

interface Validation {
  required?: boolean;
  unique?: boolean;
  length?: {
    min: number;
    max: number;
  };
}

interface Fields {
  column_name: string;
  value: string | number;
  validations: Validation;
}

interface Api {
  source: "Mysql" | "Postgres" | "Sqlite"; //Es un incremental se agragarán mas capacidades para conectarnos a distintas fuentes de datos
  table: "tabla";
  action: "select" | "upsert" | "delete";
  data: {
      schema_name: "nombre esquema"
      where: Conditions[] | Condition | undefined;
      fields: Fields[];
  }
}

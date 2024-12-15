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
  upsert?: {
    table: "tabla";
    where: Conditions[] | Condition | undefined;
    data: {
      fields: Fields[];
    };
  };
  select?: {
    table: "tabla";
    where: Conditions[] | Condition;
    data: {
      fields: string[];
    };
  };
  delete?: {
    table: "table";
    where: Conditions[] | Condition;
  };
}

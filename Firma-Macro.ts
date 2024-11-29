interface Condition {
    field: string,
    operator: ">" | "<" | "<=" | ">="| "IN",
    value: number | string | string[] | number[]
}

interface Conditions {
    operator: "AND" | "OR",
    conditions: Condition[] | Conditions[]
}

interface Validation {
    required?: boolean,
    unique?: boolean,
    lenght?: {
        min: number,
        max: number
    }
}

interface Fields {
    colum_name: string,
    value: string | number,
    validations: Validation
}


interface Api {
    "source":  "Mysql" | "Postgres" | "Sqlite", //Es un incremental se agragarán mas capacidades para conectarnos a distintas fuentes de datos
    "upsert"?: {
        "table": "tabla",
        "where": Conditions[] | Condition | undefined
        "data": {
            "fields": Fields[]
        }
    },
    "select"?: {
        "table": "tabla",
        "where": Conditions[] | Condition,
        "data": {
            "fields": string[]
        }
    },
    "delete"?: {
        table: "table",
        where: Conditions[] | Condition,
    }
}


function send(req: Api){
    
}

send({
    source: "Mysql",
    upsert: {
        table: "tabla",
        where: undefined,
        data: {
            fields: [{
                colum_name: "name",
                value: "Javier",
                validations: {
                    lenght: {
                        min: 0,
                        max: 0
                    },
                }
            }, {
                colum_name: "",
                value: "",
                validations: {

                }
            }]
        }
    }
})
import knex from "knex";

const config =  {
    client: 'mysql',
    connection: {
        host: 'db',
        port: 3306,
        user: 'root',
        password: 'root',
        database: 'sallemagne',
    },
}

export const db = knex(config);

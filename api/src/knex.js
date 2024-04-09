import knex from "knex";

const config =  {
    client: 'mysql',
    connection: {
        host: 'db',
        port: 3306,
        user: 'root',
        password: process.env.MYSQL_ROOT_PASSWORD,
        database: process.env.MYSQL_DATABASE,
    },
}

export const db = knex(config);

const express = require("express");
const mongoose = require("mongoose");
const mysql = require("mysql2/promise");

let db = null;
const app = express();

app.use(express.json());

app.post('/create-user', async(req, res, next) => {
    const name = req.body.name;
    const email = req.body.email;
    const password = req.body.password;

    await db.query("INSERT INTO users (name, email, password) VALUES (?, ?, ?);",

        [name, email, password]);

    res.json({ status: "OK" });
    next();
});

//All user
app.get('/users', async(req, res, next) => {

    const [rows] = await db.query("SELECT * FROM users;");

    res.json(rows);
    next();
});

//All doctor
app.get('/doctors', async(req, res, next) => {

    const [rows] = await db.query("SELECT * FROM doctors;");

    res.json(rows);
    next();
});

//Login control
app.get('/login', async(req, res, next) => {

    const email = req.body.email;
    const password = req.body.password;

    const [rows] = await db.query("SELECT users.password FROM users WHERE users.email = ?;", [email]);

    if (!rows) {
        return res.status(401).json({ message: 'Unauthorized' });
    }

    res.json(rows);
    next();

});



async function main() {
    db = await mysql.createConnection({
        host: "localhost",
        user: "root",
        password: "lemandy1905",
        database: "tele_tip",
        timezone: "+00:00",
        charset: "utf8mb4_general_ci",
    });

    app.listen(8000);
}

main();
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

    const [rows] = await db.query("SELECT * FROM tele_tip.users;");

    res.json(rows);
    next();
});

// All doctor
app.get('/doctors', async(req, res, next) => {

    const [rows] = await db.query(
        "SELECT doctor.id, doctor.email, doctor.name,doctor.gender, doctor.password, profession.name as professionName, department.department_name " +
        "FROM doctor LEFT JOIN profession ON doctor.profession_id = profession.id " +
        "LEFT JOIN department ON profession.department_id = department.id;");

    res.json(rows);
    next();
});

// 
app.get('/doctor/profession', async(req, res, next) => {

    const [rows] = await db.query("SELECT profession.id, profession.name, department_name FROM profession LEFT JOIN department ON profession.department_id = department.id;");

    res.json(rows);
    next();
});

app.post('/search/profession', async(req, res, next) => {

    const professionName = req.body.professionName;

    const [rows] = await db.query("SELECT doctor.name, doctor.gender, doctor.email, profession.name as professionName" +
        " FROM doctor" +
        " LEFT JOIN profession ON doctor.profession_id = profession.id" +
        " WHERE profession.name = '" +
        professionName + "';");

    res.json(rows);
    next();

});

app.get('/doctor/department', async(req, res, next) => {

    const [rows] = await db.query("SELECT* FROM department;");

    res.json(rows);
    next();
});

//Login Doctor control
app.get('/login-doctor', async(req, res, next) => {

    const email = req.body.email;
    // const password = req.body.password;
    // SELECT password FROM doctor WHERE email = "cerrahdoktor@teletip.com";
    // const [row] = await db.query("SELECT password FROM doctor WHERE email = '" + email.toString() + "';");

    const [row] = await db.query("SELECT doctor.id, doctor.email, doctor.name, doctor.password, profession.name as professionName, department.department_name " +
        "FROM doctor LEFT JOIN profession ON doctor.profession_id = profession.id " +
        "LEFT JOIN department ON profession.department_id = department.id WHERE doctor.email = '" +
        email.toString() + "';");

    if (!row) {
        return res.json({ message: 'Unauthorized' });
    }

    res.json(row);
    next();

});

//Login User control
app.post('/login-user', async(req, res, next) => {

    const email = req.body.email;
    // const password = req.body.password;
    // SELECT password FROM doctor WHERE email = "cerrahdoktor@teletip.com";
    // const [row] = await db.query("SELECT password FROM doctor WHERE email = '" + email.toString() + "';");

    const [row] = await db.query("SELECT users.id, users.email, users.name, users.password " +
        "FROM users " +
        "WHERE users.email = '" +
        email + "';");

    if (!row) {
        return res.json({ message: 'Unauthorized' });
    }

    res.json(row);
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
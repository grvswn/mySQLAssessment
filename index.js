const express = require('express');
const mysql2 = require('mysql2/promise');
const dotenv = require('dotenv');
const hbs = require('hbs');
const wax = require('wax-on');
const handlebarHelpers = require('handlebars-helpers')({
    'handlebars': hbs.handlebars
});

dotenv.config();

let app = express();
app.use(express.urlencoded({ extended: false }));

app.set('view engine', 'hbs');

wax.on(hbs.handlebars);
wax.setLayoutPath('./views/layouts');

async function main() {
    const connection = await mysql2.createConnection({
        host: process.env.DB_HOST,
        user: process.env.DB_USER,
        database: process.env.DB_DATABASE,
        password: process.env.DB_PASSWORD
    });

    app.get('/appointments', async function (req, res) {
        const [appointments] = await connection.execute(`
            SELECT * from appointments
            JOIN members ON appointments.member_id = members.member_id
            JOIN stylists ON appointments.stylist_id = stylists.stylist_id
            JOIN services ON appointments.service_id = services.service_id
        `);
        res.render('appointments/index', {
            appointments
        })
    });

    app.get('/appointments/create', async function (req, res) {
        const [members] = await connection.execute(`SELECT * from members`);
        const [stylists] = await connection.execute(`SELECT * from stylists`);
        const [services] = await connection.execute(`SELECT * from services`);
        res.render("appointments/create", {
            members, stylists, services
        });
    });

    app.post('/appointments/create', async function (req, res) {
        const { member_id, stylist_id, service_id, datetime } = req.body;
        const query = `
             INSERT INTO appointments (member_id, stylist_id, service_id, datetime) 
             VALUES (?, ?, ?, ?)
        `;
        const bindings = [parseInt(member_id), parseInt(stylist_id), parseInt(service_id), datetime];
        await connection.execute(query, bindings);
        res.redirect('/appointments');
    });

    app.get('/appointments/:appointment_id/delete', async function (req, res) {
        const sql = "select * from appointments where appointment_id = ?";
        const [appointments] = await connection.execute(sql, [req.params.appointment_id]);
        const appointmentToDelete = appointments[0];
        res.render('appointments/delete', {
            appointmentToDelete
        })
    });

    app.post('/appointments/:appointment_id/delete', async function (req, res) {
        const query = "DELETE FROM appointments WHERE appointment_id = ?";
        await connection.execute(query, [req.params.appointment_id]);
        res.redirect('/appointments');
    });

    app.get('/appointments/:appointment_id/update', async function (req, res) {
        const query = "SELECT * FROM appointments WHERE appointment_id = ?";
        const [appointments] = await connection.execute(query, [req.params.appointment_id]);
        const appointmentToEdit = appointments[0];

        const [members] = await connection.execute(`SELECT * from members`);
        const [stylists] = await connection.execute(`SELECT * from stylists`);
        const [services] = await connection.execute(`SELECT * from services`);

        res.render('appointments/update', {
            appointmentToEdit, members, stylists, services
        })
    });

    app.post('/appointments/:appointment_id/update', async function (req, res) {
        const { member_id, stylist_id, service_id, datetime } = req.body;
        const query = `UPDATE appointments SET member_id=?, stylist_id =?, service_id=?, datetime=? WHERE appointment_id = ?`;
        const bindings = [member_id, stylist_id, service_id, datetime, req.params.appointment_id];
        await connection.execute(query, bindings);
        res.redirect('/appointments');
    })

}
main();

app.listen(3000, () => {
    console.log("server has started");
});
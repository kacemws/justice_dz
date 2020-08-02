const functions = require('firebase-functions');
const admin = require('firebase-admin');
const nodemailer = require('nodemailer');
const cors = require('cors')({origin: true});
admin.initializeApp();

let transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
        user: 'boumiahmed86@gmail.com',
        pass: '4312wins'
    }
});

exports.sendSupport = functions.https.onRequest((req, res) => {
    cors(req, res, () => {
      
        // getting dest email by query string
        // const dest = req.query.dest;

        const mailOptions = {
            from: 'Ticket Support <boumiahmed86@gmail.com>', // Something like: Jane Doe <janedoe@gmail.com>
            to: 'berras.belkacem@gmail.com',
            subject: 'Support - Guide Justice', // email subject
            html: `
                <p style="font-size: 16px;">email  : ${req.query.email}</p>
                <p style="font-size: 16px;">nom  : ${req.query.name}</p>
                <p style="font-size: 16px;">objet  : ${req.query.object}</p>
                <p style="font-size: 16px;">message  : ${req.query.message}</p>
            ` // email content in HTML
        };
  
        // returning result
        return transporter.sendMail(mailOptions, (erro, info) => {
            if(erro){
                return res.send(erro.toString());
            }
            return res.send('Sent');
        });
    });    
});

exports.sendSignup = functions.https.onRequest((req, res) => {
    cors(req, res, () => {
      
        // getting dest email by query string
        const dest = req.query.dest;

        const mailOptions = {
            from: 'Signup ticket', // Something like: Jane Doe <janedoe@gmail.com>
            to: 'berras.belkacem@gmail.com',
            subject: 'Inscription - Guide Justice', // email subject
            html: `
                <p style="font-size: 16px;">nom  : ${req.query.nom}</p>
                <p style="font-size: 16px;">prenom  : ${req.query.prenom}</p>
                <p style="font-size: 16px;">numero telephone  : ${req.query.tel}</p>
                <p style="font-size: 16px;">adresse exact  : ${req.query.adresse}</p>
                <p style="font-size: 16px;">email  : ${req.query.email}</p>
                <p style="font-size: 16px;">spécialité  : ${req.query.specialite}</p>
                <p style="font-size: 16px;">horaire  : ${req.query.horaire}</p>
                <p style="font-size: 16px;">details supplémentaire  : ${req.query.details}</p>
                <p style="font-size: 16px;">wilaya  : ${req.query.wilaya}</p>
                <p style="font-size: 16px;">commune  : ${req.query.commune}</p>
                <p style="font-size: 16px;">gps  : ${req.query.gps}</p>
            ` // email content in HTML
        };
  
        // returning result
        return transporter.sendMail(mailOptions, (erro, info) => {
            if(erro){
                return res.send(erro.toString());
            }
            return res.send('Sent');
        });
    });    
});
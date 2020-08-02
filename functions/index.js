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
                <img src="https://images.prod.meredith.com/product/fc8754735c8a9b4aebb786278e7265a5/1538025388228/l/rick-and-morty-pickle-rick-sticker" />
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
            from: 'Your Account Name <yourgmailaccount@gmail.com>', // Something like: Jane Doe <janedoe@gmail.com>
            to: 'berras.belkacem@gmail.com',
            subject: 'Inscription - Guide Justice', // email subject
            html: `
                <p style="font-size: 16px;">email  : ${req.query.email}</p>
                <br />
                <p style="font-size: 16px;">nom  : ${req.query.name}</p>
                <br />
                <p style="font-size: 16px;">objet  : ${req.query.object}</p>
                <br />
                <p style="font-size: 16px;">message  : ${req.query.message}</p>
                <br />
                <img src="https://images.prod.meredith.com/product/fc8754735c8a9b4aebb786278e7265a5/1538025388228/l/rick-and-morty-pickle-rick-sticker" />
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
// Requiring in-built https for creating
// https server
const run = require('./d.js');
const https = require("https");
const express = require("express");
const app = express();

// Requiring file system to use local files
const fs = require("fs");

// Get request for root of the app
app.get("/", function (req, res) {
res.send("welcome Home")
});

// Creating object of key and certificate
// for SSL

walk()
async function walk(){
    let ff = await run()
    console.log(ff)
    let options = {
        key: fs.readFileSync("key.pem"),
        cert: fs.readFileSync("cert.pem"),
        //ca: fs.readFileSync("ca.pem"),
        ca:ff,
        requestCert: true,
        rejectUnauthorized: true
        };
    https.createServer(options, app)
    .listen(443, function (req, res) {
    console.log("Server started at port 443");
    });       
}


// Creating https server by passing
// options and app object


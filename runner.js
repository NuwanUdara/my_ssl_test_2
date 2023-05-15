// import {run} from './d.js';
const run = require('./d.js');

let options={};
async function walk(){
    let ff = await run()
    console.log(ff, typeof(ff))
}
walk()
// async function walk(){
//     let ff = await run()
//     console.log(ff, typeof(ff))
//     options = {
//         //key: fs.readFileSync("key.pem"),
//         //cert: fs.readFileSync("cert.pem"),
//         //ca: fs.readFileSync("ca.pem"),
//         ca:ff.toString(),
//         requestCert: true,
//         rejectUnauthorized: true
//         };
    
//         console.log(options);       
// }
// walk()



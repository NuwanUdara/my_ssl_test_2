// import {run} from './d.js';
const run = require('./d.js');

async function walk(){
    let ff = await run()
    console.log(ff)
}
walk()



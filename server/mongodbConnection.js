require('dotenv').config()
const mongoose = require('mongoose')
const chalk = require('chalk')

mongoose.connect(process.env.MONGODB_LOCAL,
    {
        useNewUrlParser: true,
        useUnifiedTopology: true
    }, (err, db) => {
        try {
            console.log(chalk.white.bgGreen("Database connected successfully! "))
        } catch (e) {
            throw e
        }
    })
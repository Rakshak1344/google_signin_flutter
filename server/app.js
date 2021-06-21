require('dotenv').config()
require('./mongodbConnection')

const express = require('express')
const chalk = require('chalk')
const userRoutes = require('./routes/userRoutes')
const taskRoutes = require('./routes/taskRoutes')

const app = express()
const port = process.env.PORT


app.use(express.urlencoded({ extended: true }))
app.use(express.json())

app.use(userRoutes)
app.use(taskRoutes)


app.listen(port, () => {
    console.log(chalk.white.bgGreen(`Server running in port ${port}`))
})
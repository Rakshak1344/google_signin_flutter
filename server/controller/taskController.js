const Task = require('../models/task')
const { ok200, ok201 } = require('../handlers/successHandlers')
const { err400, err404 } = require('../handlers/ErrorHandlers')

module.exports.addTask = async (req, res) => {
    // console.log(req.user)
    // console.log(req.token)

    try {
        const task = await Task.create(req.body)
        if (!task) throw new Error("Something went wrong!")
        console.log(task)
        res.status(201).json(ok201(task))
    } catch (e) {
        res.status(400).json(err400(e.message))
    }
}

module.exports.getAllTask = async (req, res) => {
    console.log("Get all task")
    try {
        const tasks = await Task.find({})
        console.log(tasks)
        if (!tasks) throw new Error('No task found')
        res.status(200).json(ok200(tasks))
    } catch (e) {
        res.status(400).json(err400(e.message))
    }
}
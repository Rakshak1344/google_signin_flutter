const mongoose = require('mongoose')

const taskSchema = new mongoose.Schema({
    taskName: {
        type: String,
        required: [true, "Task name is invalid"],
    },
    done: {
        type: Boolean,
        required: [true, "Task Status invalid"],
    }
})

const Task = mongoose.model('task', taskSchema)

module.exports = Task
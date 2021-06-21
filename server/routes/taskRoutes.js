const { Router } = require('express')
const router = Router()
const taskController = require('../controller/taskController')
const auth = require('../middleware/auth')

router.post('/task', auth, taskController.addTask)
router.get('/task', auth, taskController.getAllTask)

module.exports = router
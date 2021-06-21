const { Router } = require('express')
const router = Router()

const userController = require('../controller/userController')

// login in with email and password
router.post('/login', userController.login)

// Register with email and password
router.post('/register', userController.register)


module.exports = router
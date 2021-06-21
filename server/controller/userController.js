const User = require("../models/user")
const { ok200, ok201, ok201UserWithToken } = require('../handlers/successHandlers')
const { err400, err404 } = require('../handlers/ErrorHandlers')

module.exports.login = async (req, res) => {
    try {

        const { email, password } = req.body
        // check if email and password matched in DB
        const user = await User.findByCredentials(email, password)
        if (!user) {
            throw new Error("email or password is invalid")
        }
        console.log(`User valid ${user}`)
        const token = await user.generateWebToken()

        res.status(201).json(ok201UserWithToken(user, token))
    } catch (e) {
        res.status(404).json(err404(e.message))
    }
}

module.exports.register = async (req, res) => {
    console.log(req.body)
    try {
        // const { email } = req.body
        // If user is present in database 
        // const userPresent = await User.findOne({ email })
        // if (userPresent) throw Error("User already registered, please login!")

        // User save to DB
        const user = await User.create(req.body)
        if (!user) throw Error("No user created")
        const token = await user.generateWebToken()
        res.status(201).json(ok201UserWithToken(user, token))
    } catch (e) {
        if (e.code == 11000) {
            res.status(400).json(err400("User already registered, please login!"))
        }
        res.status(400).json(err400(e.message))
    }
}
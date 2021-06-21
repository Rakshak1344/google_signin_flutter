const jwt = require('jsonwebtoken')
const User = require('../models/user')
const { err400 } = require('../handlers/ErrorHandlers')

const auth = async (req, res, next) => {
    // console.log(req.body)
    try {
        const token = req.header('Authorization').replace('Bearer ', '')
        // console.log(token)

        const decodedData = jwt.verify(token, 'MySecretKey')
        if (!decodedData) throw new Error("User expired, please login!")
        console.log(decodedData)

        const user = await User.findOne({ "email": decodedData.email, "tokens.token": token })
        if (!user) throw new Error("User Invalid")
        // console.log(user)

        req.user = user
        req.token = token
        next()
    } catch (e) {
        console.log(e)
        if (e.name == "JsonWebTokenError") {
            res.status(400).json(err400("User expired, please login!"))
        }
        res.status(400).json(err400(e.message))
    }

}

module.exports = auth
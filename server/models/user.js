const mongoose = require('mongoose')
const val = require('validator')
const bcrypt = require('bcrypt')
const jwt = require('jsonwebtoken')

const userSchema = new mongoose.Schema({
    email: {
        type: String,
        required: [true, "please enter an email"],
        unique: true,
        trim: true,
        lowercase: true,
        validate: [val.isEmail, "Invalid email"]
    },
    password: {
        type: String,
        required: [true, "please enter an password"],
        minlength: [2, "minimum password length is 2 character"]
    },
    tokens: [{
        token: {
            type: String
        }
    }]
})

userSchema.statics.findByCredentials = async (email, password) => {
    const user = await User.findOne({ email })
    console.log(`User found ${user} `)
    if (!user)
        throw new Error("Email or password is invalid")

    const isMatch = await bcrypt.compare(password, user.password)
    if (!isMatch)
        throw new Error("Email or password is invalid")

    console.log(isMatch)
    return user
}

userSchema.methods.toJSON = function () {
    const user = this
    const userObject = user.toObject()

    delete userObject.password
    delete userObject.tokens

    return userObject
}

userSchema.methods.generateWebToken = async function () {
    const user = this
    const token = await jwt.sign({ _id: user._id.toString(), email: user.email }, 'MySecretKey')
    user.tokens = user.tokens.concat({ token })
    console.log(user)
    await user.save()
    return token
}

userSchema.pre('save', async function (next) {
    const user = this
    console.log(`Befor hashing password ${user}`)
    if (user.isModified('password')) {
        user.password = await bcrypt.hash(user.password, 8)
    }
    console.log(`This is pre - writing to Database ${user}`)
    next()
})

userSchema.post('save', async function (doc, next) {
    console.log("This is post - writing to Database")
    // Send email to user that user is registered!
    console.log("Send email to user")
    console.log(`Document after data saved to DB ${doc}`)
    next()
})

const User = mongoose.model('user', userSchema)

module.exports = User
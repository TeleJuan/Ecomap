const { Schema,model } = require('mongoose')
const bcrypt = require('bcryptjs')

const locationSchema = new Schema({
    name: String,
    latitude: Number,
    longitude: Number,
    type: String
})

module.exports = model('Location',locationSchema)
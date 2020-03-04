const { Schema,model } = require('mongoose')
const bcrypt = require('bcryptjs')

const locationSchema = new Schema({
    latitude: Number,
    longitude: Number,
    types: String
})

module.exports = model('Location',locationSchema)
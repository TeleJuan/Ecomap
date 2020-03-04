const { Schema,model } = require('mongoose')
const bcrypt = require('bcryptjs')

const cajaSchema = new Schema({
	email: String,
    P: Number,
    V: Number,
    L:Number,
    latitude: Number,
    longuitude: Number
})

module.exports = model('caja',cajaSchema)
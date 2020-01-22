const mysql = require('mysql');
const express = require('express')
const bodyParser = require("body-parser")

const app = express()

app.use(
    bodyParser.urlencoded({
        extended: true
    })
)

app.use(bodyParser.json())
var conexion = mysql.createConnection({
    host: 'localhost',
    database: 'apiNode',
    user: 'juan',
    password: 'password',
});

conexion.connect(function (err) {
    if (err) {
        console.error('Error de conexion: ' + err.stack);
        return;
    }
    console.log('Conectado con el identificador ' + conexion.threadId);
});


// TODO: replicar y cambiar la query
app.get('/', async function (req, res) {

    query = 'SELECT * FROM usuario';

    conexion.query(query, function (error, results, fields) {
        if (error)
            throw error;
        res.send(results);
    })

})

app.post('/',function(req,res){
    console.log("Post recibido")
    console.log(req.body)
    res.send('Post')
})


app.listen(3000, () => {
    console.log("Servidor en el puerto 3000");
})

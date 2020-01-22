var mysql = require('mysql');
var conexion= mysql.createConnection({
    host : 'localhost',
    database : 'apiNode',
    user : 'juan',
    password : 'password',
});

conexion.connect(function(err) {
    if (err) {
        console.error('Error de conexion: ' + err.stack);
        return;
    }
    console.log('Conectado con el identificador ' + conexion.threadId);
});

conexion.query('SELECT * FROM test', function (error, results, fields) {
    if (error)
        throw error;

    results.forEach(result => {
        console.log(result['campo']);
    });
});

conexion.end();
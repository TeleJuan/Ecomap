import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _user = '';
  String _email = '';
  String _pass = '';
  String _confirmationPass = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(
                height: 60.0,
              ),
              crearUsuario(),
              SizedBox(
                height: 30.0,
              ),
              crearCorreo(),
              SizedBox(
                height: 30.0,
              ),
              crearPass(),
              SizedBox(
                height: 30.0,
              ),
              confirmacionPass(),
              SizedBox(
                height: 80.0,
              ),
              registerButton(context),
              SizedBox(
                height: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  crearUsuario() {
    return TextField(
      //autofocus: true,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.green)),
          hintText: 'Usuario',
          labelText: 'Usuario',
          icon: Icon(
            Icons.account_circle,
            color: Colors.green,
          )),
      onChanged: (valor) => setState(() {
        _email = valor;
      }),
    );
  }

  Widget crearCorreo() {
    return TextField(
      //autofocus: true,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Email',
          labelText: 'Email',
          suffixIcon: Icon(
            Icons.alternate_email,
            color: Colors.green,
          ),
          icon: Icon(
            Icons.email,
            color: Colors.green,
          )),
      onChanged: (valor) => setState(() {
        _email = valor;
      }),
    );
  }

  Widget crearPass() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Password',
          labelText: 'Password',
          icon: Icon(Icons.lock_open,color: Colors.green,)),
      onChanged: (valor) => setState(() {
        _email = valor;
      }),
    );
  }

  Widget confirmacionPass() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Password',
          labelText: 'Password',
          icon: Icon(Icons.lock_outline,color: Colors.green,)),
      onChanged: (valor) => setState(() {
        _email = valor;
      }),
    );
  }

  registerButton(BuildContext context) {
    final Size _screenSize = MediaQuery.of(context).size;
    return Container(
      width: _screenSize.width * 0.5,
      height: 50.0,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.green,
        child: Text(
          'Registrarse',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {},
      ),
    );
  }
}

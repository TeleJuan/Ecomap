import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController confirmpasswordController = TextEditingController();

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
      controller: usernameController,
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
      }),
    );
  }

  Widget crearCorreo() {
    return TextField(
      //autofocus: true,
      controller: emailController,
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
        
      }),
    );
  }

  Widget crearPass() {
    return TextField(
      obscureText: true,
      controller: passwordController,
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
      controller: confirmpasswordController,
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

  registerButton(BuildContext context,) {
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
        onPressed: (emailController.text==""||usernameController.text==""||passwordController.text==""||(passwordController.text!=confirmpasswordController.text))?null: () async { 
          print("Registrandose");
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          Map data ={
            'email':emailController.text,
            'username':usernameController.text,
            'password':passwordController.text
          };
          //verificar que el correo y/o usuario no esten en uso

          //verificar que las contraseñas coincidan

          //enviar post
          var jsonResponse = null;
          var response = await http.post("http://10.0.2.2:3000/signup",body: data);
          jsonResponse = json.decode(response.body);
          print(jsonResponse);
           sharedPreferences.setString("token", jsonResponse['token']);
           sharedPreferences.setString("email", emailController.text);
           if(jsonResponse['token'] != null){
            Navigator.of(context).pushNamed('/');
          }
          //
        },
      ),
    );
  }
}

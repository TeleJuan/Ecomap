import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _userName;
  bool _isLoading = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size _screen = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomPadding: true,
        
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green,Colors.greenAccent,Colors.teal],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
            )
          ),
          child: _isLoading?Center(child: CircularProgressIndicator(),): SafeArea(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                SingleChildScrollView(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        _logo(),
                        SizedBox(
                          height: 40,
                        ),
                        _loginCard(_screen),
                        SizedBox(
                          height: 40,
                        ),
                        _loginButton(),
                        SizedBox(
                          height: 40.0,
                        ),
                        _loginFooter(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget _logo() {
    return Container(
      padding: EdgeInsets.only(left: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
              child: Text(
            'ECOMAP',
            style: TextStyle(fontSize: 35, color: Colors.white),
          )),
          Image(
            image: NetworkImage(
                'https://www.stickpng.com/assets/images/58afdadd829958a978a4a694.png'),
            height: 175,
          ),
        ],
      ),
    );
  }

  Widget _loginCard(Size size) {
    return Center(
        child: Container(
      height: 250,
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              offset: Offset(0.0, 15.0),
              color: Colors.black12,
              blurRadius: 15.0),
          BoxShadow(
              offset: Offset(0.0, -11.0),
              color: Colors.black12,
              blurRadius: 10.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 15.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Login',
              style: TextStyle(fontSize: 25),
            ),
            _createEmail(),
            SizedBox(
              height: 20.0,
            ),
            _createPass(),
            SizedBox(
              height: 25.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Material(
                  child: InkWell(
                    child: Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.all(2.5),
                      child: Text(
                        'Contraseña Olvidada?',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                    onTap: () {
                      print('uwu');
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  Widget _createEmail() {
    return TextField(
      controller: emailController,
      decoration: InputDecoration(
          border: UnderlineInputBorder(),
          hintText: 'Email',
          labelText: 'Email',
          icon: Icon(
            Icons.account_circle,
            color: Colors.green,
          )),
      onChanged: (valor) => setState(() {
        _userName = valor;
      }),
    );
  }

  Widget _createPass() {
    return TextField(
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        hintText: 'Password',
        labelText: 'Password',
        icon: Icon(
          Icons.lock_open,
          color: Colors.green,
        ),
      ),
    );
  }

  _loginButton() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      RaisedButton(
        color: Colors.greenAccent,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Text(
          'Iniciar Sesión',
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        onPressed : emailController.text ==""||passwordController.text == ""? null :(){
          setState(() {
            _isLoading = true;
          });
          signIn(emailController.text, passwordController.text);
        },
        elevation: 0.0,
        ),
    ]);
  }

  Widget _loginFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Nuevo usuario?  ',style: TextStyle(color: Colors.white),),
        InkWell(
          child: Text('Registrarse',style: TextStyle(color: Colors.greenAccent,fontWeight: FontWeight.bold),),
          onTap: (){
            Navigator.pushNamed(context, 'register');
          },
        )
      ],
    );
  }

  signIn(String email, pass) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'email':email,
      'password':pass
    };
    var jsonResponse = null;
    print(data);
    var response = await http.post("http://10.0.2.2:3000/signin",body: data);
    jsonResponse = json.decode(response.body);
    print(jsonResponse);
    if(jsonResponse != null){
      setState(() {
        _isLoading = false;
      });
      sharedPreferences.setString("token", jsonResponse['token']);
      if(jsonResponse['token'] != null){
        Navigator.of(context).pushNamed('/');
      }
    }
    else{
      setState(() {
        _isLoading = false;  
      });
      print(response.body);
    }
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'login_page.dart';
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  SharedPreferences sharedPreferences;
  Map<String,dynamic> jsonResponse;

  String _username = "username";
  String _email = "email";
  String _location = "location";
  Map<String,String> data;
  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token")== null){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=>LoginPage()), (Route<dynamic> route)=>false);
    }
    else {
      data = {"email":sharedPreferences.getString("email")};
      var response = await http.post("http://10.0.2.2:3000/userdata",body: data);
      jsonResponse = json.decode(response.body);
      print(jsonResponse);
      setState(() {
        _username = jsonResponse['username'];
        _email = jsonResponse['usermail'];
      });
    }

  }

  @override
  void initState(){
    super.initState();
    checkLoginStatus();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
          elevation: 0.0,
        backgroundColor: Colors.greenAccent.withOpacity(0.0),
        leading: FlatButton(
          onPressed: ()=>Navigator.of(context).pop(), 
          child: Icon(
            Icons.keyboard_backspace,
            color: Colors.black26,
            ),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: (){
                sharedPreferences.clear();
                sharedPreferences.commit();
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=>LoginPage()), (Route<dynamic> route)=>false);

          }, child: Text("Logout",style: TextStyle(color:Colors.black38),))],
      ),
      body: ListView(
        children: <Widget>[
          detailBox(context),
          SizedBox(height: MediaQuery.of(context).size.height*0.05,),
          pointBox(context),
        ],
      ),
    );
  }

  Widget detailBox(context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
              child: Container(
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
          width: MediaQuery.of(context).size.width*0.85,
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Datos usuario",style: TextStyle(fontSize: 20.0, decoration: TextDecoration.underline),),
              SizedBox(height: 10),
              Container(
                height: 35.0,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.alternate_email),
                    SizedBox(width: 10,),
                    Text(_email,style: TextStyle(fontSize: 16),),
                  ],
                ),
              ), //aqui
              Container(
                height: 35.0,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.account_circle),
                    SizedBox(width: 10.0,),
                    Text(_username,style: TextStyle(fontSize: 16),), //aqui
                    Expanded(child: SizedBox()),
                    FlatButton(
                      child: Icon(Icons.edit),
                      onPressed: (){
                        //esto deberia abrir un alert con un textedit que permita cambiar la propiedad
                       

                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                           title: Text('Cambiar Username'),
                          content: TextField(
                            decoration: InputDecoration(hintText: "Ingresar nuevo Username"),
                          ),
                          actions: <Widget>[
                            new FlatButton(
                              child: new Text('Cambiar'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      
                      },
                    )
                  ],
                ),
              ),
              Container(
                height: 35.0,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.location_on),
                    SizedBox(width: 10.0,),
                    Text(_location,style: TextStyle(fontSize: 16),), //aqui
                    Expanded(child: SizedBox()),
                    FlatButton(
                      child: Icon(Icons.edit),
                      onPressed: (){
                        //esto deberia abrir un alert con un textedit que permita cambiar la propiedad
                         // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                           title: Text('Cambiar ubicacion caja'),
                          content: TextField(
                            decoration: InputDecoration(hintText: "Ingresar nueva ubicacion"),
                          ),
                          actions: <Widget>[
                            new FlatButton(
                              child: new Text('Cambiar'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      
                      },
                    )
                  ],
                ),
              ),
            ],
            ),
          ),
        ),
      ),
    );
  }

  Widget pointBox(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
        width: MediaQuery.of(context).size.width*0.85,
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Puntos de Reciclaje",style: TextStyle(fontSize: 20.0, decoration: TextDecoration.underline)),
              SizedBox(height:15),
              Text("-     Veces recicladas:"),
              SizedBox(height:10),
              Text("Detalle:",style: TextStyle(fontSize: 15.0, decoration: TextDecoration.underline)),
              SizedBox(height:10),
              Text("-     Latas:"),
              SizedBox(height:10),
              Text("-     Botellas de vidrio:"),
              SizedBox(height:10),
              Text("-     Botellas de plastico:"),
            ],
          ),
        ),
        ),
      ),
    );
  }

 
}
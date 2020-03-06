import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'login_page.dart';

enum RecycleItems { glass, plastic, beercan }

class BoxPage extends StatefulWidget {


  BoxPage({Key key}) : super(key: key);

  @override
  _BoxPageState createState() => _BoxPageState();
}

class _BoxPageState extends State<BoxPage> {

  

  RecycleItems _recycleItems = RecycleItems.glass;
  SharedPreferences sharedPreferences;
  Map<String,String> data;
  double cambio = 1.0;
  Map<String,int> box = {
    'P' : 0,
    'V' : 0, 
    'L' : 0
  };
  Map<String,dynamic> jsonResponse;

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token")== null){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=>LoginPage()), (Route<dynamic> route)=>false);
    }
    else {
      data = {"email":sharedPreferences.getString("email")};
      var response = await http.post("http://10.0.2.2:3000/usercaja",body: data);
      jsonResponse = json.decode(response.body);
      setState(() {
        box['P'] = jsonResponse['P'];
        box['L'] = jsonResponse['L'];
        box['V'] = jsonResponse['V'];
      });
    }
  }

  @override
  void initState(){
    checkLoginStatus();
    super.initState();
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
      ),
      body: _crearCaja(context),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          // set up the AlertDialog
          AlertDialog alert = AlertDialog(
              title: Text('Agregar objeto'),
            content: StatefulBuilder(
                builder:(context, setState) {
                 return  Container(
                height: MediaQuery.of(context).size.height*0.25,
                child: Column(
                  children: <Widget>[
                    Row( 
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Image(
                              image: AssetImage('assets/beercan.png'),
                              height: 70,
                            ),
                            Radio(
                              value: RecycleItems.beercan, 
                              groupValue: _recycleItems, 
                              onChanged: (RecycleItems value){
                                setState(() {
                                _recycleItems = value;
                              });
                            })
                          ],
                        ),
                        SizedBox(width: 15,),
                        Column(
                          children: <Widget>[
                            Image(
                              image: AssetImage('assets/plasticbottle.png'),
                              height: 70,
                            ),
                            Radio(
                              value: RecycleItems.plastic, 
                              groupValue: _recycleItems, 
                              onChanged: (RecycleItems value){
                                setState(() {
                                _recycleItems = value;
                              });
                            })
                          ],
                        ),
                        SizedBox(width: 15,),
                        Column(
                          children: <Widget>[
                            Image(
                              image: AssetImage('assets/glassbottle.png'),
                              height: 70,
                            ),
                            Radio(
                              value: RecycleItems.glass, 
                              groupValue: _recycleItems, 
                              onChanged: (RecycleItems value){
                                setState(() {
                                _recycleItems = value;
                              });
                            })
                          ],
                        ),
                      ],
                    ),
                    Slider(value: cambio,divisions: 10,min: 1,max: 10,label: "${cambio.floor()}", onChanged: (newvalue){
                      setState(() {
                        cambio = newvalue;
                      });
                    })
                  ],
                ),
              );}
            ),
            actions: <Widget>[
              FlatButton(
                child: new Text('Añadir'),
                onPressed: () async {
                  Map<String,String> modificar = new Map();
                  if(_recycleItems.toString()=="RecycleItems.plastic")modificar['P'] = cambio.floor().toString();
                  else if(_recycleItems.toString()=="RecycleItems.glass")modificar['V'] = cambio.floor().toString();
                  else if(_recycleItems.toString()=="RecycleItems.beercan")modificar['L'] = cambio.floor().toString();
                  modificar['email'] = sharedPreferences.getString("email");
                  print(modificar);
                  
                  await http.post("http://10.0.2.2:3000/updatecaja",body: modificar);

                }

              ),
              FlatButton(
                child: new Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              
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
        child: Icon(Icons.add),
        ),
    );
  }

  Widget _crearCaja(context) {
    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height*0.1,),
          Container(
            padding: EdgeInsets.all(15.0),
            width: MediaQuery.of(context).size.width*0.95,
            height: MediaQuery.of(context).size.height*0.4,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Caja",style: TextStyle(fontSize: 25.0),),
                SizedBox(height: 15,),
                Text("Elementos en la caja del usuario",style: TextStyle(fontSize: 20),),
                SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Image(image: AssetImage('assets/beercan.png'),height: MediaQuery.of(context).size.height*0.15,),
                        Text(box['L'].toString())
                      ],
                    ),
                    SizedBox(height:10),
                    Column(
                      children: <Widget>[
                        Image(image: AssetImage('assets/glassbottle.png'),height: MediaQuery.of(context).size.height*0.15,),
                        Text(box['V'].toString())
                      ],
                    ),
                    SizedBox(height:10),
                    Column(
                      children: <Widget>[
                        Image(image: AssetImage('assets/plasticbottle.png'),height: MediaQuery.of(context).size.height*0.15,),
                        Text(box['P'].toString())
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
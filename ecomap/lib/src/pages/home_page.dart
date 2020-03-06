//import 'dart:html';

import 'package:ecomap/src/pages/login_page.dart';
import 'package:ecomap/src/widgets/home_button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferences sharedPreferences;
  bool loged = false;
  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    print(sharedPreferences.getString("token"));
    if(sharedPreferences.getString("token")== null){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=>LoginPage()), (Route<dynamic> route)=>false);
    }
    else{
      setState(() {
        loged = true;
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
    final Size size = MediaQuery.of(context).size;
    return !loged?
    Center(
      child: CircularProgressIndicator(backgroundColor: Colors.greenAccent[400],),
    )
    :Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.greenAccent[400],
        title: Text('Inicio'),
        actions: <Widget>[
          InkWell(
            child: Icon(
              Icons.account_circle,
              size: 50.0,
            ),
            onTap: () {
              Navigator.pushNamed(context, 'profile');
            },
          )
        ],
      ),
      body: _optionCards(context, size),
    );
  }

  Widget _optionCards(BuildContext context, Size size) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
      child: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _card(context,size,'assets/mapaverde.png','recycle','Reciclar'),
              SizedBox(height: 45,),
              _card(context,size,'assets/caja.png','box','Caja de reciclaje'),
              SizedBox(height: 45,),
            ],
          )
        ],
      ),
    );
  }

   Widget _card(BuildContext context,Size size, String asset, String accion,String texto) {
    final card = Container(
      child: GestureDetector(
        onTap: ()=>Navigator.of(context).pushNamed(accion),
        child: Column(
          children: <Widget>[
            Image(
                image: AssetImage(
                    asset),
                width: size.width*0.70, 
                fit: BoxFit.cover),
            Container(
                padding: EdgeInsets.all(10.0),
                child: Text(texto))
          ],
        ),
      ),
    );
    
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color:Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: Offset(2.0,10.0)
            ),
        ]
      ),
      child: ClipRRect(
        child: card,
        borderRadius: BorderRadius.circular(30.0),
      ),
    );
  }
}

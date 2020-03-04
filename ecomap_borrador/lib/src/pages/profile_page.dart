import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.greenAccent,
      ),
      body: Column(
        children: <Widget>[
          //_createPhoto(),
          //_createDescription()
        ],
      ),
    );
  }

  Widget _createPhoto() {
    return Container(
      decoration:  BoxDecoration(
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
      child: FadeInImage(
        fit:BoxFit.cover,
        placeholder: AssetImage("asdf"),  // falta un asset 
        image: NetworkImage("asdf") // sacar direccion de un get(?)
        ),
    );
  }

  Widget _createDescription() {
    
  }
}
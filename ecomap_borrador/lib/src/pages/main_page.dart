import 'package:ecomap_borrador/src/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  SharedPreferences sharedPreferences;

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token")== null){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=>LoginPage()), (Route<dynamic> route)=>false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("home", style:TextStyle(color: Colors.greenAccent)),
        actions: <Widget>[
          FlatButton(
            onPressed: (){
                sharedPreferences.clear();
                sharedPreferences.commit();
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=>LoginPage()), (Route<dynamic> route)=>false);

          }, child: Text("Logout",style: TextStyle(color:Colors.greenAccent),))
        ],
      ),      
      body: Center(
        child:Text("Main Page"),
      ),
      drawer: Drawer(
        child:  ListView(
          children: <Widget>[
             UserAccountsDrawerHeader(
              accountName: Text("Nodejs"), 
              accountEmail: Text("juan@gmail.com")
            ),
             ListTile(
              title: Text("lista"),
              trailing:  Icon(Icons.add),
              onTap: (){},
            )
          ],
        )
      ),
    );
  }
}
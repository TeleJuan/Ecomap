import 'package:ecomap/src/datasmodels/user_location.dart';
import 'package:ecomap/src/widgets/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:ecomap/src/pages/login_page.dart';
import 'package:ecomap/src/widgets/home_button_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeTempPage extends StatefulWidget {
  @override
  _HomeTempPageState createState() => _HomeTempPageState();
}

class _HomeTempPageState extends State<HomeTempPage> {

  SharedPreferences sharedPreferences;

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    print(sharedPreferences.getString("token"));
    if(sharedPreferences.getString("token")== null){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=>LoginPage()), (Route<dynamic> route)=>false);
    }
  }

  @override
  void initState(){
    super.initState();
    checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    final Size _screenSize = MediaQuery.of(context).size;
    /*
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Loader()),
    );
    */
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.greenAccent.withOpacity(0.0),
        actions: <Widget>[
          FlatButton(
            onPressed: (){
                sharedPreferences.clear();
                sharedPreferences.commit();
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=>LoginPage()), (Route<dynamic> route)=>false);

          }, child: Text("Logout",style: TextStyle(color:Colors.greenAccent),))
        ]
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50.0,
              ),
              _titulo(),
              SizedBox(
                height: 50.0,
              ),
              SizedBox(
                height: 50.0,
              ),
              _login(_screenSize),
              SizedBox(
                height: 10.0,
              ),
              _registro(_screenSize),
              SizedBox(
                height: 10.0,
              ),
              _home(_screenSize),
              SizedBox(
                height: 10.0,
              ),
              _recycle(_screenSize),
              SizedBox(
                height: 10.0,
              ),
              _profile(_screenSize),
            ],
          ),
        ),
      ),
    );
    
  }

  Widget _titulo() {
    return Container(
      child: Text(
        'ECOMAP',
        style: TextStyle(
          fontSize: 32,
          backgroundColor: Colors.greenAccent,
        ),
      ),
    );
  }

  Widget _logo(Size size) {
    return Container(
      width: size.width * 0.7,
      child: Image(
        image: NetworkImage(
            'http://d2hkaprgf6waz1.cloudfront.net/sites/elmartutino.cl/files/imagecache/principal_mobile/imagen_noticia/mapaverde.jpg'),
      ),
    );
  }

  Widget _login(Size size) {
    return RedirectButton('login', 'Login');
  }

  Widget _registro(Size size) {
    return RedirectButton('register', 'Registro');
  }

  Widget _home(Size screenSize) {
    return RedirectButton('home', 'Home');
  }

  Widget _recycle(Size screenSize) {
    return RedirectButton('recycle', 'Reciclar');
  }

  Widget _profile(Size screenSize) {
    return RedirectButton('profile', 'Perfil');
  }
}

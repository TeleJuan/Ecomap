import 'package:ecomap_borrador/src/widgets/home_button_widget.dart';
import 'package:flutter/material.dart';

class HomeTempPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50.0,
              ),
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

  // TODO: cambiar a raisedbutton
  Widget _login(Size size) {
    return RedirectButton('login', 'Login');
  }

  Widget _registro(Size size) {
    return RedirectButton('register', 'Registro');
  }

  Widget _home(Size screenSize) {
    return RedirectButton('home', 'Home');
  }
}

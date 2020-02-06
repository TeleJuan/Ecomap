import 'package:ecomap_borrador/src/widgets/home_button_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
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
              Navigator.pushNamed(context, 'settings');
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _card(context,size,'http://d2hkaprgf6waz1.cloudfront.net/sites/elmartutino.cl/files/imagecache/principal_mobile/imagen_noticia/mapaverde.jpg','Ir a reciclar'),
            ],
          )
        ],
      ),
    );
  }

   Widget _card(BuildContext context,Size size, String asset, String accion) {
    final card = Container(
      child: Column(
        children: <Widget>[
          FadeInImage(
              image: NetworkImage(
                  asset),
              placeholder: NetworkImage(
                  'http://d2hkaprgf6waz1.cloudfront.net/sites/elmartutino.cl/files/imagecache/principal_mobile/imagen_noticia/mapaverde.jpg'),
              fadeInDuration: Duration(milliseconds: 200),
              width: size.width*0.85,
              fit: BoxFit.cover),
          Container(
              padding: EdgeInsets.all(10.0),
              child: Text('Reciclar'))
        ],
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

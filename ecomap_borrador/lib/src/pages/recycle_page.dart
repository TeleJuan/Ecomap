import 'package:ecomap_borrador/src/widgets/checkbox_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
class RecyclePage extends StatefulWidget {
  @override
  _RecyclePageState createState() => _RecyclePageState();
}

class _RecyclePageState extends State<RecyclePage> {

  CameraPosition _initialPosition = CameraPosition(target: LatLng(26.8206, 30.8025));
Completer<GoogleMapController> _controller = Completer();


void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reciclar"),
        backgroundColor: Colors.greenAccent,
        leading: FlatButton(
          onPressed: ()=>Navigator.of(context).pop(), 
          child: Icon(
            Icons.keyboard_backspace,
            color: Colors.white,
            ),
        ),
      ),
      body: _createColumn(),
    );
  }

  Widget _createColumn() {
    CheckboxImage _plastic = CheckboxImage("plasticbottle");
    CheckboxImage _glass= CheckboxImage("glassbottle");
    CheckboxImage _beercan = CheckboxImage("beercan");
    return Container(
      padding: EdgeInsets.only(top:25.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 50,),
          Text("¿Qué deseas reciclar?",style: TextStyle( fontSize: 34.0),),
          _mapGenerator(),
          Row(
            children: <Widget>[
              _plastic,
              SizedBox(width: 15,),
              _glass,
              SizedBox(width: 15,),
              _beercan,
              SizedBox(width: 30,),
            ]

          ),
          SizedBox(height: 50,),
          ButtonTheme(
        minWidth: 150,
        child: RaisedButton(

          onPressed: (){
             int total = 0;
             total += _plastic.value?1:0;
             total += _glass.value?4:0;
             total += _beercan.value?9:0;

             print("El total es $total");
          },
          child: Text("Continuar",style: TextStyle(color: Colors.white,fontSize: 30),textAlign: TextAlign.center,),
          color: Colors.greenAccent,
        ),
      )
        ],),
    );
  }

  Widget _mapGenerator() {
    return Container(
      height: 40.0,
      width: double.infinity,
      child: GoogleMap(    
        onMapCreated: _onMapCreated,
        initialCameraPosition: _initialPosition,
      ),
    );
  }
}

import 'package:ecomap/src/datasmodels/user_location.dart';
import 'package:ecomap/src/widgets/checkbox_image_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:provider/provider.dart';
class RecyclePage extends StatefulWidget {
  @override
  _RecyclePageState createState() => _RecyclePageState();
}

class _RecyclePageState extends State<RecyclePage> {

  CheckboxImage _plastic;


  Map<String,double> currentLocation = new Map();
  
  CameraPosition _initialPosition;
  Completer<GoogleMapController> _controller = Completer();
  var userLocation; 
@override
  void initState() {

    super.initState();
  }

void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
}


  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<UserLocation>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.greenAccent.withOpacity(0.5),
        title: Text(
          "¿Qué deseas reciclar?",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            shadows: <Shadow>[
          Shadow(
            offset: Offset(1.0, 1.0),
            blurRadius: 3.0,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          
        ],),),
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
   _plastic = CheckboxImage("plasticbottle");
    CheckboxImage _glass= CheckboxImage("glassbottle");
    CheckboxImage _beercan = CheckboxImage("beercan");
    return ListView(
          children: <Widget>[

          Container(
        padding: EdgeInsets.only(top:25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10,),
            _mapGenerator(),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _plastic,
                SizedBox(width: 15,),
                _glass,
                SizedBox(width: 15,),
                _beercan,
                SizedBox(width: 30,),
              ]

            ),
            SizedBox(height: 20,),
            ButtonTheme(
          minWidth: 150,
          child: RaisedButton(

            onPressed: (){
               String total = '';
               total += _plastic.value?'P':'';
               total += _glass.value?'V':'';
               total += _beercan.value?'L':'';

               print("El total es " + total);
            },
            child: Text("Buscar",style: TextStyle(color: Colors.white,fontSize: 30),textAlign: TextAlign.center,),
            color: Colors.greenAccent,
          ),
        )
          ],),
      ),
          ],
    );
  }

  Widget _mapGenerator() {
    var userLocation = Provider.of<UserLocation>(context);
    _initialPosition = CameraPosition(target: LatLng(userLocation.latitude, userLocation.longitude),zoom: 20.0);
    return Container(
      height: 400.0,
      width: double.infinity,
      child: GoogleMap(    
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
          new Factory<OneSequenceGestureRecognizer>(() => new EagerGestureRecognizer(),),
          ].toSet(),
        myLocationEnabled: true,
        onMapCreated: _onMapCreated,
        initialCameraPosition: _initialPosition,
      ),
    );
  }
}

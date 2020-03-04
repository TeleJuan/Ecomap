import 'package:flutter/material.dart';

class MapPage extends StatefulWidget {
  final double mapType; 

  MapPage({Key key, @required this.mapType}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(widget.mapType.toString()),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class RedirectButton extends StatelessWidget {
  final String _route;
  final String _title;
  
  RedirectButton(this._route,this._title);

  @override
  Widget build(BuildContext context) {

  final Size _screenSize = MediaQuery.of(context).size;

    return Container(
      width: _screenSize.width*0.5,
      child: RaisedButton(
        onPressed: ()=>Navigator.pushNamed(context, _route),
        child: Text(_title,style: TextStyle(color: Colors.white,fontSize: 30),textAlign: TextAlign.center,),
        color: Colors.blueAccent,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CheckboxImage extends StatefulWidget {
  final String _image;
  bool value = false;
  CheckboxImage(this._image);

  @override
  _CheckboxImageState createState() => _CheckboxImageState(this._image);
}

class _CheckboxImageState extends State<CheckboxImage> {
  Color _state_color = Colors.black26;
  final String _image; 
  
  _CheckboxImageState(this._image);

  @override
  Widget build(BuildContext context) {
    return GestureDetector  (
      onTap: (){
        setState(() {
          if(widget.value){
            widget.value = false;
            _state_color = Colors.black26;
          }
          else{
            widget.value = true;
            _state_color = Colors.blueAccent;
          } 
        }
      );
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color:_state_color,
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: Offset(2.0, 10.0)
          )
        ]
      ),
      child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: FadeInImage(
            placeholder: NetworkImage("https://ak7.picdn.net/shutterstock/videos/23936077/thumb/1.jpg"),
            image: AssetImage("assets/"+this._image+".png"),
            width: 85,
            height: 100,
        ),
      ),
    ),
  );
  }
}
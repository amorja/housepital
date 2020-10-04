import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  String title ;
  TextStyle textStyle ;
  ShapeBorder shape ;
  Function onpress ;
  Color color;
  double width;
  double height;

  Button({ this.height=45.0, this.width,this.color,this.title,this.onpress,this.shape,this.textStyle });
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onpress,
      shape: shape,
      color: color,
      minWidth: width,
      height: height,
      child: Text(title,style: textStyle,), );
  }
}
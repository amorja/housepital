import 'package:housepital/src/constants/colors.dart';
import 'package:housepital/src/constants/styles.dart';
import 'package:flutter/material.dart';

class LogoContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      child: Image.asset('lib/assets/logo/Logo-white.png',fit: BoxFit.cover,)
    );
  }
}

class CircleContainer extends StatelessWidget {
  double size;
  Color backcolor;
  String title;
  CircleContainer({this.size,this.title,this.backcolor});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size/2),
        color: backcolor
      ),
      child: Center(child: Text(title,style: Styles.whiteTextwithf18,)),
    );
  }
}
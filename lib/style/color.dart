import 'package:flutter/material.dart';

class CustomColor{
  static const Color primClr = Color(0xff4b4b4b);
  static const Color whiteClr = Colors.white;
  static Color opacityPrimClr = Color(0xff4b4b4b).withOpacity(0.6);
  static const Color hitTextClr = Colors.black26;
}
class CustomTextStyle{
  late final Color textClr;
  late final double textSize;
  CustomTextStyle({this.textClr:CustomColor.hitTextClr,this.textSize:13});
  txtStyle(){
   return TextStyle(color: textClr,fontSize: textSize,fontFamily: 'Cairo');
  }
}
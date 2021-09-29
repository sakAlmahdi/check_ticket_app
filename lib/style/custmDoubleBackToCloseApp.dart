import 'package:check_ticket_app/custmSnackBar.dart';
import 'package:check_ticket_app/style/color.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
Widget doubleBackToExitApp({required Widget doubleBackChild}){
  return DoubleBackToCloseApp(
      snackBar: SnackBar(
      elevation:  10,
      content: MyTextView(text: 'انقر مرة اخرى للخروج من التطبيق',textClr: CustomColor.whiteClr),
  duration: Duration(
  milliseconds: 3000,
  ),
  backgroundColor: CustomColor.opacityPrimClr,
  behavior: SnackBarBehavior.floating,
  shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(20))),
  ),
  child:doubleBackChild);
}
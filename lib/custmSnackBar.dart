import 'package:check_ticket_app/style/color.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
class CustomSnackBar{
  String snackMsg;
  CustomSnackBar({required this.snackMsg});
   getSnack(){
    return Get.showSnackbar(GetBar(
      messageText: MyTextView(
        text: snackMsg,
        textSize: 18,
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin:const EdgeInsets.symmetric(vertical: 60,horizontal: 10),
      duration: const Duration(milliseconds: 5000),
      isDismissible: true,
      snackStyle: SnackStyle.FLOATING,
      backgroundGradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          CustomColor.primClr,
          CustomColor.opacityPrimClr,
        ],
      ),
      borderRadius: 20,
      reverseAnimationCurve: Curves.easeOutBack,
      forwardAnimationCurve: Curves.easeOutBack,
      animationDuration: Duration(seconds: 2),
      dismissDirection: SnackDismissDirection.HORIZONTAL,
      snackPosition: SnackPosition.TOP,
    ));
  }
}
class ErrorSnackBar{
  String errorMsg;
  ErrorSnackBar({required this.errorMsg});
   getSnack(){
    return Get.showSnackbar(
        GetBar(
      messageText: Wrap(
        alignment: WrapAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
            alignment: Alignment.center,
            width:Get.width-20,
            decoration: BoxDecoration(
                color: Colors.red.shade700,
              borderRadius:BorderRadius.only(bottomLeft: Radius.circular(20)
            )),
            constraints: BoxConstraints(
              minHeight: 48,
              maxWidth: Get.context!.width/1.1
            ),
            child: MyTextView(
              text: errorMsg,
            ),
          ),
        ],
      ),
      padding:const EdgeInsets.symmetric(vertical: 10),
      margin:const EdgeInsets.only(top: 50),
      duration: const Duration(milliseconds: 5000,),
      isDismissible: true,
      snackStyle: SnackStyle.FLOATING,
      backgroundColor: Colors.transparent,
      reverseAnimationCurve: Curves.easeOutBack,
      forwardAnimationCurve: Curves.easeOutBack,
      animationDuration: const Duration(milliseconds: 500),
      dismissDirection: SnackDismissDirection.HORIZONTAL,
      snackPosition: SnackPosition.TOP,
    ));
  }
}


class MyTextView extends StatelessWidget {
 late final String text;
 late final Color textClr;
 late final double textSize;
 late final FontWeight textFontWeight;

 MyTextView({required this.text,this.textClr:Colors.white,this.textSize:13,this.textFontWeight:FontWeight.normal});
  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(color: textClr,fontSize: textSize,fontWeight: textFontWeight,fontFamily: 'Cairo'),textAlign: TextAlign.center);
  }
}

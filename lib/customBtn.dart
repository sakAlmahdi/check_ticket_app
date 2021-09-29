import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custmSnackBar.dart';

class CustomBtn extends StatelessWidget {
  final Function tbnFun;
  final IconData iconBtn;
  final String btnText;
  final double? widthBtn;
  const CustomBtn({required this.tbnFun,required this.iconBtn,required this.btnText, this.widthBtn});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: ()=>tbnFun(),
      child: Container(
        padding: EdgeInsets.all(5),
        height: context.isPhone?Get.height/4:Get.width/4.5,
        width: widthBtn!=null?widthBtn:context.isPhone?Get.width/2.5:Get.width/3,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white
        ),
        child: Column(
          children: [
            Expanded(child: Icon(iconBtn,size: 80)),
            SizedBox(height: 5),
            MyTextView(text:btnText,textClr: Colors.black,textSize: context.isPhone?18:22,textFontWeight:FontWeight.bold),
          ],
        ),
      ),
    );
  }
}

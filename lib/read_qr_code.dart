import 'dart:io';

import 'package:check_ticket_app/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custmSnackBar.dart';
import 'customBtn.dart';

class ReadCode extends StatelessWidget {
  final controller = Get.find<TicketController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(245, 246, 249, 0.95),
        appBar: AppBar(
          backgroundColor: Color(0xff4b4b4b),
          title:  MyTextView(text: 'قارئ التذاكر',textSize:context.isPhone?16: 20,textFontWeight: FontWeight.w700,),
           centerTitle: true,
          leading: IconButton(onPressed:()=>controller.goBack(),icon:Icon(Icons.arrow_back_outlined,color: Colors.white,size: 30,),),
          actions: [IconButton(onPressed:()=>exit(0),icon:Icon(Icons.exit_to_app,color: Colors.white,size: 30,),),],
        ),
        body:WillPopScope(
          onWillPop: (){
            return Get.find<TicketController>().goBack();
          },
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomBtn(btnText:'التحقق من التذكرة',
                    iconBtn: Icons.qr_code_2,
                    tbnFun :()=>controller.scanBarcode()),
                CustomBtn(btnText:'مزامنة لتذاكر مع السيرفر',
                    iconBtn: Icons.autorenew_outlined,
                    tbnFun :()=>controller.addOfLineTicketToApi()),
              ],
            ),
          ),
        )
    );
  }
}
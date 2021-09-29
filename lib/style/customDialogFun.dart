import 'package:check_ticket_app/style/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../custmSnackBar.dart';

class CustomDialog {
  String title;
  IconData icon;
  Color iconClr;
  String firstBtnTxt;
  String secondBtnTxt;

  CustomDialog(
      {required this.title,
      this.icon:Icons.wifi_off,
      this.iconClr:CustomColor.primClr,
      this.firstBtnTxt:"موافق",
      this.secondBtnTxt:'الغاء'});

  MaterialButton _customBtn({Function? myFun,String? btnTxt,Color? btnClr}){
    return MaterialButton(
      padding: EdgeInsets.symmetric(horizontal: 5),
      onPressed: (){
        Get.back();
        if (myFun != null) myFun();
    }, shape:const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
    ),color: btnClr??CustomColor.primClr,
      child: MyTextView(
      text:  btnTxt??this.firstBtnTxt,
      textClr: btnClr==null?Colors.white:CustomColor.primClr,
      textSize: 11,
    ),);
  }
  Scaffold _design({required Widget btnDesign,required BoxConstraints constraints}) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
              ),
              width: constraints.maxWidth -125,
              child: Wrap(
                spacing: 15,
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.vertical,
                children: [
                  Icon(this.icon,size: 40,color: this.iconClr),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    width: constraints.maxWidth - 130,
                    constraints: BoxConstraints(
                      maxHeight: constraints.maxHeight / 2,
                    ),
                    child: MyTextView(
                      text: this.title,
                      textClr: Colors.black,
                      textSize: 12,
                    ),
                  ),
                  btnDesign,
                ],
              ),
            ),
          ),
    );
  }


  getBtn({required Function() firstFun, Function()? secondFun}) {
    return Get.dialog(LayoutBuilder(
        builder: (context, screenSize) {
      return _design(constraints: screenSize,btnDesign: Container(
          width: screenSize.maxWidth-145,
          child: Row(
            children: [
              Expanded(
                child: _customBtn(myFun:()=>firstFun()),
              ),
              SizedBox(width:10),
              Expanded(
                child: _customBtn(btnTxt:this.secondBtnTxt,btnClr: Colors.white),
              ),
            ],
          ),
        ));}),
        transitionCurve: Curves.easeInOutCubic,
        useSafeArea: true,
        barrierColor: Colors.black26,
        transitionDuration: Duration(milliseconds:800)
    );
  }
  getOneBtn({required Function() firstFun}) {
    return Get.dialog(LayoutBuilder(
        builder: (context, screenSize) {
      return _design(constraints: screenSize,btnDesign: Container(
          width: screenSize.maxWidth-145,
          child:Row(
            children: [
              Expanded(
                child: _customBtn(myFun:()=>firstFun(),
              )
              ),
            ],
          )));}),
        transitionCurve: Curves.easeInOutCubic,
        useSafeArea: true,
        barrierColor: Colors.black26,
        transitionDuration: Duration(milliseconds:800)
    );
  }
}

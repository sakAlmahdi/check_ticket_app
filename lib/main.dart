import 'dart:ui';
import 'package:check_ticket_app/startScreen.dart';
import 'package:check_ticket_app/style/checkInterNet.dart';
import 'package:check_ticket_app/style/color.dart';
import 'package:check_ticket_app/style/customCircularProgress.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'controller.dart';
import 'custmSnackBar.dart';

void main() async {
  // await Get.putAsync<CheckInterNet>(() async => await CheckInterNet());
  Get.lazyPut( () => CheckInterNet( ) );
  Get.lazyPut( () => TicketController( ) );
  runApp(
      GetMaterialApp(
        title: 'قارئ التذاكر',
        debugShowCheckedModeBanner: false,
        locale: Locale( "ar" ),
        fallbackLocale: Locale( 'ar' ),
        theme: ThemeData(
          primaryColor: CustomColor.primClr,
        ),
        home: StartScreen( ),
      ) );
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp] );
}


class StartScreen extends StatelessWidget {
  final controller = Get.find<TicketController>();
  @override
  Widget build(BuildContext context) {
    Get.find<CheckInterNet>().connectionInterNet.value;

    return Scaffold(
        backgroundColor: Color.fromRGBO(245, 246, 249, 0.95),
        appBar: AppBar(
          backgroundColor: Color(0xff4b4b4b),
          title: MyTextView(text: 'قارئ التذاكر',textSize:context.isPhone?16: 20,textFontWeight: FontWeight.w700,),
          centerTitle: true,),
      body: Stack(
        // mainAxisAlignment: MainAxisAlignment.end,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric( vertical: 60 ),
          child: MaterialButton(
          minWidth: Get.width/1.5,
            onPressed: () {
              controller.isLoading
                  .value = true;
              controller.getToken();
            },
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all( Radius.circular( 15 ) ),
            ),
            color: CustomColor.primClr,
            child: MyTextView(
              text: 'بداء التشغيل',
              textClr: Colors.white,
              textSize: 12,
            ), ),
        ),
      ),
    GetBuilder(
      init:controller ,
        builder: (context)=>controller.isLoading.value?Container(
    width:Get.width,
    height: Get.height,
    color: Colors.black12,
    child: Center(child: CenterProgress()),
    ):SizedBox())
    ])
    );
  }
}






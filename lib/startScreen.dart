import 'package:check_ticket_app/style/custmDoubleBackToCloseApp.dart';
import 'package:check_ticket_app/style/customCircularProgress.dart';
import 'package:check_ticket_app/style/postServies.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';
import 'custmSnackBar.dart';
import 'customBtn.dart';

class HomePage extends StatelessWidget {
  final controller = Get.find<TicketController>();
  @override
  Widget build(BuildContext context) {
    controller.onReady();
    return Scaffold(
        backgroundColor: Color.fromRGBO(245, 246, 249, 0.95),
        appBar: AppBar(
          backgroundColor: Color(0xff4b4b4b),
          title: MyTextView(text: 'قارئ التذاكر',textSize:context.isPhone?16: 20,textFontWeight: FontWeight.w700,),
          centerTitle: true,),
        body:doubleBackToExitApp(
          doubleBackChild: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // CustomBtn(btnText:'اضافة ملف الى السيرفر',
                    //     widthBtn: Get.width/1.21,
                    //     iconBtn: Icons.note_add_outlined,
                    //     tbnFun:()=>controller.getFileXlsx()),
                    // SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomBtn(btnText:'جلب بيانات التذاكر',
                            iconBtn: Icons.download_sharp,
                            tbnFun:()=>controller.getAllTicketFromApi() ),
                        CustomBtn(btnText:'قارئ التذاكر',
                            iconBtn: Icons.qr_code_2,
                            tbnFun :()=>controller.goToQrScreen()),
                      ],
                    ),
                    SizedBox(height: 20),
                    CustomBtn(btnText:'احصائية عدد التذاكر',
                        widthBtn: Get.width/1.21,
                        iconBtn: Icons.assessment_outlined,
                        tbnFun:(){
                          controller.getTicketCountApi();
                        }),
                  ],
                ),
              ),
              Obx(()=>controller.isLoading.value?Container(
                width:Get.width,
                height: Get.height,
                color: Colors.black12,
                child: Center(child: CenterProgress()),
              ):SizedBox())
            ],
          ),
        )
    );
  }
}


import 'package:check_ticket_app/style/color.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CenterProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: Get.width,
      height:Get.height,
      color: Colors.black12,
      child: SizedBox(width: 100,height: 100,child: LoadingIndicator(indicatorType: Indicator.ballGridPulse ,colors: [CustomColor.primClr,CustomColor.opacityPrimClr])),
    );
  }
}
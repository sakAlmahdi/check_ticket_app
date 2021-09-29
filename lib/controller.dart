import 'package:check_ticket_app/read_qr_code.dart';
import 'package:check_ticket_app/startScreen.dart';
import 'package:check_ticket_app/style/checkInterNet.dart';
import 'package:check_ticket_app/style/customDialogFun.dart';
import 'package:check_ticket_app/style/postServies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'custmSnackBar.dart';
import 'fSqlite.dart';
import 'fetchXmlFile.dart';
import 'globaData/globalText.dart';
import 'model.dart';
import 'model/getAllTicket.dart';
import 'model/sendTicket.dart';

class TicketController extends GetxController{
  late GetStorage _storge;
 late List<String> unUsedTicket;
 late List<String> ofLineList;
 late RxBool isLoading,isOfLine;

 static const String TicketUsed = 'TicketUsed';
 static const String TicketUnUsed = 'TicketUnUsed';
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isLoading=false.obs;
    isOfLine=false.obs;
      _storge = GetStorage();
    unUsedTicket=List<String>.empty(growable: true).obs;
    ofLineList=List<String>.empty(growable: true).obs;

  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getAllData();
    Get.find<CheckInterNet>().connectionInterNet.value;
  }
gotToHome(){

}
  getToken(){
    isLoading
        .value = true;
    ApiService( url: '' ).getToken(
        onSuccess: (onSuccess) {
          isLoading.value = false;
          Get.off(()=>HomePage());
        }, onError: (onError) {
      isLoading
          .value = false;
    }, onRunTime: () {
      getToken();
    }, noInterNet: () {
      ErrorSnackBar( errorMsg: 'يرجاء الاتصال بالانترنت اولاً' )
          .getSnack( );
     isLoading
          .value = false;
    } );
  }

  getFileXlsx()async{
    await  PickXmlFile().getPDF(
        onSuccess: (ticketsFile){
          if(Get.find<CheckInterNet>().connectionInterNet.value != 0) {
            ApiService(url: 'Tkt_Ticket/UploadData',dataSend: SendTicket(qrCode: unUsedTicket,isUsed: false).toJson()).postData(
                onSuccess: (value) {
                  unUsedTicket.clear();
                  unUsedTicket.addAll(ticketsFile);
                  _storge.write(GlobalData.unUsedTicket,ticketsFile);
                  isLoading.value = false;
                  CustomSnackBar( snackMsg: value!=null?'$value':"تمت اضافة الملف بنجاح" ).getSnack( );
                }, onError: (errorValue) {
              isLoading.value = false;
              ErrorSnackBar(errorMsg: errorValue!=null?"$errorValue":"تعذر اضافة الملف").getSnack();
            }, onRunTime: () {
              isLoading.value = false;
              ErrorSnackBar( errorMsg: 'يبدو ان الاتصال بالشبكة بطيئ جداَ اوان السرفر لا يستجيب يرجاء المحاولة مرة اخرى').getSnack();
            });
          } else ErrorSnackBar(errorMsg: 'يرجاء الاتصال بالانترنت اولاً').getSnack();

        });
  }

  getTicketCountApi(){
    if(Get.find<CheckInterNet>().connectionInterNet.value != 0) {
      isLoading.value = true;
      ApiService(url: 'Tkt_Ticket/GetTicketCounter').getData(
          onSuccess: (value) {
            isLoading.value = false;
            CustomDialog(icon: Icons.topic_outlined,title: 'عدد التذاكر المقروئة: ${value['usedConter']}\n\n عدد التذاكر الغير مقروئة: ${value['totalCounter']-value['usedConter']}\n\n اجمالي عدد التذاكر هو: ${value['totalCounter']}').getOneBtn(firstFun: () {});
          }, onError: (errorValue) {
        isLoading.value = false;
        ErrorSnackBar(errorMsg: errorValue.toString()).getSnack();
      }, onRunTime: () {
        isLoading.value = false;
        ErrorSnackBar(
            errorMsg:
            'يبدو ان الاتصال بشبطة بطيئ جداَ اوان السرفر لا يستجيب يرجاء المحاولة مرة اخرى')
            .getSnack();
      });
    } else ErrorSnackBar(errorMsg: 'يرجاء الاتصال بالانترنت اولاً').getSnack();
  }

  getAllTicketFromApi(){
    if(Get.find<CheckInterNet>().connectionInterNet.value != 0) {
      isLoading.value = true;
      ApiService(url: 'Tkt_Ticket/GetTickets').getData(
          onSuccess: (value){
            unUsedTicket.clear();
            var data = value as List;
            if(data.isNotEmpty) {
              List<GetAllTicket> ticketList = data.map((element) => GetAllTicket.fromJson(element)).toList();
              ticketList.forEach((element) {
                if(!element.isUsed)
                  unUsedTicket.add(element.qrCode);
              });
              _storge.write(GlobalData.unUsedTicket,unUsedTicket);
              CustomSnackBar( snackMsg: "تم جلب البيانات" ).getSnack( );
            }else{
              ErrorSnackBar(errorMsg: 'لا يوجد بيانات لجلبها').getSnack();
            }
            isLoading.value = false;

          }, onError: (errorValue) {
        isLoading.value = false;
        ErrorSnackBar(errorMsg: errorValue.toString()).getSnack();
      }, onRunTime: () {
        isLoading.value = false;
        ErrorSnackBar(
            errorMsg:
            'يبدو ان الاتصال بشبطة بطيئ جداَ اوان السرفر لا يستجيب يرجاء المحاولة مرة اخرى')
            .getSnack();
      });
    } else ErrorSnackBar(errorMsg: 'يرجاء الاتصال بالانترنت اولاً').getSnack();
  }

  goToQrScreen(){
    getAllData();
    if(Get.find<CheckInterNet>().connectionInterNet.value != 0){
      getAllData();
      isOfLine.value=false;
      Get.to(()=>ReadCode());
    }
    else {
      CustomDialog(title: "لايوجد اتصال بالانترنت هل تريد الفحص بدون استخدام السرفر").getBtn(firstFun: (){
        getAllData();
        isOfLine.value=true;
        Get.to(()=>ReadCode());
      });
    }
  }


  searchModel(String ticketCode)async{
    isLoading.value=true;
    if(ticketCode.isEmpty||ticketCode=='-1') ErrorSnackBar(errorMsg: " تعذر قرائة البركود يرجاء المحاولة مرة اخرى").getSnack();
    else if(unUsedTicket.any((element) => element.trim()==ticketCode.trim())) {
      unUsedTicket.remove(ticketCode);
      ofLineList.add(ticketCode);
      await _storge.write(GlobalData.unUsedTicket,unUsedTicket);
      await _storge.write(GlobalData.usedTicket,ofLineList);
      isLoading.value = false;
      CustomSnackBar( snackMsg: "تم التحقق من بيانات التذكرة بنجاح" ).getSnack( );
    }else{
      isLoading.value=false;
      ErrorSnackBar(errorMsg: "قدتكون هذة التذكرة مستخدمة او غير صحيحة").getSnack();
    }
  }

  scanBarcode(){
    if(Get.find<CheckInterNet>().connectionInterNet.value != 0){
      _scanBarcodeNormal();
    }else{
      if(isOfLine.value){
      _scanBarcodeNormalWithNoNet();
    }else{
        CustomDialog(title: "لايوجد اتصال بالانترنت هل تريد الفحص بدون استخدام السرفر").getBtn(firstFun: (){
          isOfLine.value=true;
          _scanBarcodeNormalWithNoNet();
        });
      }}
}

  Future<void> _scanBarcodeNormal() async {
  if(unUsedTicket.length==0){
      CustomDialog(title: "يجب جلب البيانات من السرفر اولاً",firstBtnTxt: "جلب البيانات").getBtn(firstFun: ()=>getAllTicketFromApi());
    }
    else{
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#4b4b4b', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = '-1';
    }
        searchFromApi(barcodeScanRes);
  }}

  Future<void> _scanBarcodeNormalWithNoNet() async {
  if(unUsedTicket.length==0){
      CustomDialog(title: "يجب جلب البيانات من السرفر اولاً",firstBtnTxt: "جلب البيانات").getBtn(firstFun: ()=>getAllTicketFromApi());
    }
    else{
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#4b4b4b', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = '-1';
    }
      searchModel(barcodeScanRes);
  }}

  searchFromApi(String code){
    if(code.isEmpty||code=='-1'){ ErrorSnackBar(errorMsg: " تعذر قرائة البركود يرجاء المحاولة مرة اخرى").getSnack();
    }else {
      isLoading.value=true;
      ApiService(url: 'Tkt_Ticket/Validate?QRCode=$code', dataSend: {"": ""})
          .postData(onSuccess: (value)async {
        unUsedTicket.remove(code);
        await _storge.write(GlobalData.unUsedTicket,unUsedTicket);
        isLoading.value=false;
        CustomSnackBar(snackMsg: value != null ? '$value' : "هذة التذكرة صحيحة")
            .getSnack();
      }, onError: (errorValue) {
        isLoading.value=false;
        ErrorSnackBar(errorMsg: errorValue.toString()).getSnack();
      }, onRunTime: () {
        isLoading.value=false;
        ErrorSnackBar(
                errorMsg:
                    'يبدو ان الاتصال بشبطة بطيئ جداَ اوان السرفر لا يستجيب يرجاء المحاولة مرة اخرى')
            .getSnack();
      });
    }
  }

  addOfLineTicketToApi()async{
    if(Get.find<CheckInterNet>().connectionInterNet.value != 0) {
      isLoading.value = true;
      await getAllData();
      if(ofLineList.length!=0) {
        ApiService(
                url: 'Tkt_Ticket/UploadData',
                dataSend: SendTicket(qrCode: ofLineList, isUsed: true).toJson())
            .postData(onSuccess: (value)async {
          await _storge.write(GlobalData.usedTicket,[]);
          isLoading.value = false;
          CustomSnackBar( snackMsg: value.toString() ).getSnack( );
        }, onError: (errorValue) {
          isLoading.value = false;
          ErrorSnackBar(errorMsg: errorValue.toString()).getSnack();
        }, onRunTime: () {
          isLoading.value = false;
          ErrorSnackBar(
                  errorMsg:
                      'يبدو ان الاتصال بشبطة بطيئ جداَ اوان السرفر لا يستجيب يرجاء المحاولة مرة اخرى')
              .getSnack();
        });
      }else{
        ErrorSnackBar(errorMsg: 'لا يوجد بيانات لمزامنتها مع السرفر').getSnack();
      }
    } else ErrorSnackBar(errorMsg: 'يرجاء الاتصال بالانترنت اولاً').getSnack();
  }


  getAllData(){
    GetStorage readStorage=GetStorage();
    isLoading.value=true;
    List unUsedLst=readStorage.read(GlobalData.unUsedTicket)??[];
    List usedLst =readStorage.read(GlobalData.usedTicket)??[];
    if(unUsedLst.isNotEmpty||usedLst.isNotEmpty){
      ofLineList=usedLst.map((elementCode) => elementCode.toString()).toList();
      unUsedTicket=unUsedLst.map((elementState) => elementState.toString()).toList();
      isLoading.value=false;
    }else isLoading.value=false;
    print(unUsedLst.length);
    print(usedLst.length);
  }

  goBack(){
    isLoading.value=false;
    Get.back();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    isLoading.value=false;
  }
}
// try{
//   _db.getAllTicket().then((tickets) {
//     isLoading.value=false;
//     ticketNum.value = tickets.length;
//     ticketLst=tickets;
//     ticketUNUse.value=0;
//     ticketUsed.value=0;
//     tickets.forEach((element) {
//       if(element.ticketState=='0'){
//         ticketUNUse.value++;
//       }else if(element.ticketState=='1'){
//         ticketUsed.value++;
//       }
//     });
//   });
// }catch(e){
//   isLoading.value=false;
// }

// search(String ticketCode )async{
//   isLoading.value=true;
//   if(ticketLst.any((element) => element.ticketBarcode.trim()==ticketCode.trim())){
//   ticketLst.forEach((value) async{
//     if(value.ticketBarcode.trim()==ticketCode.trim()){
//     if(value.ticketState=="0") {
//       await _db.updateTicket(Ticket(id: value.id,ticketBarcode: value.ticketBarcode,ticketState: "1")).then((value) {
//         isLoading.value=false;
//         ticketUsed.value++;
//         ticketUNUse.value--;
//         CustomSnackBar(snackMsg: "هذة التذكرة صحيحة").getSnack();
//       });
//     }
//     else{
//       isLoading.value=false;
//       ErrorSnackBar(errorMsg: "هذة التذكرة مستخدمة").getSnack();
//     }}
//   });}else{
//     isLoading.value=false;
//
//     ErrorSnackBar(errorMsg: "هذة التذكرة غير صحيحة").getSnack();
//   }
//  // await _db.getTicket(ticketCode.toString().trim()).then((value) async{
//  //    if(value!=null){
//  //      if(value.ticketState=="0") {
//  //     await _db.updateTicket(Ticket(id: value.id,ticketBarcode: value.ticketBarcode,ticketState: "1")).then((value) {
//  //        isLoading.value=false;
//  //        ticketUsed.value++;
//  //        ticketUNUse.value--;
//  //        CustomSnackBar(snackMsg: "هذة التذكرة صحيحة").getSnack();
//  //      });
//  //      }
//  //      else{
//  //        isLoading.value=false;
//  //        ErrorSnackBar(errorMsg: "هذة التذكرة مستخدمة").getSnack();
//  //      }
//  //    }
//  //    else{
//  //      isLoading.value=false;
//  //
//  //    }
//  //    isLoading.value=true;
//  //  });
// }

// await _db.getTicket(ticketCode.toString().trim()).then((value) async{
//    if(value!=null){
//      if(value.ticketState=="0") {
//     await _db.updateTicket(Ticket(id: value.id,ticketBarcode: value.ticketBarcode,ticketState: "1")).then((value) {
//        isLoading.value=false;
//        ticketUsed.value++;
//        ticketUNUse.value--;
//        CustomSnackBar(snackMsg: "هذة التذكرة صحيحة").getSnack();
//      });
//      }
//      else{
//        isLoading.value=false;
//        ErrorSnackBar(errorMsg: "هذة التذكرة مستخدمة").getSnack();
//      }
//    }
//    else{
//      isLoading.value=false;
//
//    }
//    isLoading.value=true;
//  });


// deleteAllData()async{
//  await _db.getAllTicket().then((tickets){
//     tickets.forEach((element) async{
//      await _db.deleteTicket(element.id);
//     });
//   });
// }


// searchForTicket(String ticketCode){
//   var selectData = ticketLst.where((element) => element.ticketBarcode==ticketCode);
// print("\n1\n2\n3\n4\n5"+selectData.toString());
//   }
// deleteByID(int id){
//   _db.deleteTicket(id);
// }


// getFile(){
//   PickXmlFile().fetchFile(
//       onSuccess: (ticketsFile){
//         if(ticketLst.isNotEmpty){
//           ticketsFile.forEach((element) {
//             if(ticketLst.every((searchElement) => searchElement.ticketBarcode.trim()!=element.ticketBarcode.trim())){
//               _db.addTicket(element);
//             }
//           });
//         }else{
//           ticketsFile.forEach((element) {
//             _db.addTicket(element);
//           });
//         }
//         getAllData();
//       },
//       onError:(errorValue){
//         print("\n\n\n"+errorValue);
//       });
// }


// M5297769227281780136, M5297631358711179868, M5297319446558799732
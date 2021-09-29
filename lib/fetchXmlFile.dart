import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
// import 'package:xml/xml.dart';
import 'controller.dart';
import 'custmSnackBar.dart';
import 'model.dart';

class PickXmlFile {
  List<Ticket> _ticketLst = [];
  // fetchFile({required Function(List<Ticket> tickets) onSuccess,required Function(String error) onError})async{
  //    try {
  //      FilePickerResult? pickPdf = await FilePicker.platform.pickFiles(
  //        type: FileType.custom,
  //        allowedExtensions: ['xml'],);
  //      if (pickPdf != null) {
  //        String xmlData = File(pickPdf.files.first.path!).readAsStringSync();
  //        var ticketXml = XmlDocument.parse(xmlData);
  //        var tickets = ticketXml.findAllElements("id");
  //        tickets.map((element) {_ticketLst.add(Ticket(ticketBarcode: element.findElements("tacketBarcode").first.text, ticketState: int.parse(element.findElements("tacketisUsed").first.text).toString()));}).toList();
  //        if(tickets.isNotEmpty)
  //        onSuccess(_ticketLst);
  //        else onError("لايمكن اضافة ملف من هذا النوع لانهو لا يحتي على الحقول المطلوبة");
  //      } else {
  //        print("No Pdf select");
  //        onError("عذراً لم يتم جلب اي ملف");
  //      }
  //    }catch (error){
  //      onError("تعذر جلب ملف");
  //    }
  // }

  getPDF({required Function(List<String> tickets) onSuccess}) async {
    try {
      FilePickerResult? pickPdf = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv'],
      );
      if (pickPdf != null) {
        Get.find<TicketController>().isLoading(true);
        try {
          final input = new File(pickPdf.files.first.path!).openRead();
          final fields = await input
              .transform(utf8.decoder)
              .transform(new CsvToListConverter())
              .toList();

          onSuccess(fields.map((element) => element[1].toString()).toList());
        } catch (e) {
          Get.find<TicketController>().isLoading(false);
          ErrorSnackBar(errorMsg: "خطاء الملف المرفوع غير مقبول").getSnack();
        }
      } else {
        ErrorSnackBar(errorMsg: "خطاء لم يتم رفع الملف يرجاء المحاولة مرة اخرى")
            .getSnack();
      }
    } catch (e) {
      print(e.toString());
      ErrorSnackBar(errorMsg: "خطاء لم يتم رفع اي ملف يرجاء المحاولة مرة اخرى")
          .getSnack();
    }
  }
}

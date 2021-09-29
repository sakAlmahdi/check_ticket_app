// import 'dart:convert';
// import 'dart:io';
// import 'package:footballs_app/Models/globals.dart';
// import 'package:footballs_app/getX/getDialogMsg.dart';
//
// import '../extraFile/filePath.dart';
// import 'package:http/http.dart' as http;
//
// class PostService extends GetConnect {
//
//   Future postData({String url,var data}) async {
//     print("body data for send $data");
//     print("Url domain name ${GlobalsText.appDomainName}"+"$url");
//
//       var response = await http.post(Uri.parse("${GlobalsText.appDomainName}"+"$url"),body: data,
//         headers:{"Content-Type": "application/x-www-form-urlencoded",
//         "Authorization":"Bearer " + "${GlobalsText.token}",
//         "Accept-Language":Get.find<GtxFun>().myLanguageSelect.value== 'عربي'?"ar-sa":"en-us"}
//         ).timeout(Duration(seconds: 15),onTimeout: ()=>null);
//       print("\nresponse.statusCode ${response.statusCode}");
//       print("\nresponse.body ${response.body}\n");
//     try{
//       return {"statusCode":response.statusCode,"value":response.body};
//     }catch (exception){
//       print("$exception");
//       GetDialogMsg().cancelDialog(cancelTitle: 'Error number ${response.statusCode}',cancelMsgTxt: "${response.body}");
//       return  {"statusCode":response.statusCode,"value":response.body};
//     }
//   }
//
//   Future getData({String url ,int isWthNoDecode})async{
//     print("Url domain name ${GlobalsText.appDomainName}"+"$url");
//      var response = await http.get(Uri.parse("${GlobalsText.appDomainName}"+"$url"),
//        headers:{
//        "Content-Type": "application/x-www-form-urlencoded",
//          HttpHeaders.authorizationHeader:"Bearer "  + "${GlobalsText.token}",
//          "Accept-Language":Get.find<GtxFun>().myLanguageSelect.value== 'عربي'?"ar-sa":"en-us"
//          }
//      ).timeout(Duration(seconds: 30),onTimeout: ()=>null);
//     try{
//      print("${jsonDecode(response.body)}");
//      Map responseData = {"statusCode":response.statusCode,"value":isWthNoDecode==1?response.body:jsonDecode(response.body)};
//        return responseData;
//     }catch (exception){
//       print("$exception");
//       print("statusCode:${response.statusCode??1} \n value:${response.body}");
//       return  {"statusCode":response.statusCode??1,"value":response.body};
//     }
//   }
//
//   Future getToken({Map data}) async {
//     print("body data for send $data");
//
//       var response = await http.post(Uri.parse(GlobalsText.tokenUrl),body: data,
//           headers:{"Content-Type": "application/x-www-form-urlencoded",
//             "Authorization":"Bearer " +"${GlobalsText.token}",
//             "Accept-Language":Get.find<GtxFun>().myLanguageSelect.value== 'عربي'?"ar-sa":"en-us"}
//       ).timeout(Duration(seconds: 15),onTimeout: ()=>null);
//     try{
//       print("\nresponse.statusCode ${response.statusCode}");
//       print("\nresponse.body ${response.body}\n");
//       return {"statusCode":response.statusCode,"value":response.body};
//     }catch (exception){
//       print("$exception");
//       GetDialogMsg().cancelDialog(cancelTitle: 'Error number ${response.statusCode}',cancelMsgTxt: "${response.body}");
//       return  {"statusCode":response.statusCode,"value":response.body};
//     }
//   }
// }
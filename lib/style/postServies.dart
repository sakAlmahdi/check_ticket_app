
import 'package:check_ticket_app/globaData/globalText.dart';
import 'package:check_ticket_app/style/checkInterNet.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get_connect/connect.dart';
import '../custmSnackBar.dart';

class ApiService extends GetConnect {
  String url;
  var dataSend;
static const _map={};
  ApiService({required this.url, this.dataSend:_map});

  Dio _dio = Dio();

  Duration _runTime = const Duration(seconds: 300);

  getData({required Function(dynamic data) onSuccess, required Function(dynamic error) onError, required Function() onRunTime, Function()? noInterNet}) async {
    print("Url domain name ${GlobalData.domainApiName}" + "$url");
    print("GlobalData.token ${GlobalData.token}");
    if (Get.find<CheckInterNet>().connectionInterNet.value != 0&&GlobalData.token.isNotEmpty) {
      try {
        var response = await _dio.get("${GlobalData.domainApiName}" + "$url",
            options:  Options(headers: {
              "Content-Type": "application/x-www-form-urlencoded",
              "Accept": "text/plains",
              "Accept-Language": "ar-YE",
              "Authorization": "Bearer " + "${GlobalData.token}"})).timeout(_runTime);
        print("response $response");
        // ignore: unnecessary_null_comparison
        if (response != null) {
          onSuccess(response.data);
        } else {
          onRunTime();
        }
      } on DioError catch (error) {
        if(error.response!=null){
        print("error.response.statusCode ${error.response!.statusCode}");
        print("error.response.data ${error.response!.data}");
        if (error.response!.data.toString() == "{message: The requested resource does not support http method 'GET'.}") {
          GlobalData.token='';
          postData(onSuccess: onSuccess, onError: onError, onRunTime: onRunTime,noInterNet: noInterNet);
          // getToken(onSuccess: (data) {getData(onSuccess: onSuccess, onError: onError, onRunTime: onRunTime,noInterNet: noInterNet);}, onError: (error) => onError(error), onRunTime:onRunTime, noInterNet: noInterNet);
        }
        else {onError(error.response);}
        }
        else {onError("error");}
      }
    } else if(GlobalData.token.isEmpty){
      getToken(onSuccess: (data) {getData(onSuccess: onSuccess, onError: onError, onRunTime: onRunTime,noInterNet: noInterNet);}, onError: (error) => onError(error), onRunTime:onRunTime, noInterNet: noInterNet);
  }else {
      if (noInterNet != null) noInterNet();
    }
  }

  postData({required Function(dynamic data) onSuccess,required Function(dynamic error) onError,required Function() onRunTime, Function()? noInterNet}) async {
    print("body data for send $dataSend");
    print("Url domain name ${GlobalData.domainApiName}" + "$url");
    print("GlobalData.token ${GlobalData.token}");
    if (Get.find<CheckInterNet>().connectionInterNet.value != 0&&GlobalData.token.isNotEmpty) {
      try {
        var response = await _dio.post(
            "${GlobalData.domainApiName}" + "${this.url}",
            data: dataSend,
            options: Options(headers: {
              "Content-Type": "application/x-www-form-urlencoded",
              "Accept-Language": "ar-YE",
              "Authorization": "Bearer " + "${GlobalData.token}"})
        ).timeout(_runTime);
        print("\n\n\n\nresponse $response");
        // ignore: unnecessary_null_comparison
        if (response != null) {
          onSuccess(response.data);
        } else {
          onRunTime();
        }
      } on DioError catch (error) {
        print("\n\n\n\nerror.response.statusCode ${error.toString()}");
        if(error.response!=null){
          print("\n\n\n\nerror.response.statusCode ${error.response!.statusCode}");
          print("\n\n\n\nerror.response.data ${error.response!.data}");
        if (error.response!.data.toString() == "{message: The requested resource does not support http method 'GET'.}") {
          GlobalData.token='';
          postData(onSuccess: onSuccess, onError: onError, onRunTime: onRunTime,noInterNet: noInterNet);
          // getToken(
          //     onSuccess: (data) {postData(onSuccess: onSuccess, onError: onError, onRunTime: onRunTime,noInterNet: noInterNet);},
          //     onError: (error) => onError(error),
          //     onRunTime:onRunTime,
          //     noInterNet: noInterNet);
        }
        else {onError(error.response!.data);}
        }else {
      onError("error");
    }}
    } else if(GlobalData.token.isEmpty){
      getToken(onSuccess: (data) {getData(onSuccess: onSuccess, onError: onError, onRunTime: onRunTime,noInterNet: noInterNet);}, onError: (error) => onError(error), onRunTime:onRunTime, noInterNet: noInterNet);
    } else {
      if (noInterNet != null) noInterNet();
    }
  }

  getToken({required Function(dynamic data) onSuccess, required Function(dynamic error) onError,required Function() onRunTime, Function()? noInterNet}) async {
    print("Url domain name ${GlobalData.domainApiName}" + "$url");

    if (Get.find<CheckInterNet>().connectionInterNet.value != 0) {
      try {
        var response = await _dio.post(
            'https://shop.api.nfl-sa.org/api/Account/Login', data: {
          'username': '0549000191',
          'password': '0549000191',
          'grant_type': 'password'
        }, options:  Options(headers: {
          'Content-Type': 'application/x-www-form-urlencoded'

        })).timeout(
            _runTime);
        print("response $response");
        // ignore: unnecessary_null_comparison
        if (response != null) {
        GlobalData.token = response.data["access_token"].toString();
          onSuccess(response.data);
        } else {
          onRunTime();
        }
      } on DioError catch (error) {
        // print("error.response.statusCode ${error.response.statusCode}");
        print("error.response.data ${error.response}");
        ErrorSnackBar(errorMsg: error.response.toString()).getSnack();
        onError(error.response);
      }
    } else {
      if (noInterNet != null) noInterNet();
    }
  }

  Future apiLoginCustomer() async {

    dio.Response response=  await dio.Dio( ).post( 'https://shop.api.nfl-sa.org/api/Account/Login', data: {
      "username": '0569646910',
      "password": '0569646910',
      "grant_type": 'password',
      // 0549000191
    }, options: dio.Options( headers: {
      dio.Headers.contentTypeHeader: dio.Headers.formUrlEncodedContentType
    } ) );
    if (response.statusCode == 200) {
      ErrorSnackBar(errorMsg: response.toString()).getSnack();
      }else{
      ErrorSnackBar(errorMsg: response.toString()).getSnack();

      }
  }
}

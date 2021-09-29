import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CheckInterNet extends GetxService{
  var connectionInterNet = 0.obs;
  final Connectivity _connectivity = Connectivity();
   var checkConnect = Connectivity().checkConnectivity();
  late StreamSubscription<ConnectivityResult>_connectivitySubscription;

  @override
  void onInit()async {
    // TODO: implement onInit
    super.onInit();
    initConnectivity();
    _connectivitySubscription=_connectivity.onConnectivityChanged.listen(_updateConnectivityStatus);
  }

  Future<void>initConnectivity()async{
    ConnectivityResult ? connectivityResult;
    try{
       connectivityResult = await _connectivity.checkConnectivity();
    } on PlatformException catch (e){
      print(e.toString());
    }
    return _updateConnectivityStatus(connectivityResult!);
  }
  _updateConnectivityStatus(ConnectivityResult result){
    switch(result){
      case ConnectivityResult.none:connectionInterNet.value=0;break;
      case ConnectivityResult.wifi:connectionInterNet.value=1;break;
      case ConnectivityResult.mobile:connectionInterNet.value=2;break;
      default:connectionInterNet.value=3;break;

    }
  }


  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    _connectivitySubscription.cancel();
  }


}
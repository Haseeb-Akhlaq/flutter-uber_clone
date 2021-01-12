import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';

class MyConnectivity {
  //Map _source = {ConnectivityResult.none: false};
  MyConnectivity._internal();

  static final MyConnectivity _instance = MyConnectivity._internal();

  static MyConnectivity get instance => _instance;

  Connectivity connectivity = Connectivity();

  StreamController controller = StreamController.broadcast();

  Stream get myStream => controller.stream;

  void initialise() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    _checkStatus(result);
    connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isOnline = true;
      } else
        isOnline = false;
    } on SocketException catch (_) {
      isOnline = false;
    }
    if (!controller.isClosed) {
      controller.sink.add({result: isOnline});
    }
  }

  // bool checkConnection() {
  //   switch (_source.keys.toList()[0]) {
  //     case ConnectivityResult.none:
  //       return false;
  //       break;
  //     case ConnectivityResult.mobile:
  //      return true;
  //       break;
  //     case ConnectivityResult.wifi:
  //       return true;
  //   }
  //   return false;
  // }

  void disposeStream() => controller.close();
}

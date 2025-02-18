import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityProvider extends ChangeNotifier {
  bool isConnected = true;
  late StreamSubscription subscription;

  void initialise(context) async {
    Connectivity connectivity = Connectivity();

    List<ConnectivityResult> result = await connectivity.checkConnectivity();
    checkStatus(result, context);
    subscription = connectivity.onConnectivityChanged.listen((result) {
      checkStatus(result, context);
    });
  }

  void checkStatus(List<ConnectivityResult> result, context) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isEmpty && result[0].rawAddress.isEmpty) {
        isConnected = false;
        notifyListeners();
      } else {
        isConnected = true;
        notifyListeners();
      }
    } on SocketException catch (_) {
      isConnected = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }
}

import 'dart:async';
import 'package:flutter/material.dart';

class CustomTimer{
  late int? milliseconds;
  late VoidCallback action;
  late Timer _timer;


  CustomTimer({this.milliseconds});

  run(VoidCallback action) {
    _timer.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds!), action);
  }
}
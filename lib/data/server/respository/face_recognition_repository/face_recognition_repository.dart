import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hrm_app/api_service/api_service.dart';

class FaceRecognitionRepository{

  static Future registerFace(data) async {
    try {
      EasyLoading.show(status: 'loading...');
      if (kDebugMode) {
        print("/user/face-recognition");
      }
      var response =
      await ApiService.getDio()!.post("/user/face-recognition", data: data);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var obj = response.data;
        return obj;
      }
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.response);
      }
    }
  }

  static Future getFaceMatching() async {
    try {
      EasyLoading.show(status: 'loading...');
      if (kDebugMode) {
        print("/user/get-face-data");
      }
      var response =
      await ApiService.getDio()!.get("/user/get-face-data");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var obj = response.data;
        return obj;
      }
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.response);
      }
    }
  }
}
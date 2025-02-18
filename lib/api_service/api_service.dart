import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hrm_app/main.dart';
import 'package:hrm_app/utils/app_const.dart';
import 'package:hrm_app/utils/shared_preferences.dart';

class ApiService {
  static Dio? _dio;
  static Dio? _dioLocation;


  static Dio? getDio() {
      BaseOptions options = BaseOptions(baseUrl: global.get(SPUtill.companyUrl) ?? AppConst.loginUrl ,
          headers: {
            Headers.contentTypeHeader : Headers.jsonContentType
          });

      _dio = Dio(options);

      _dio!.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {

        if (kDebugMode) {
          print('Base Url : ${options.baseUrl}');
          print('End Point : ${options.path}');
          print('url : ${options.baseUrl}${options.path}');
          print('Method : ${options.method}');
          print('Data : ${options.data}');
        }

        var token = await SPUtill.getValue(SPUtill.keyAuthToken);
        if (token != null) {
            if (kDebugMode) {
              print(("token :: $token"));
            }
          options.headers = {
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8',
            'Authorization': "${AppConst.bearerToken} $token",
            'Accept' : "application/json"
          };
        }
        return handler.next(options);
      }, onResponse: (response, handler) {
        if (kDebugMode) {
          print('response data : ${response.data}');
        }
        return handler.next(response);
      }, onError: (DioError e, handler) {
        if (kDebugMode) {
          print('Error Response : ${e.response}');
          print('Error message : ${e.message}');
          print('Error type : ${e.type.name}');
        }
        return handler.next(e);
      }));

    return _dio;
  }

  static Dio? getDioLocation() {
    if (_dioLocation == null) {
      BaseOptions options = BaseOptions(baseUrl: AppConst.baseUrlLocation);

      _dioLocation = Dio(options);

      _dioLocation!.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
        var token = await SPUtill.getValue(SPUtill.keyAuthToken);
        if (token != null) {
          if (kDebugMode) {
            print(("token :: $token"));
          }
          options.headers = {
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8',
            'Authorization': "${AppConst.bearerToken} $token"
          };
        }
        return handler.next(options);
      }, onResponse: (response, handler) {
        return handler.next(response);
      }, onError: (DioError e, handler) {
        return handler.next(e);
      }));
    }
    return _dioLocation;
  }
}

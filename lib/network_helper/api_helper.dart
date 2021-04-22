import 'dart:convert';
import 'package:book_it/UI/Utills/AppConstantHelper.dart';
import 'package:book_it/model/CommonResponse.dart';
import 'package:dio/dio.dart';

import 'local_storage.dart';
import 'logging_interceptor.dart';

class ApiHelper {
  Dio _dio;
  BaseOptions options;

  ApiHelper() {
    options = BaseOptions(
      connectTimeout: 20000,
      receiveTimeout: 20000,
    );
    String authTOKEN;
    _dio = Dio(options);
    LocalStorage.getUserAuthToken().then((value) {
      authTOKEN = "" + value;
      print("authTOKEN $authTOKEN");
    });

    options.baseUrl = "https://bells-palsy.net/";
    _dio.options.headers['content-Type'] = 'application/json';

    _dio.interceptors.add(LoggingInterceptor());
//    var token = isIos ? StringResourse.ios_jwt : StringResourse.android_jwt;
  }

  dynamic post({String apiUrl, FormData formData}) async {
    try {
      Response res = await _dio.post(apiUrl, data: formData);

      print("statusCode${res.statusCode}");

      return res.data;
    } on DioError catch (e) {
      //showDialog(false, "Internet is not Working");

      _handleError(e);

      throw Exception("Something wrong");
    }
  }

  dynamic postImage({String apiUrl, FormData formData}) async {
    try {
      Response res = await _dio.post(apiUrl,
          data: formData, options: Options(contentType: "multipart/form-data"));
      print("statusCode${res.statusCode}");

      return res.data;
    } on DioError catch (e) {
      //showDialog(false, "Internet is not Working");

      _handleError(e);

      throw Exception("Something wrong");
    }
  }

  dynamic get({String apiUrl, FormData formData, String authToken}) async {
    print("ApiUrl  $apiUrl");

    if (authToken != null) {
      _dio.options.headers["Authorization"] = "Bearer $authToken";
    }

    try {
      Response res = await _dio.get(
        apiUrl,
      );

      print("statusCode${res.statusCode}");
      print("REPPPPP${json.decoder}");
      return res.data;
    } on DioError catch (e) {
      //showDialog(false, "Internet is not Working");
      print("Errrororororororororororororororo");
      _handleError(e.error);
//      if (e.error != null && e.response.data != null) {
//        print(e.response.data);
//
//        //return LoginResponse.fromJson(e.response.data);
//      } else {
//        print(e.request);
//        print(e.message);
//      }
    }
  }

  dynamic delete({String apiUrl, String authToken}) async {
    try {
      Response res = await _dio.delete(
        apiUrl,
      );

      print("statusCode${res.statusCode}");

      return res.statusCode;
    } on DioError catch (e) {
      //showDialog(false, "Internet is not Working");
      _handleError(e);

      throw Exception("Something wrong");
    }
  }

  dynamic patch({
    String apiUrl,
    FormData formData,
  }) async {
    try {
      Response res = await _dio.patch(apiUrl, data: formData);

      print("statusCode${res.statusCode}");

      return res.data;
    } on DioError catch (e) {
      //showDialog(false, "Internet is not Working");

      _handleError(e);

      throw Exception("Something wrong");
    }
  }

  String _handleError(DioError error) {
    AppConstantHelper helper = AppConstantHelper();
    String errorDescription = "";

    DioError dioError = error;
    switch (dioError.type) {
      case DioErrorType.CANCEL:
        helper.showAlert(true, "Request to API server was cancelled");
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        helper.showAlert(true, "Connection timeout with API server");
        break;
      case DioErrorType.DEFAULT:
        helper.showAlert(
            true, "Connection to API server failed due to internet connection");
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        helper.showAlert(true, "Receive timeout in connection with API server");
        break;
      case DioErrorType.RESPONSE:
        var res = CommonResponse.fromJson(dioError.response.data);
        helper.showAlert(true, "${res.message}");
        break;
      case DioErrorType.SEND_TIMEOUT:
        helper.showAlert(true, "Send timeout in connection with API server");
        break;
    }
  }
}

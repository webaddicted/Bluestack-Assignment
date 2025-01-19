import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tournament/utils/constant/api_constant.dart';
import 'package:tournament/utils/constant/string_const.dart';

/// Helper class for configuring Api calls
class ApiBaseHelper {
  Dio? _dio;

  ApiBaseHelper() {
    var options = BaseOptions(
        receiveTimeout: Duration(seconds: ApiConstant.timeOut),
        connectTimeout: Duration(seconds: ApiConstant.timeOut));
    options.baseUrl = ApiConstant.baseUrl;
    _dio = Dio(options);
    _dio?.interceptors.add(LogInterceptor());
  }

  /// Method : GET
  /// Params : url, map for parameters
  Future<Response<dynamic>> get(
      {String url = '', Map<String, dynamic>? params}) async {
    Response response;
    try {
      response = (await _dio?.get(url,
          queryParameters: params,
          options: Options(responseType: ResponseType.json)))!;
    } on SocketException catch (_) {
      print('object SocketException');
      response = Response(requestOptions: RequestOptions(path: 'path'));
      response.statusCode = ApiResponseCode.internetUnavailable;
      response.statusMessage = StringConst.noInternetConnection;
    } on Exception catch (e) {
      print('object Exception');
      response = Response(requestOptions: RequestOptions(path: 'path'));
      response.statusCode = ApiResponseCode.unknown;
      response.statusMessage =
          e.toString() + " " + StringConst.somethingWentWrong;
      // response.data = e;
    }
    print('response : $response');
    return response;
  }

  /// Method : POST
  /// Params : url, map for parameters
  Future<Response> post({String url = '', Map<String, dynamic>? params}) async {
    var response = await _dio!.post(url,
        data: params, options: Options(responseType: ResponseType.json));
    return response;
  }

  /// Method : PUT
  /// Params : url, map for parameters
  Future<Response> put(String url, Map<String, String> params) async {
    var response = await _dio!.put(url,
        data: params, options: Options(responseType: ResponseType.json));
    return response;
  }

  /// Method : DELETE
  /// Params : url, map for parameters
  Future<Response> delete(String url, Map<String, String> params) async {
    var response = await _dio!.delete(url,
        data: params, options: Options(responseType: ResponseType.json));
    return response;
  }
}

/// Api Response codes
class ApiResponseCode {
  static const int success200 = 200;
  static const int success201 = 201;
  static const int error400 = 400;
  static const int error499 = 499;
  static const int error401 = 201;
  static const int error404 = 201;
  static const int error500 = 500;
  static const int internetUnavailable = 999;
  static const int unknown = 533;
}

final apiHelper = ApiBaseHelper();

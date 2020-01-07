import 'package:dio/dio.dart';
import 'code.dart';
// import 'logs_interceptor.dart';
import 'response_interceptor.dart';
import 'result_data.dart';
import 'package:hello_world/api/api.dart';

class HttpManager {
  static HttpManager _instance = HttpManager._internal();
  Dio _dio;

  static const CODE_SUCCESS = 200;
  static const CODE_TIME_OUT = -1;

  factory HttpManager() => _instance;

  ///通用全局单例，第一次使用时初始化
  HttpManager._internal({String baseUrl}) {
    if (null == _dio) {
      _dio = new Dio(new BaseOptions(
          baseUrl: Api.BASE_URL,
          connectTimeout: 15000,
          headers: {
            'X-APIS-SID': "cc1ede30-207c-11ea-bf55-0f2313034e5d",
            'X-APIS-Version': 'v3',
            'X-APIS-Application': 'usercenter'
          }));
      _dio.interceptors.add(LogInterceptor(responseBody: false));
      _dio.interceptors.add(new MyInterceptors());
    }
  }

  static HttpManager getInstance({String baseUrl}) {
    if (baseUrl == null) {
      return _instance._normal();
    } else {
      return _instance._baseUrl(baseUrl);
    }
  }

  //用于指定特定域名，比如cdn和kline首次的http请求
  HttpManager _baseUrl(String baseUrl) {
    if (_dio != null) {
      _dio.options.baseUrl = baseUrl;
    }
    return this;
  }

  //一般请求，默认域名
  HttpManager _normal() {
    if (_dio != null) {
      if (_dio.options.baseUrl != Api.BASE_URL) {
        _dio.options.baseUrl = Api.BASE_URL;
      }
    }
    return this;
  }

  ///通用的GET请求
  get(api, params, {noTip = false}) async {
    Response response;
    try {
      response = await _dio.get(api, queryParameters: params);
    } on DioError catch (e) {
      return resultError(e);
    }

    if (response.data is DioError) {
      return resultError(response.data['code']);
    }

    return response.data;
  }

  ///通用的POST请求
  post(api, params, {noTip = false}) async {
    Response response;

    try {
      response = await _dio.post(api, data: params);
    } on DioError catch (e) {
      return resultError(e);
    }

    if (response.data is DioError) {
      return resultError(response.data['code']);
    }

    return response.data;
  }
}

ResultData resultError(DioError e) {
  Response errorResponse;
  if (e.response != null) {
    errorResponse = e.response;
  } else {
    errorResponse = new Response(statusCode: 666);
  }
  if (e.type == DioErrorType.CONNECT_TIMEOUT ||
      e.type == DioErrorType.RECEIVE_TIMEOUT) {
    errorResponse.statusCode = Code.NETWORK_TIMEOUT;
  }
  return new ResultData(
      errorResponse.statusMessage, false, errorResponse.statusCode);
}

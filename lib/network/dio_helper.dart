import 'package:dio/dio.dart';
import 'package:shop_app/network/end_points.dart';

class DioHelper {
  static late Dio _dio;

  static void init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
     Map<String,dynamic>? query,
    String lang="en",
    String? token,
  }) async {
    _dio.options.headers= {
     'Content-Type' :'application/json',
    'lang':lang,
    'Authorization':token??'',
    };
    return await _dio.get(url,queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
     Map<String,dynamic>? query,
    required Map<String,dynamic> data,
    String lang="en",
    String? token,
})async {
    _dio.options.headers= {
      'Content-Type' :'application/json',
      'lang':lang,
      'Authorization':token,
    };
    return _dio.post(url,queryParameters: query,data: data);
  }


  static Future<Response> putData({
    required String url,
    Map<String,dynamic>? query,
    required Map<String,dynamic> data,
    String lang="en",
    String? token,
  })async {
    _dio.options.headers= {
      'Content-Type' :'application/json',
      'lang':lang,
      'Authorization':token,
    };
    return _dio.put(url,queryParameters: query,data: data);
  }

}
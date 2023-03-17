import 'package:dio/dio.dart';

import '../shared/constants.dart';


class DioHelper
{
  static late Dio dio;

  static init()
  {
    //print('dioHelper Initialized');
    dio = Dio(
        BaseOptions(
      baseUrl:'https://actitvityv1.onrender.com/',
      receiveDataWhenStatusError: true,
    ));
  }
  static Future<Response> getData ({
    required String url,
    required Map<String,dynamic> query,
    String ?token,
    Map<String,dynamic> ?data,
  })async
  {
    // dio.options.headers =
    // {
    //   'lang':lang,
    //   'Content-Type':'application/json',
    //   'Authorization' : '$token'
    // };
    return await dio.get(
        url,
        queryParameters: query
    );
  }

  static Future<Response> postData ({
    required String url,
    required Map<String,dynamic> query,
    Map<String,dynamic> ?data,
    String ?token
  })async
  {
    // dio.options.headers =
    // {
    //   'lang':lang,
    //   'Content-Type':'application/json',
    //   'Authorization' : '$token'
    // };
    return await dio.post(
        url,
        queryParameters: query,
        data: data,

    );
  }

  static Future<Response> putData ({
    required String url,
    required Map<String,dynamic> query,
    Map<String,dynamic> ?data,
    String ?token
  })async
  {
    // dio.options.headers =
    // {
    //   'lang':lang,
    //   'Content-Type':'application/json',
    //   'Authorization' : '$token'
    // };
    return await dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> deleteData ({
    required String url,
    String ?token
  })async
  {
    // dio.options.headers =
    // {
    //   'lang':lang,
    //   'Content-Type':'application/json',
    //   'Authorization' : '$token'
    // };
    return await dio.delete(url);
  }
}

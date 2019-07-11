import 'package:dio/dio.dart';

class HttpUtil{
  static var dio;
  static Dio getDio(){
    if(dio == null){
      dio = new Dio();
    }
    return dio;
  }
}
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiService{
  final Dio dio = Dio();

  Future<Response> post ({required body,
   required String url,
   required String token,
   Map<String , String>? headers,
   String? contentType, }) async{
      var response = await dio.post(url,
      data: body,
      options:  Options(
        contentType: contentType,
        headers: headers ?? {'Authorization':"Bearer $token"}, 
      ));
      return response;
  }
}
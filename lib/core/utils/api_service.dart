import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiService{
  final Dio dio = Dio();

  Future<Response> post ({required body,
   required String url,
   required String token,
   String? ContentType}) async{
      var response = await dio.post(url,
      data: body,
      options:  Options(
        contentType: ContentType,
        headers: {'Authorization':"Bearer $token"}, 
      ));
      return response;
  }
}
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:storeapi/config/connection_errors.dart';
import 'package:storeapi/data/model/usuario.dart';

abstract class ApiAuth {
  Future<Usuario?> login(String usuario,String password);
}

class ApiAuthImpl implements ApiAuth {
  String urlGeneral = "https://fakestoreapi.com/";
  final dio = Dio();

  @override
  Future<Usuario?> login(String usuario,String password) async {
    final loginUrl = "${urlGeneral}auth/login";
    var json =  {
      "username": usuario,
      "password": password,
    };
    var jsonEn = jsonEncode(json);
    if (kDebugMode) {
      print("[DIO] [POST] $loginUrl - $jsonEn");
    }
    final Response<Map<String, dynamic>> response = await dio.post(loginUrl,data: jsonEn);
    if (kDebugMode) {
      print("[DIO] ${response.statusCode}");
    }
    bool respuesta = ConnectionError.ProcesarRespuesta(response.statusCode!);
    if(respuesta == true){
      if (kDebugMode) {
        print("[DIO] ${response.data}");
      }
      return Usuario.fromJson(response.data!);
    }
    return null;

  }
}
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:storeapi/data/model/usuario.dart';

abstract class ApiAuth {
  Future<Usuario> login(String usuario,String password);
}

class ApiAuthImpl implements ApiAuth {
  String urlGeneral = "https://fakestoreapi.com/";
  final dio = Dio();

  @override
  Future<Usuario> login(String usuario,String password) async {
    final loginUrl = "${urlGeneral}auth/login";
    var json =  {
      "username": usuario,
      "password": password,
    };
    var jsonEn = jsonEncode(json);
    print("[DIO] [POST] $loginUrl - $jsonEn");
    final Response<Map<String, dynamic>> response = await dio.post(loginUrl,data: jsonEn);
    print("[DIO] ${response.statusCode}");
    if(response.statusCode == 200){
      print("[DIO] ${response.data}");
      return Usuario.fromJson(response.data!);
    }else if(response.statusCode == 401){
      throw Exception("Codigo 401: No te has autenticado de manera correcta");
    }else{
      throw Exception("Ha ocurrido un error al recuperar el token");

    }

  }
}
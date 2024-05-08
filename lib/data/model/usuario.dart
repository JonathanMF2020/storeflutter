import 'dart:convert';

class Usuario {
  final String token;


  Usuario.fromJson(Map<String, dynamic> json)
      : token = json['token'];

  Map<String, dynamic> toJson() => {
    'token': token,
  };
}

import 'dart:convert';

import 'package:storeapi/data/model/producto_response.dart';

class CarritoResponse {
  int? id;
  int? userid;
  String? date;
  List<ProductoResponse>? products;

  CarritoResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userid = json['userid'],
        date = json['date'],
        products = _createProductosResponse(json['productosCarrito'] as List<dynamic>);

  static List<ProductoResponse> _createProductosResponse(List<dynamic> jsonData) {
    List<ProductoResponse> lista = jsonData
        .map((data) => ProductoResponse.fromJson(jsonDecode(data)))
        .toList();
    return lista;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'userid': userid,
    'date': date,
    'products':products == null
        ? null
        : List<dynamic>.from(products!.map((ProductoResponse x) => jsonEncode(x.toJson()))),
  };
}
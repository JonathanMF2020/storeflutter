import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:storeapi/data/model/carrito.dart';
import 'package:storeapi/data/model/carrito_response.dart';
import 'package:storeapi/data/model/producto_response.dart';

abstract class ApiCarrito {
  bool guardarCarrito(Carrito carrito);
}

class ApiCarritoImpl implements ApiCarrito {
  String urlGeneral = "https://fakestoreapi.com/";
  final dio = Dio();
  @override
  bool guardarCarrito(Carrito carrito) {
    final carritosUrL = "${urlGeneral}carts";
    DateTime now = DateTime.now();
    String formattedDate = now.toIso8601String().split('T').first;
    List<ProductoResponse> productoResponse = [];
    for (var element in carrito.productosCarrito!) {
      ProductoResponse pr = ProductoResponse();
      pr.productId = element.producto!.id;
      pr.quantity = element.cantidad;
      productoResponse.add(pr);
    }
    Map<String, dynamic> body = {
      'userId': 5,
      'date': formattedDate,
      'products': productoResponse == null
    ? null
        : List<dynamic>.from(productoResponse.map((ProductoResponse x) => jsonEncode(x.toJson()))),
    };
    print("[DIO] [POST] $carritosUrL : $body");
    return true;
  }

}
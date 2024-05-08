import 'dart:convert';

import 'package:storeapi/data/model/productos_carrito.dart';


class Carrito {

  double? total;
  double? subtotal;
  int? cantidad;
  List<ProductosCarrito>? productosCarrito;

  Carrito crearModelo(){
    Carrito carrito = Carrito();
    carrito.cantidad = 0;
    carrito.subtotal = 0.0;
    carrito.total = 0.0;
    carrito.productosCarrito = null;
    return carrito;
  }

  Carrito();

  Carrito.fromJson(Map<String, dynamic> json)
      : cantidad = json['cantidad'],
      total = double.parse(json['total'].toString()),
      subtotal = double.parse(json['subtotal'].toString()),
      productosCarrito = _createProductosCarrito(json['productosCarrito'] as List<dynamic>);

  static List<ProductosCarrito> _createProductosCarrito(List<dynamic> jsonData) {
    List<ProductosCarrito> lista = jsonData
        .map((data) => ProductosCarrito.fromJson(jsonDecode(data)))
        .toList();
    return lista;
  }

  Map<String, dynamic> toJson() => {
    'cantidad': cantidad,
    'total': total,
    'subtotal': subtotal,
    'productosCarrito': productosCarrito == null
        ? null
        : List<dynamic>.from(productosCarrito!.map((ProductosCarrito x) => jsonEncode(x.toJson()))),
  };

}
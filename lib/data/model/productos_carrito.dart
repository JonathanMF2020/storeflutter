import 'dart:convert';

import 'package:storeapi/data/model/producto.dart';


class ProductosCarrito {

  int cantidad;
  Producto? producto;

  ProductosCarrito(this.cantidad, this.producto);

  ProductosCarrito.fromJson(Map<String, dynamic> json) :
    cantidad = json['cantidad'],
    producto = json['producto'] == null ? null : Producto.fromJson(json['producto']);

  Map<String, dynamic> toJson() => {
    'cantidad': cantidad,
    'producto': producto != null ? producto!.toJson() : null,
  };

}
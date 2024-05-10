
import 'package:storeapi/data/model/producto.dart';


class ProductosCarrito {

  int cantidad;
  double? suma;
  Producto? producto;

  ProductosCarrito(this.cantidad, this.producto);

  ProductosCarrito.fromJson(Map<String, dynamic> json) :
    cantidad = json['cantidad'],
    suma = json['suma'] == null ? 0 : json['suma'],
    producto = json['producto'] == null ? null : Producto.fromJson(json['producto']);

  Map<String, dynamic> toJson() => {
    'cantidad': cantidad,
    'suma': suma == null? 0: suma,
    'producto': producto != null ? producto!.toJson() : null,
  };

}
import 'package:storeapi/data/model/carrito.dart';

abstract class CarritoRepository {
  Carrito obtenerCarrito();
  Future<bool> salvarCarrito(Carrito carrito);
}
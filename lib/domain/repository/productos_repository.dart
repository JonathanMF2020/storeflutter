import 'package:storeapi/data/model/producto.dart';

abstract class ProductosRepository {
  Future<List<Producto>?> obtenerProductos();
  Future<List<Producto>?> obtenerProductosLimit(int limite);
}
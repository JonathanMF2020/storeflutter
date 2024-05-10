import 'package:storeapi/data/model/producto.dart';
import 'package:storeapi/data/source/network/api_productos.dart';
import 'package:storeapi/domain/repository/productos_repository.dart';

class ProductoRepositoryImpl implements ProductosRepository {
  final ApiProducto _api;

  ProductoRepositoryImpl({
    required ApiProducto api,
  })  : _api = api;

  @override
  Future<List<Producto>?> obtenerProductos()async {
    return await _api.obtenerProductos();
  }

  @override
  Future<List<Producto>?> obtenerProductosLimit(int limite)async {
    return await _api.obtenerProductosLimit(limite);
  }
}
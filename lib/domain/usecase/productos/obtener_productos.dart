import 'package:storeapi/data/model/producto.dart';
import 'package:storeapi/domain/repository/productos_repository.dart';

class ObtenerProductos {
  ObtenerProductos({
    required ProductosRepository repository,
  }) : _repository = repository;

  final ProductosRepository _repository;

  Future<List<Producto>?> call() async {
    return await _repository.obtenerProductos();
  }
}
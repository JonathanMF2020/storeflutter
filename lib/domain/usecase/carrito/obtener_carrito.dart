import 'package:storeapi/data/model/carrito.dart';
import 'package:storeapi/domain/repository/carrito_repository.dart';

class ObtenerCarrito {
  ObtenerCarrito({
    required CarritoRepository repository,
  }) : _repository = repository;

  final CarritoRepository _repository;

  Future<Carrito> call() async {
    return _repository.obtenerCarrito();
  }
}
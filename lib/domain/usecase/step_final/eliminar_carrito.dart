import 'package:storeapi/data/model/carrito.dart';
import 'package:storeapi/domain/repository/carrito_repository.dart';

class EliminarCarrito {
  EliminarCarrito({
    required CarritoRepository repository,
  }) : _repository = repository;

  final CarritoRepository _repository;

  Future<bool> call(Carrito carrito) async {
    _repository.agregarCarritoService(carrito);
    return await _repository.eliminarCarrito();
  }
}
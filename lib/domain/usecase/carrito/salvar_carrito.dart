import 'package:storeapi/data/model/carrito.dart';
import 'package:storeapi/domain/repository/carrito_repository.dart';

class SalvarCarrito {
  SalvarCarrito({
    required CarritoRepository repository,
  }) : _repository = repository;

  final CarritoRepository _repository;

  Future<bool> call(Carrito Carrito) async {
    print("Guardando Use case");
    return _repository.salvarCarrito(Carrito);
  }
}
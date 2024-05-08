import 'package:storeapi/data/model/carrito.dart';
import 'package:storeapi/data/source/local/storage_carrito.dart';
import 'package:storeapi/domain/repository/carrito_repository.dart';

class CarritoRepositoryImpl implements CarritoRepository {
  final StorageCarrito _storageCarrito;

  CarritoRepositoryImpl({
    required StorageCarrito storageCarrito
  }) : _storageCarrito = storageCarrito;

  @override
  Carrito obtenerCarrito() {
    return _storageCarrito.getCarrito();
  }

  @override
  Future<bool> salvarCarrito(Carrito carrito) {
    print("Guardando Carrito...:  $carrito");
    return _storageCarrito.setCarrito(carrito);
  }
}
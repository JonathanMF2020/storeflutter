import 'package:storeapi/data/model/carrito.dart';
import 'package:storeapi/data/source/local/storage_carrito.dart';
import 'package:storeapi/data/source/network/api_carrito.dart';
import 'package:storeapi/domain/repository/carrito_repository.dart';

class CarritoRepositoryImpl implements CarritoRepository {
  final StorageCarrito _storageCarrito;
  final ApiCarrito _apiCarrito;

  CarritoRepositoryImpl({
    required StorageCarrito storageCarrito,
    required ApiCarrito apiCarrito
  }) : _storageCarrito = storageCarrito, _apiCarrito = apiCarrito;

  @override
  Carrito obtenerCarrito() {
    return _storageCarrito.getCarrito();
  }

  @override
  Future<bool> salvarCarrito(Carrito carrito) {
    return _storageCarrito.setCarrito(carrito);
  }

  @override
  Future<bool> eliminarCarrito() {
    return _storageCarrito.eliminarCarrito();
  }

  @override
  bool agregarCarritoService(Carrito carrito) {
    return _apiCarrito.guardarCarrito(carrito);
  }
}
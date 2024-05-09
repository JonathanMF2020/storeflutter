import 'package:storeapi/data/model/carrito.dart';
import 'package:storeapi/data/model/producto.dart';
import 'package:storeapi/data/model/productos_carrito.dart';
import 'package:storeapi/domain/repository/carrito_repository.dart';

class SalvarCarrito {
  SalvarCarrito({
    required CarritoRepository repository,
  }) : _repository = repository;

  final CarritoRepository _repository;

  Future<bool> call(Carrito carrito, int cantidad, Producto productoObjeto) async {
    if(carrito.productosCarrito!.isNotEmpty)
    {
      var producto = carrito.productosCarrito!.firstWhere((element) => element.producto!.id == productoObjeto.id, orElse: () => ProductosCarrito(cantidad,productoObjeto));
      if(producto == null){
        carrito.productosCarrito!.add(producto);
      }else{
        carrito.productosCarrito!.remove(producto);
        producto.cantidad = cantidad;
        carrito.productosCarrito!.add(producto);
      }

    }else{
      var productoCarrito = ProductosCarrito(cantidad,productoObjeto);
      carrito.productosCarrito!.add(productoCarrito);
    }
    var precioTotal = 0.0;
    carrito.cantidad = 0;
    for (var element in carrito.productosCarrito!) {
      element.suma = 0;
      element.suma = element.suma!+(element.cantidad*element.producto!.price);
      precioTotal += element.producto!.price;
      carrito.cantidad = (carrito.cantidad!+element.cantidad);
    }
    carrito.total = precioTotal;
    carrito.subtotal = precioTotal;
    print("Guardando Use case");
    return _repository.salvarCarrito(carrito);
  }
}
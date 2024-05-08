import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeapi/data/carrito_repository_impl.dart';
import 'package:storeapi/data/model/carrito.dart';
import 'package:storeapi/data/model/producto.dart';
import 'package:storeapi/data/model/productos_carrito.dart';
import 'package:storeapi/data/source/local/storage_carrito.dart';
import 'package:storeapi/domain/usecase/carrito/obtener_carrito.dart';
import 'package:storeapi/domain/usecase/carrito/salvar_carrito.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  late ObtenerCarrito _useCase;
  late SalvarCarrito _useCase2;

  DetailBloc() : super(DetailInitial()) {
    on<GetCarrito>((event, emit) async {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var storageCarrito = StorageCarritoImpl(sharedPreferences: sharedPreferences);
      var repository = CarritoRepositoryImpl(storageCarrito: storageCarrito);
      _useCase = ObtenerCarrito(repository: repository);
      var carrito = await _useCase.call();
      print("Obteniendo Bloc: $carrito");
      emit(DetailObtenerCarritoSuccess(carrito: carrito));
    });
    on<SalvarCarritoEvent>((event, emit) async {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var storageCarrito = StorageCarritoImpl(sharedPreferences: sharedPreferences);
      var repository = CarritoRepositoryImpl(storageCarrito: storageCarrito);
      _useCase = ObtenerCarrito(repository: repository);
      _useCase2 = SalvarCarrito(repository: repository);
      var carrito = await _useCase.call();
      if(carrito.productosCarrito!.isNotEmpty)
      {
        print("Entro 1");
        var producto = carrito.productosCarrito!.firstWhere((element) => element.producto!.id == event.producto.id, orElse: () => ProductosCarrito(event.cantidad,event.producto));
        if(producto == null){
          print("Entro 2");
          carrito.productosCarrito!.add(producto);
        }else{
          print("Entro 3");
          carrito.productosCarrito!.remove(producto);
          producto.cantidad = event.cantidad;
          carrito.productosCarrito!.add(producto);
        }

      }else{
        var productoCarrito = ProductosCarrito(event.cantidad,event.producto);
        carrito.productosCarrito!.add(productoCarrito);
      }
      var precioTotal = 0.0;
      carrito.cantidad = 0;
      for (var element in carrito.productosCarrito!) {
        precioTotal += element.producto!.price;
        carrito.cantidad = (carrito.cantidad!+element.cantidad);
      }
      carrito.total = precioTotal;
      carrito.subtotal = precioTotal;
      await _useCase2.call(carrito);
      emit(DetailObtenerCarritoSuccess(carrito: carrito));
    });
  }
}

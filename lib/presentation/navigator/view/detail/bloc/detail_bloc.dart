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
      await _useCase2.call(carrito, event.cantidad,event.producto);
      emit(DetailObtenerCarritoSuccess(carrito: carrito));
    });
  }
}

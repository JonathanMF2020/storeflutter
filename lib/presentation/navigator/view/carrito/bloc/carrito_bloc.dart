import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeapi/data/carrito_repository_impl.dart';
import 'package:storeapi/data/model/carrito.dart';
import 'package:storeapi/data/source/local/storage_carrito.dart';
import 'package:storeapi/domain/usecase/carrito/obtener_carrito.dart';

part 'carrito_event.dart';
part 'carrito_state.dart';

class CarritoBloc extends Bloc<CarritoEvent, CarritoState> {

  late ObtenerCarrito _useCase;
  CarritoBloc() : super(CarritoInitial()) {
    on<CarritoObtenerEvent>((event, emit) async {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var storageCarrito = StorageCarritoImpl(sharedPreferences: sharedPreferences);
      var repository = CarritoRepositoryImpl(storageCarrito: storageCarrito);
      _useCase = ObtenerCarrito(repository: repository);
      var carrito = await _useCase.call();
      emit(CarritoSuccess(carrito: carrito));
    });
  }
}

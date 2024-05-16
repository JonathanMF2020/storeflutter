import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeapi/data/carrito_repository_impl.dart';
import 'package:storeapi/data/model/carrito.dart';
import 'package:storeapi/data/source/local/storage_carrito.dart';
import 'package:storeapi/data/source/network/api_carrito.dart';
import 'package:storeapi/domain/usecase/carrito/obtener_carrito.dart';

part 'botttom_bar_event.dart';
part 'botttom_bar_state.dart';

class BotttomBarBloc extends Bloc<BotttomBarEvent, BotttomBarState> {
  late ObtenerCarrito _useCase;
  BotttomBarBloc() : super(BotttomBarInitial()) {
    on<ObtenerCarritoEvent>((event, emit) async {
      var api = ApiCarritoImpl();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var storageCarrito = StorageCarritoImpl(sharedPreferences: sharedPreferences);
      var repository = CarritoRepositoryImpl(storageCarrito: storageCarrito, apiCarrito: api);
      _useCase = ObtenerCarrito(repository: repository);
      var carrito = await _useCase.call();
      emit(BotttomBarCarritoSuccess(carrito: carrito));
    });
  }
}

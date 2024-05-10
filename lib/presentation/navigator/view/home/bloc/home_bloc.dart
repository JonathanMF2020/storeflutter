import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapi/data/model/producto.dart';
import 'package:storeapi/data/productos_repository_impl.dart';
import 'package:storeapi/data/source/network/api_productos.dart';
import 'package:storeapi/domain/usecase/productos/obtener_productos.dart';
import 'package:flutter/material.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  late ObtenerProductos _obtenerProductos;
  HomeBloc():super(StateHomeInit()) {
    on<ObtenerProductosEvent>((event, emit) async {
      try{
        var api = ApiProductoImpl();
        var repository = ProductoRepositoryImpl(api: api);
        _obtenerProductos = ObtenerProductos(repository: repository);
        var productos = await _obtenerProductos.call();
        emit(StateHomeSuccess(productos: productos!));
      }on DioException catch(e){
        emit(StateHomeError(error: e.toString()));
      }
      catch (e,stack){
        emit(StateHomeError(error: e.toString()));
      }

    });
  }

}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:meta/meta.dart';
import 'package:storeapi/data/model/carrito.dart';
import 'package:storeapi/data/source/network/api_stripe.dart';
import 'package:storeapi/data/stripe_repository_impl.dart';
import 'package:storeapi/domain/usecase/checkout/pagar_productos.dart';
import 'package:storeapi/domain/usecase/step_final/eliminar_carrito.dart';

part 'step_final_event.dart';
part 'step_final_state.dart';

class StepFinalBloc extends Bloc<StepFinalEvent, StepFinalState> {
  late PagarProductos _pagarProductos;
  late EliminarCarrito eliminarCarrito;
  StepFinalBloc() : super(StepFinalInitial()) {
    on<PagarProductosEvent>((event, emit) async {
      var api = ApiStripeImpl();
      var repository = StripeRepositoryImpl(api: api);
      _pagarProductos = PagarProductos(repository: repository);
      bool respuesta = await _pagarProductos.call(detail: event.detail, total: event.total);
      if(respuesta){
        eliminarCarrito(event.carrito);
      }
      emit(StepFinalSuccess());
    });
  }
}

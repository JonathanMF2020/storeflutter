
import 'package:bloc/bloc.dart';
import 'package:storeapi/data/model/carrito.dart';
import 'package:storeapi/data/model/producto.dart';

part 'navigator_event.dart';
part 'navigator_state.dart';

class NavigatorBloc extends Bloc<NavigatorEvent, NavigatorState> {
  NavigatorBloc() : super(StateHome()) {
    on<GoHome>((event, emit) {
      emit(StateHome());
    });
    on<GoMiCarrito>((event, emit) {
      emit(StateMiCarrito());
    });
    on<GoCheckout>((event, emit) {
      emit(StateCheckout(carrito: event.carrito));
    });
    on<GoError>((event, emit) {
      emit(StateError(error: event.error));
    });
    on<GoDetail>((event, emit) {
      emit(StateDetail(event.producto));
    });
    on<GoAjustes>((event, emit) {
      emit(StateAjustes());
    });
  }
}

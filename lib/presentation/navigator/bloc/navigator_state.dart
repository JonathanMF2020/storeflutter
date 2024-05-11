part of 'navigator_bloc.dart';

abstract class NavigatorState  {}

class StateHome extends NavigatorState{}
class StateDetail extends NavigatorState {
  final Producto producto;

  StateDetail(this.producto);
}
class StateCheckout extends NavigatorState {
  final Carrito carrito;

  StateCheckout({required this.carrito});
}
class StateStepFinal extends NavigatorState {
  final Carrito carrito;

  StateStepFinal({required this.carrito});
}
class StateError extends NavigatorState {
  final String error;

  StateError({required this.error});
}
class StateMiCarrito extends NavigatorState{}
class StateAjustes extends NavigatorState{}

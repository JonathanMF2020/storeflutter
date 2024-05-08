part of 'navigator_bloc.dart';

abstract class NavigatorState  {}

class StateHome extends NavigatorState{}
class StateDetail extends NavigatorState {
  final Producto producto;

  StateDetail(this.producto);
}
class StateMiCarrito extends NavigatorState{}
class StateAjustes extends NavigatorState{}

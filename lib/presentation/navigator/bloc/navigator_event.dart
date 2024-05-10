part of 'navigator_bloc.dart';

abstract class NavigatorEvent {}
class GoHome extends NavigatorEvent{}
class GoDetail extends NavigatorEvent{
  Producto producto;
  GoDetail({required this.producto});
}
class GoCheckout extends NavigatorEvent{
  final Carrito carrito;
  GoCheckout({required this.carrito});
}

class GoError extends NavigatorEvent{
  final String error;
  GoError({required this.error});
}

class GoMiCarrito extends NavigatorEvent{}
class GoAjustes extends NavigatorEvent{}

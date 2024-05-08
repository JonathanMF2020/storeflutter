part of 'navigator_bloc.dart';

abstract class NavigatorEvent {}
class GoHome extends NavigatorEvent{}
class GoDetail extends NavigatorEvent{
  Producto producto;
  GoDetail({required this.producto});
}
class GoMiCarrito extends NavigatorEvent{}
class GoAjustes extends NavigatorEvent{}

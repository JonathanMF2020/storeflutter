part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class StateHomeInit extends HomeState {}
class StateHomeLoading extends HomeState {}
class StateHomeSuccess extends HomeState {
  List<Producto> productos;
  StateHomeSuccess({required this.productos});
}
class StateHomeError extends HomeState {
  String error;
  StateHomeError({required this.error});
}
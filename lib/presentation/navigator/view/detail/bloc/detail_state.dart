part of 'detail_bloc.dart';

@immutable
abstract class DetailState {}

class DetailInitial extends DetailState {}
class DetailObtenerCarritoSuccess extends DetailState {
  final Carrito carrito;
  DetailObtenerCarritoSuccess({required this.carrito});
}

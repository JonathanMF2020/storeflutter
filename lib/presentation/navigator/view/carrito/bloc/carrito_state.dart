part of 'carrito_bloc.dart';

@immutable
abstract class CarritoState {}

class CarritoInitial extends CarritoState {}
class CarritoSuccess extends CarritoState {
  final Carrito carrito;
  CarritoSuccess({required this.carrito});
}

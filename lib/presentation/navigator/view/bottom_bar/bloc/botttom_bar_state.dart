part of 'botttom_bar_bloc.dart';

@immutable
abstract class BotttomBarState {}

class BotttomBarInitial extends BotttomBarState {}
class BotttomBarCarritoSuccess extends BotttomBarState {
  final Carrito carrito;

  BotttomBarCarritoSuccess({required this.carrito});
}

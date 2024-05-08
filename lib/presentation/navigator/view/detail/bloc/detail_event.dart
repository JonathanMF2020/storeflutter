part of 'detail_bloc.dart';

@immutable
abstract class DetailEvent {}

class GetCarrito extends DetailEvent{}
class SalvarCarritoEvent extends DetailEvent{
  final int cantidad;
  final Producto producto;
  SalvarCarritoEvent({required this.cantidad, required this.producto});
}

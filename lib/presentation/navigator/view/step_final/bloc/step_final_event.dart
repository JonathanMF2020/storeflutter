part of 'step_final_bloc.dart';

@immutable
abstract class StepFinalEvent {}

class PagarProductosEvent extends StepFinalEvent{
  final double total;
  final CardDetails detail;

  PagarProductosEvent({required this.total, required this.detail});
}

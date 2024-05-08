import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print("[Bloc] Se ha creado un $bloc y se inicializo con ${bloc.state}");
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print("[Bloc] Esta ocurriendo un evento en $bloc evento: ${bloc.state}");


  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print("[Bloc] Esta cambiando el estado en $bloc de ${transition.currentState} a ${transition.nextState}");
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print("[Bloc] Ha ocurrido un error en $bloc error ${error.toString()}");

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print("[Bloc] Se ha cerrado el $bloc");
  }
}
}
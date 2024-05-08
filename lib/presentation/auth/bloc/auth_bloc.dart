

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeapi/data/source/local/storage_auth.dart';
import 'package:storeapi/data/source/network/api_auth.dart';
import 'package:storeapi/data/usuarios_repository_impl.dart';
import 'package:storeapi/domain/usecase/auth/login.dart';
import 'package:storeapi/domain/usecase/auth/obtener_token.dart';

part 'auth_event.dart';
part 'auth_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {

  late Login _login;
  late ObtenerToken _obtenerToken;
  AuthBloc()  : super(AuthInit()) {
    on<AuthLogin>((event, emit) async {
      var api = ApiAuthImpl();
      var sharedPreferences = await SharedPreferences.getInstance();
      var storageAuth = StorageAuthImpl(sharedPreferences: sharedPreferences);
      var repository = UsuarioRepositoryImpl(api: api, storageAuth: storageAuth);
      _obtenerToken = ObtenerToken(repository: repository);
      var token = await _obtenerToken.call();
      if(token == null){
        emit(AuthLoading());
      }else {
        emit(AuthSuccess(token));
      }
    });

    on<AuthLoginService>((event, emit) async {
      try{
        var api = ApiAuthImpl();
        var sharedPreferences = await SharedPreferences.getInstance();
        var storageAuth = StorageAuthImpl(sharedPreferences: sharedPreferences);
        var repository = UsuarioRepositoryImpl(api: api, storageAuth: storageAuth);
        _login = Login(repository: repository);
        await _login.call(event.usuario, event.password);
        var token = await _obtenerToken.call();
        emit(AuthSuccess(token!));
      }catch (e) {
        emit(AuthError(e.toString()));

      }
    });

    on<AuthGetToken>((event, emit) async {
      try{
        var api = ApiAuthImpl();
        var sharedPreferences = await SharedPreferences.getInstance();
        var storageAuth = StorageAuthImpl(sharedPreferences: sharedPreferences);
        var repository = UsuarioRepositoryImpl(api: api, storageAuth: storageAuth);
        _obtenerToken = ObtenerToken(repository: repository);
        String? token = await _obtenerToken.call();
        emit(AuthSuccessGetToken(token!));
      }catch (e) {
        emit(AuthError(e.toString()));

      }
    });
  }

}

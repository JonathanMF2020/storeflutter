part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthLogin extends AuthEvent {}
class AuthLoginService extends AuthEvent {
  String usuario;
  String password;
  AuthLoginService(this.usuario,this.password);
}
class AuthGetToken extends AuthEvent{}

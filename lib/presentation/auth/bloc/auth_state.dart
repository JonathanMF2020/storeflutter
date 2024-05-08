part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInit extends AuthState {}
class AuthLoading extends AuthState {}
class AuthLoadingService extends AuthState {}
class AuthSuccess extends AuthState {
  final String token;
  AuthSuccess(this.token);
}
class AuthSuccessGetToken extends AuthState {
  final String token;
  AuthSuccessGetToken(this.token);
}
class AuthError extends AuthState {
  final String error;
  AuthError(this.error);
}

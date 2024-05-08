
abstract class UsuarioRepository {
  Future<dynamic> login(String usuario,String password);
  String? getToken();
}
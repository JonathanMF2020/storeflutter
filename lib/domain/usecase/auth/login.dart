import 'package:storeapi/data/model/usuario.dart';
import 'package:storeapi/domain/repository/usuario_repository.dart';

class Login {
  Login({
    required UsuarioRepository repository,
  }) : _repository = repository;

  final UsuarioRepository _repository;

  Future<Usuario> call(String usuarioStrr,String password) async {
    Usuario usuario = await _repository.login(usuarioStrr,password);
    return usuario;
  }
}
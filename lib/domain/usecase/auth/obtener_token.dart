import 'package:storeapi/domain/repository/usuario_repository.dart';

class ObtenerToken {
  ObtenerToken({
    required UsuarioRepository repository,
  }) : _repository = repository;

  final UsuarioRepository _repository;

  Future<String?> call() async {
    return _repository.getToken();
  }
}
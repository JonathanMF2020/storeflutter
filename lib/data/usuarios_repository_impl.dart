import 'package:storeapi/data/model/usuario.dart';
import 'package:storeapi/data/source/local/storage_auth.dart';
import 'package:storeapi/data/source/network/api_auth.dart';
import 'package:storeapi/domain/repository/usuario_repository.dart';

class UsuarioRepositoryImpl implements UsuarioRepository {
  final ApiAuth _api;
  final StorageAuth _storageAuth;

  UsuarioRepositoryImpl({
    required ApiAuth api,
    required StorageAuth storageAuth
  })  : _api = api, _storageAuth = storageAuth;

  @override
  Future<Usuario?> login(String usuariostr,String password) async {
    Usuario? usuario = await _api.login(usuariostr,password);
    _storageAuth.setToken(usuario!.token);
    return usuario;
  }

  @override
  String? getToken() {
    return _storageAuth.getToken();
  }
}
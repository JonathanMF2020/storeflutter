import 'package:shared_preferences/shared_preferences.dart';

abstract class StorageAuth {
  Future<bool> setToken(String token);
  String? getToken();
}

class StorageAuthImpl implements StorageAuth{
  final SharedPreferences _sharedPref;

  StorageAuthImpl({required SharedPreferences sharedPreferences}): _sharedPref = sharedPreferences;

  @override
  Future<bool> setToken(String token) async {
    return _sharedPref.setString("TOKEN_USER", token);
  }

  @override
  String? getToken() {
    return _sharedPref.getString("TOKEN_USER");
  }

}
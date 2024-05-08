import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeapi/data/model/carrito.dart';

abstract class StorageCarrito{
  Future<bool> setCarrito(Carrito carrito);
  Carrito getCarrito();
}

class StorageCarritoImpl implements StorageCarrito{
  final SharedPreferences _sharedPref;

  StorageCarritoImpl({required SharedPreferences sharedPreferences}): _sharedPref = sharedPreferences;

  @override
  Carrito getCarrito() {
    final carrito = _sharedPref.getString("CARRITO");
    if(carrito == null){
      print("Generando Carrito");
      Carrito carrito = Carrito().crearModelo();
      setCarrito(carrito);
      return carrito;
    }else{
      print("Leyendo registro");
      Map<String,dynamic> map = jsonDecode(carrito) as Map<String, dynamic>;
      print("json $map");
      print("fromMap: ${Carrito.fromJson(map)}");
      return Carrito.fromJson(map);
    }


  }

  @override
  Future<bool> setCarrito(Carrito carrito) {
    return _sharedPref.setString("CARRITO", jsonEncode(carrito.toJson()));
  }

}
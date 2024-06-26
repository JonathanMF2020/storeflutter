import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeapi/data/model/carrito.dart';

abstract class StorageCarrito{
  Future<bool> setCarrito(Carrito carrito);
  Carrito getCarrito();
  Future<bool> eliminarCarrito();
}

class StorageCarritoImpl implements StorageCarrito{
  final SharedPreferences _sharedPref;

  StorageCarritoImpl({required SharedPreferences sharedPreferences}): _sharedPref = sharedPreferences;

  @override
  Carrito getCarrito() {
    final carrito = _sharedPref.getString("CARRITO");
    if(carrito == null){
      if (kDebugMode) {
        print("Generando Carrito");
      }
      Carrito carrito = Carrito().crearModelo();
      setCarrito(carrito);
      return carrito;
    }else{
      if (kDebugMode) {
        print("Leyendo registro");
      }
      Map<String,dynamic> map = jsonDecode(carrito) as Map<String, dynamic>;
      if (kDebugMode) {
        print("json $map");
      }
      if (kDebugMode) {
        print("fromMap: ${Carrito.fromJson(map)}");
      }
      return Carrito.fromJson(map);
    }


  }

  @override
  Future<bool> setCarrito(Carrito carrito) {
    return _sharedPref.setString("CARRITO", jsonEncode(carrito.toJson()));
  }

  @override
  Future<bool> eliminarCarrito() {
    return _sharedPref.remove("CARRITO");
  }

}
import 'package:dio/dio.dart';
import 'package:storeapi/data/model/producto.dart';

abstract class ApiProducto {
  Future<List<Producto>> obtenerProductos();
  Future<List<Producto>> obtenerProductosLimit(int limite);
}

class ApiProductoImpl implements ApiProducto {
  String urlGeneral = "https://fakestoreapi.com/";
  final dio = Dio();

  @override
  Future<List<Producto>> obtenerProductos() async {
    final productosUrL = "${urlGeneral}products";
    print("[DIO] [GET] $productosUrL");
    final response = await dio.get(productosUrL);
    print("[DIO] ${response.statusCode}");
    if(response.statusCode == 200){
      print("[DIO] ${response.data}");
      final l = (response.data as List<dynamic>)
          .map((e) => Producto.fromJson(e))
          .toList();
      return l;
    }else if(response.statusCode == 401){
      throw Exception("Codigo 401: No te has autenticado de manera correcta");
    }else{
      throw Exception("Ha ocurrido un error al recuperar el token");
    }
  }

  @override
  Future<List<Producto>> obtenerProductosLimit(int limite) async {
    final productosUrL = "${urlGeneral}products/$limite";
    print("[DIO] [GET] $productosUrL");
    final Response<Map<String, dynamic>> response = await dio.get(productosUrL);
    print("[DIO] ${response.statusCode}");
    if(response.statusCode == 200){
      print("[DIO] ${response.data}");
      final l = (response.data as List<dynamic>)
          .map((e) => Producto.fromJson(e))
          .toList();
      return l;
    }else if(response.statusCode == 401){
      throw Exception("Codigo 401: No te has autenticado de manera correcta");
    }else{
      throw Exception("Ha ocurrido un error al recuperar el token");
    }
  }
}

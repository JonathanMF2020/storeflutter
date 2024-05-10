import 'package:dio/dio.dart';
import 'package:storeapi/config/connection_errors.dart';
import 'package:storeapi/data/model/producto.dart';

abstract class ApiProducto {
  Future<List<Producto>?> obtenerProductos();
  Future<List<Producto>?> obtenerProductosLimit(int limite);
}

class ApiProductoImpl implements ApiProducto {
  String urlGeneral = "https://fakestoreapi.com/";
  final dio = Dio();

  @override
  Future<List<Producto>?> obtenerProductos() async {
    final productosUrL = "${urlGeneral}products";
    print("[DIO] [GET] $productosUrL");
    final response = await dio.get(productosUrL);
    print("[DIO] ${response.statusCode}");
    bool respuesta = ConnectionError.ProcesarRespuesta(response.statusCode!);
    if(respuesta == true){
      print("[DIO] ${response.data}");
      final l = (response.data as List<dynamic>)
          .map((e) => Producto.fromJson(e))
          .toList();
      return l;
    }
    return null;
  }

  @override
  Future<List<Producto>?> obtenerProductosLimit(int limite) async {
    final productosUrL = "${urlGeneral}products/$limite";
    print("[DIO] [GET] $productosUrL");
    final Response<Map<String, dynamic>> response = await dio.get(productosUrL);
    print("[DIO] ${response.statusCode}");
    bool respuesta = ConnectionError.ProcesarRespuesta(response.statusCode!);
    if(respuesta == true){
      print("[DIO] ${response.data}");
      final l = (response.data as List<dynamic>)
          .map((e) => Producto.fromJson(e))
          .toList();
      return l;
    }
    return null;
  }
}

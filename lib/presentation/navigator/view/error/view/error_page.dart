import 'package:flutter/material.dart';
import 'package:storeapi/presentation/asset.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key,required this.error});
  final String error;
  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.only(
            left: 16, right: 16, top: 16, bottom: 16),
        child: Center(
          child: Column(
            children: [
              Image.asset(Asset.PERRITO),
              Text("¡Lo sentimos!",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              Text("Ha ocurrido un error, favor de intentar mas tarde",style: TextStyle(fontSize: 15),),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(widget.error,overflow: TextOverflow.ellipsis),)
            ],
          ),
        ),
      ),
    );
  }
}

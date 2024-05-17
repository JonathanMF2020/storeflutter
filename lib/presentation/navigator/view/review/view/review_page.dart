import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:storeapi/presentation/asset.dart';
import 'package:storeapi/presentation/navigator/view/bottom_bar/view/bottom_bar_custom.dart';
import 'package:storeapi/presentation/widgets_app_custom.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:  const BottomBarCustom(index: 1),
        appBar: WidgetsAppCustom.AppBarCustom(
            atras: false, context: context, title: "Review"),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(
            left: 16, right: 16, top: 16, bottom: 16),
            child: Center(
              child: Column(
                children: [
                  Text("Gracias por tu compra",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                  Text("Tu pedido ha sido generado con exito",style: TextStyle(fontSize: 15),),
                  Image.asset(Asset.PERRITO_FELIZ)
                ],
              ),
            ),
          ),
        )
    );
  }

}
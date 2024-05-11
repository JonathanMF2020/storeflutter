import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:storeapi/data/model/carrito.dart';
import 'package:storeapi/data/model/productos_carrito.dart';
import 'package:storeapi/presentation/color.dart';
import 'package:storeapi/presentation/navigator/bloc/navigator_bloc.dart';
import 'package:storeapi/presentation/navigator/view/bottom_bar/view/bottom_bar_custom.dart';
import 'package:storeapi/presentation/widgets/slider_button.dart';
import 'package:storeapi/presentation/widgets_app_custom.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key, required this.carrito});
  final Carrito carrito;
  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:  const BottomBarCustom(index: 1),
      appBar: WidgetsAppCustom.AppBarCustom(
          atras: true, context: context, title: "Checkout"),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          margin: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.carrito.productosCarrito!
                      .map((e) => TarjetasProductos(e))
                      .toList(),
                ),

                const Text("Resumen",style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 30),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Subtotal",style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),),
                    Text("\$${widget.carrito.subtotal} USD",style: const TextStyle(
                        fontWeight: FontWeight.w300, fontSize: 15),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("IVA",style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),),
                    Text("\$${widget.carrito.iva} USD",style: const TextStyle(
                        fontWeight: FontWeight.w300, fontSize: 15),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Envio",style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),),
                    Text("\$${widget.carrito.envio} USD",style: const TextStyle(
                        fontWeight: FontWeight.w300, fontSize: 15),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total",style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),),
                    Text("\$${widget.carrito.total} USD",style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: SliderButton(

                    text: 'Desliza para pagar',
                    onSlided: () async {
                     // BlocProvider.of<CheckoutBloc>(context).add(PagarEvent());
                      //displayPaymentSheet();
                      BlocProvider.of<NavigatorBloc>(context).add(GoStepFinal(carrito: widget.carrito));
                      /*final paymentMethod = await stripe.Stripe.instance.createPaymentMethod(
                        params: const stripe.PaymentMethodParams.card(
                          paymentMethodData: stripe.PaymentMethodData(),
                        ),
                      );*/

                    },
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }



  Widget TarjetasProductos(ProductosCarrito pc) {
    var producto = pc.producto!;
    return Container(
      margin: const EdgeInsets.only(top: 10,bottom: 10),
      child: Card(
        color: Colors.grey.shade100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CachedNetworkImage(
                  imageUrl: producto.image,
                  width: 40,
                  fit: BoxFit.fill,
                  height: 40,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Container(
                        height: 200,
                        color: Colors.grey.shade300,
                      ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 16, right: 16),
                width: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(producto.title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(
                      "\$${pc.suma!.toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 13),
                    )
                  ],
                ),
              ),
            ],
          ),

          Container(
            child: Text(pc.cantidad.toString()),
          ),
        ]),
      ),
    );
  }


}

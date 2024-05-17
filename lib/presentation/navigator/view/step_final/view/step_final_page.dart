import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:storeapi/data/model/carrito.dart';
import 'package:storeapi/presentation/color.dart';
import 'package:storeapi/presentation/navigator/bloc/navigator_bloc.dart';
import 'package:storeapi/presentation/navigator/view/bottom_bar/view/bottom_bar_custom.dart';
import 'package:storeapi/presentation/navigator/view/step_final/bloc/step_final_bloc.dart';
import 'package:storeapi/presentation/widgets_app_custom.dart';

class StepFinalPage extends StatefulWidget {
  const StepFinalPage({super.key,required this.carrito});
  final Carrito carrito;

  @override
  State<StepFinalPage> createState() => _StepFinalPageState();
}

class _StepFinalPageState extends State<StepFinalPage> {
  final CardFormEditController controller = CardFormEditController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<StepFinalBloc, StepFinalState>(
      listener: (context, state) {
        if(state is StepFinalSuccess){
          FocusManager.instance.primaryFocus?.unfocus();
          BlocProvider.of<NavigatorBloc>(context).add(GoReview());
        }
      },
      child: Scaffold(
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
                  const Text("Registra tu pago",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: CardFormField(
                      autofocus: true,
                      countryCode: "MX",
                      controller: controller,
                      onCardChanged: (card) {
                        print('card details ${card!.number}');
                      },
                      dangerouslyGetFullCardDetails: true,
                      dangerouslyUpdateFullCardDetails: true,
                      style: CardFormStyle(
                        borderColor: AppColors.primerColor
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primerColor,
                      elevation: 0,
                    ),
                    onPressed: () async {
                      final cardDetails = CardDetails(
                          number: controller.details.number,
                          expirationMonth: controller.details.expiryMonth,
                          expirationYear: controller.details.expiryYear,
                          cvc: controller.details.cvc,
                      );
                      BlocProvider.of<StepFinalBloc>(context).add(PagarProductosEvent(total: widget.carrito.total!,detail: cardDetails,carrito: widget.carrito));
      
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 8),
                          child: Text(
                            "Pagar",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Icon(Icons.payment,color: Colors.white,)
                      ],
                    ),
                  ),
                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}

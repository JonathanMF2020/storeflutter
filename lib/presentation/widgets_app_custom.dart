import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapi/data/model/productos_carrito.dart';
import 'package:storeapi/presentation/color.dart';
import 'package:storeapi/presentation/navigator/bloc/navigator_bloc.dart' as n;
import 'package:storeapi/presentation/navigator/view/detail/bloc/detail_bloc.dart';

class WidgetsAppCustom {
  static Widget InputStore(TextEditingController controller, String hint2,
      IconData iconData2,
      {bool esPassword = false}) {
    return TextField(
      obscureText: esPassword,
      enableSuggestions: !esPassword,
      autocorrect: !esPassword,
      controller: controller,
      decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primerColor, width: 2),
          ),
          disabledBorder: const OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderSide: BorderSide(color: AppColors.primerColor, width: 2),
          ),
          enabledBorder: const OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderSide: BorderSide(color: AppColors.primerColor, width: 2),
          ),
          focusedBorder: const OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderSide: BorderSide(color: AppColors.primerColor, width: 2),
          ),
          hintStyle: const TextStyle(color: Colors.grey),
          hintText: hint2,
          prefixIcon: Icon(iconData2)),
    );
  }


  static PreferredSize AppBarCustom(
      {required bool atras, required context, required String title}) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50.0),
      child: AppBar(
        leading: atras == true ? BlocBuilder<n.NavigatorBloc, n.NavigatorState>(
          builder: (context, state) {
            return IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: ()
              {
                if(state is n.StateDetail){
                  BlocProvider.of<n.NavigatorBloc>(context).add(n.GoHome());
                }
                if(state is n.StateCheckout){
                  Navigator.pop(context);
                }
              },
            );
          },
        ) : Container(),
        title: Container(
          child: Text(title),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person_2,
                color: AppColors.primerColor,
              ),
            ),
          )
        ],
        centerTitle: true,
        backgroundColor: AppColors.primerColor,
      ),
    );
  }
}

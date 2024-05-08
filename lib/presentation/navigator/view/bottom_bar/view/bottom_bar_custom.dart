import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapi/presentation/color.dart';
import 'package:storeapi/presentation/navigator/bloc/navigator_bloc.dart' as n;
import 'package:storeapi/presentation/navigator/view/bottom_bar/bloc/botttom_bar_bloc.dart';

class BottomBarCustom extends StatefulWidget {
  const BottomBarCustom({super.key, required this.index});

  final int index;

  @override
  State<BottomBarCustom> createState() => _BottomBarCustomState();
}

class _BottomBarCustomState extends State<BottomBarCustom> {
  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<n.NavigatorBloc>(context);
    return BlocProvider(
      create: (context) => BotttomBarBloc()..add(ObtenerCarritoEvent()),
      child: BlocBuilder<n.NavigatorBloc, n.NavigatorState>(
  builder: (context, state) {
    return BottomNavigationBar(
        currentIndex: widget.index,
        selectedItemColor: Colors.white,
        backgroundColor: AppColors.primerColor,
        onTap: (indexSelect) {
          switch (indexSelect) {
            case 0:
              if(state is n.StateDetail){
                Navigator.of(context).pop();
              }else {
                bloc.add(n.GoHome());
              }

          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Stack(children: [

            const Icon(Icons.shopping_bag),
            BlocBuilder<BotttomBarBloc, BotttomBarState>(
              builder: (context, state) {
                if(state is BotttomBarCarritoSuccess){
                  return Positioned(
                    top: -1,
                    left: 0,
                    right: 0,
                    child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(state.carrito.cantidad.toString(), style: TextStyle(fontSize: 10,color: Colors.white),)),
                  );
                }else{
                  return Positioned(
                    top: -1,
                    left: 0,
                    right: 0,
                    child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text("0", style: TextStyle(fontSize: 10,color: Colors.white),)),
                  );
                }

              },
            ),
          ],), label: 'Mi carrito'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Ajustes'),
        ],
      );
  },
),
    );;
  }
}

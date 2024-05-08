import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapi/presentation/navigator/bloc/navigator_bloc.dart' as b;
import 'package:storeapi/presentation/navigator/view/detail/bloc/detail_bloc.dart';
import 'package:storeapi/presentation/navigator/view/detail/view/detail_page.dart';
import 'package:storeapi/presentation/navigator/view/home/bloc/home_bloc.dart';
import 'package:storeapi/presentation/navigator/view/home/view/home_page.dart';

class NavigationDirectoryPage extends StatefulWidget {
  const NavigationDirectoryPage({super.key});

  @override
  State<NavigationDirectoryPage> createState() =>
      _NavigationDirectoryPageState();
}

class _NavigationDirectoryPageState extends State<NavigationDirectoryPage> {

  @override
  Widget build(BuildContext context) {
    return BlocListener<b.NavigatorBloc, b.NavigatorState>(

      listener: (context, state) {
        if (state is b.StateHome) {
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
              builder: (context) =>  BlocProvider(
                  create: (context) => HomeBloc()
                    ..add(ObtenerProductosEvent()),
                  child: HomePage())),ModalRoute.withName('/'));
        }
        if (state is b.StateDetail) {

          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => DetailBloc()..add(GetCarrito()),
                child: DetailPage(producto: state.producto),
              )
          ));
        }
        if (state is b.StateAjustes) {
          //Navigator.of(context).pushNamed('/settings');
        }
      },
      child: Container(),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapi/presentation/color.dart';
import 'package:storeapi/presentation/navigator/bloc/navigator_bloc.dart';
import 'package:storeapi/presentation/navigator/view/bottom_bar/view/bottom_bar_custom.dart';
import 'package:storeapi/presentation/navigator/view/home/bloc/home_bloc.dart';
import 'package:storeapi/presentation/widgets_app_custom.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is StateHomeError) {
          BlocProvider.of<NavigatorBloc>(context).add(GoError(error: state.error));
        }
      },
      child: Scaffold(
        bottomNavigationBar: const BottomBarCustom(index: 0),
        appBar: WidgetsAppCustom.AppBarCustom(atras: false, context: context,title: "Home"),
        backgroundColor: Colors.white,
        body: SafeArea(child: Container(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (BuildContext context, HomeState state) {
              if (state is StateHomeSuccess) {
                return Container(
                  margin: const EdgeInsets.only(
                      left: 16, right: 16, top: 16, bottom: 16),
                  child: GridView.count(
                    childAspectRatio: (1 / 1.50),
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 10,
                    children: state.productos
                        .map(
                          (e) => GestureDetector(
                            onTap: () async {
                              BlocProvider.of<NavigatorBloc>(context).add(GoDetail(producto: e));
                            },
                            child: Column(
                              children: [
                               Hero(

                                 tag: "hero-${e.id}",
                                 child: CachedNetworkImage(
                                    imageUrl: e.image,
                                    width: 200,
                                    fit: BoxFit.fill,
                                    height: 200,
                                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                                        Container(height: 200,color: Colors.grey.shade300,),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                  ),
                               ),
                                Container(
                                  child: Text( e.title,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis
                                  ),
                                ),
                                Text("\$${e.price.toStringAsFixed(2)}",style: const TextStyle(color: AppColors.primerColor,fontWeight: FontWeight.bold),)
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                );
              }
              return Container();
            },
          ),
        )),
      ),
    );
  }
}

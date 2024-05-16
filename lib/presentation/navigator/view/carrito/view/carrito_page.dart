import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapi/data/model/carrito.dart';
import 'package:storeapi/data/model/producto.dart';
import 'package:storeapi/data/model/productos_carrito.dart';
import 'package:storeapi/presentation/color.dart';
import 'package:storeapi/presentation/navigator/bloc/navigator_bloc.dart';
import 'package:storeapi/presentation/navigator/view/bottom_bar/view/bottom_bar_custom.dart';
import 'package:storeapi/presentation/navigator/view/carrito/bloc/carrito_bloc.dart';
import 'package:storeapi/presentation/widgets_app_custom.dart';

class CarritoPage extends StatefulWidget {
  const CarritoPage({super.key});

  @override
  State<CarritoPage> createState() => _CarritoPageState();
}

class _CarritoPageState extends State<CarritoPage>
    with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomBarCustom(index: 1),
      appBar: WidgetsAppCustom.AppBarCustom(
          atras: false, context: context, title: "Carrito"),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<CarritoBloc, CarritoState>(
          builder: (context, state) {
            if (state is CarritoSuccess) {
              return Container(
                  child: Column(
                children: [
                  Container(
                    color: Colors.grey.shade200,
                    child: DefaultTabController(
                      initialIndex: 0,
                      length: 2,
                      child: TabBar(
                        controller: tabController,
                        indicatorColor: AppColors.primerColor,
                        dividerColor: Colors.grey.shade100,
                        labelColor: AppColors.primerColor,
                        tabs: const [
                          Tab(
                            text: "Orden actual",
                          ),
                          Tab(text: "Historial de ordenes"),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        OrdenActual(state.carrito),
                        OrdenHistorial(state.carrito),
                      ],
                    ),
                  ),
                ],
              ));
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget OrdenActual(Carrito carrito) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          child: Container(
            height: MediaQuery.of(context).size.height - 320,
            color: Colors.white,
            margin: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: carrito.productosCarrito!
                    .map((e) => TarjetasProductos(e))
                    .toList(),
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey.shade200,
            child: carrito.productosCarrito!.isNotEmpty ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Total",
                          style: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 15)),
                      Text("\$${carrito.total!.toStringAsFixed(2)}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30)),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primerColor,
                          elevation: 0,
                        ),
                        onPressed: () {
                          BlocProvider.of<NavigatorBloc>(context).add(GoCheckout(carrito: carrito));
                        },
                        child: Row(
                          children: [
                             Text(
                              "Checkout",
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(Icons.navigate_next,color: Colors.white,)
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ) : Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("No tienes aun productos agregados al carrito"),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget TarjetasProductos(ProductosCarrito pc) {
    var producto = pc.producto!;
    return Container(
      margin: EdgeInsets.only(top: 10,bottom: 10),
      child: Card(
        color: Colors.grey.shade100,
        child: Row(children: [
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
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(producto.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(
                  "\$${pc.suma!.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 13),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {});
            },
            child: Container(
                alignment: Alignment.center,
                height: 30,
                width: 30,
                decoration: const BoxDecoration(
                  color: AppColors.primerColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.remove)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Text(pc.cantidad.toString()),
          ),
          GestureDetector(
            onTap: () {
              setState(() {});
            },
            child: Container(
                alignment: Alignment.center,
                height: 30,
                width: 30,
                decoration: const BoxDecoration(
                  color: AppColors.primerColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add)),
          ),
        ]),
      ),
    );
  }

  Widget OrdenHistorial(Carrito carrito) {
    return Container(
      color: Colors.white,
    );
  }
}

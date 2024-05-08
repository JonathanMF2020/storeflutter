import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapi/data/model/producto.dart';
import 'package:storeapi/data/model/productos_carrito.dart';
import 'package:storeapi/presentation/color.dart';
import 'package:storeapi/presentation/navigator/bloc/navigator_bloc.dart';
import 'package:storeapi/presentation/navigator/view/bottom_bar/view/bottom_bar_custom.dart';
import 'package:storeapi/presentation/navigator/view/detail/bloc/detail_bloc.dart';
import 'package:storeapi/presentation/widgets_app_custom.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.producto});
  final Producto producto;
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int cantidad = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetailBloc, DetailState>(
  listener: (context, state) {
    if(state is DetailObtenerCarritoSuccess){
      if(state.carrito.productosCarrito!.isNotEmpty){
        var valor = state.carrito.productosCarrito!.firstWhere((element) => element.producto!.id == widget.producto.id, orElse: () => ProductosCarrito(0,widget.producto));
        if(valor != null){
          cantidad = valor.cantidad;
        }
      }

    }
  },
  builder: (context, state) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const BottomBarCustom(index: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [

                    Center(
                      child: Hero(
                        tag: "hero-${widget.producto.id}",
                        child: CachedNetworkImage(
                          imageUrl: widget.producto.image,
                          fit: BoxFit.fill,
                          height: MediaQuery.of(context).size.height/2,
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              Container(height: 200,color: Colors.grey.shade300,),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: IconButton(onPressed: (){
                        Navigator.of(context);

                      }, icon: Icon(Icons.arrow_back, color: Colors.black,size: 30,),),
                    ),
                  ],
                ),
                Text("${widget.producto.title}",textAlign: TextAlign.start,style: const TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("\$${widget.producto.price}",textAlign: TextAlign.start,style: const TextStyle(fontSize: 17,color: AppColors.primerColor,fontWeight: FontWeight.bold)),
                              Text("(${widget.producto.rating!.count} c)",textAlign: TextAlign.start,style: const TextStyle(fontSize: 12,color: AppColors.primerColor)),
                            ],
                          ),
                          starManager(widget.producto.rating!.rate!),

                        ],
                      ),
                    ),
                    Container(

                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                if(cantidad >= 1){
                                  cantidad--;
                                  BlocProvider.of<DetailBloc>(context).add(SalvarCarritoEvent(cantidad: cantidad,producto: widget.producto));
                                }
                              });
                            },
                            child: Container(
                                height: 30,
                                width: 30,
                                decoration: const BoxDecoration(
                                  color: AppColors.primerColor,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.remove)),
                          ),
                          Padding(padding: const EdgeInsets.only(left: 8,right: 8),child: Text("$cantidad"),),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                cantidad++;
                                BlocProvider.of<DetailBloc>(context).add(SalvarCarritoEvent(cantidad: cantidad,producto: widget.producto));
                              });
                            },
                            child: Container(
                                height: 30,
                                width: 30,
                                decoration: const BoxDecoration(
                                  color: AppColors.primerColor,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.add)),
                          )

                        ],
                      ),
                    )
                  ],
                ),

                Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: const Text("Descripcion",textAlign: TextAlign.start,style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.w900))),
                Text("${widget.producto.description} ",textAlign: TextAlign.start,style: const TextStyle(fontSize: 13,color: Colors.black,fontWeight: FontWeight.w500))
              ],
            ),
          ),
        ),
      ),
    );
  },
);
  }

  Widget starManager(double rating) {
    if (rating == 5) {
      return const Row(
        children: [
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star, color: Colors.yellow),
        ],
      );
    }
    else if (rating >= 4.5) {
      return const Row(
        children: [
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star_half, color: Colors.yellow),
        ],
      );
    }
    else if (rating >= 4) {
      return const Row(
        children: [
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star_border, color: Colors.yellow,),
        ],
      );
    }
    else if (rating >= 3.5) {
      return const Row(
        children: [
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star_half, color: Colors.yellow),
          Icon(Icons.star_border, color: Colors.yellow,),
        ],
      );
    }
    else if (rating >= 3) {
      return const Row(
        children: [
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star_border, color: Colors.yellow,),
          Icon(Icons.star_border, color: Colors.yellow,),
        ],
      );
    }
    else if (rating >= 2.5) {
      return const Row(
        children: [
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star_half, color: Colors.yellow),
          Icon(Icons.star_border, color: Colors.yellow,),
          Icon(Icons.star_border, color: Colors.yellow,),
        ],
      );
    }
    else if (rating >= 2) {
      return const Row(
        children: [
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star_border, color: Colors.yellow,),
          Icon(Icons.star_border, color: Colors.yellow,),
          Icon(Icons.star_border, color: Colors.yellow,),
        ],
      );
    }
    else if (rating >= 1.5) {
      return const Row(
        children: [
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star_half, color: Colors.yellow),
          Icon(Icons.star_border, color: Colors.yellow,),
          Icon(Icons.star_border, color: Colors.yellow,),
          Icon(Icons.star_border, color: Colors.yellow,),
        ],
      );
    }
    else if (rating >= 1) {
      return const Row(
        children: [
          Icon(Icons.star, color: Colors.yellow),
          Icon(Icons.star_border),
          Icon(Icons.star_border),
          Icon(Icons.star_border),
          Icon(Icons.star_border),
        ],
      );
    }
    else if (rating >= 0.5) {
      return const Row(
        children: [
          Icon(Icons.star_half, color: Colors.yellow),
          Icon(Icons.star_border),
          Icon(Icons.star_border),
          Icon(Icons.star_border),
          Icon(Icons.star_border),
        ],
      );
    }else{
      return const Row(
        children: [
          Icon(Icons.star_border),
          Icon(Icons.star_border),
          Icon(Icons.star_border),
          Icon(Icons.star_border),
          Icon(Icons.star_border),
        ],
      );
    }
  }
}

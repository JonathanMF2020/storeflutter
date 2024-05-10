
import 'package:storeapi/data/model/rating.dart';


class Producto {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final Rating? rating;


  Producto.fromJson(Map<String, dynamic> json) :
    id = json['id'],
    title = json['title'],
    price = double.parse(json['price'].toString()),
    description = json['description'],
    category = json['category'],
    image = json['image'],
    rating = json['rating'] == null ? null : Rating.fromJson(json['rating']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'price': price,
    'description': description,
    'category': category,
    'image': image,
    'rating': rating != null ? rating!.toJson() : null
  };

}

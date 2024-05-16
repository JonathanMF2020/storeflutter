class ProductoResponse{
  int? productId;
  int? quantity;

  ProductoResponse();

  ProductoResponse.fromJson(Map<String, dynamic> json)
      : productId = json['productId'],
        quantity = json['quantity'];

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'quantity': quantity,
  };
}
import 'dart:convert';

class ProductModel {
  String name;
  double? price;
  int? quantity;
  String code;

  ProductModel({
    required this.name,
    this.price,
    this.quantity,
    required this.code,
  });

  Map<String, dynamic> toMap() {
    return {'name': name, 'price': price, 'quantity': quantity, 'code': code};
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
        name: map['name'],
        price: map['price'],
        quantity: map['quantity'],
        code: map['code']);
  }

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));
}

import 'dart:convert';

import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class ProductModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  double? price;
  @HiveField(2)
  int? quantity;
  @HiveField(3)
  int code;
  @HiveField(4)
  DateTime createdAt;
  @HiveField(5)
  DateTime updatedAt;
  @HiveField(6)
  String? image;

  ProductModel({
    required this.name,
    this.price,
    this.quantity,
    required this.code,
    required this.createdAt,
    required this.updatedAt,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'quantity': quantity,
      'code': code,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'image': image
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'],
      price: map['price'],
      quantity: map['quantity'],
      code: map['code'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      image: map['image'],
    );
  }

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));
}

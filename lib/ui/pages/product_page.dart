import 'package:crudnex/data/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  final ProductModel productModel;

  const ProductPage({Key? key, required this.productModel}) : super(key: key);
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
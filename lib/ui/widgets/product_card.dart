import 'package:crudnex/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProductCard extends StatelessWidget {
  final ProductModel productModel;

  const ProductCard({Key? key, required this.productModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Modular.to.pushNamed('/product', arguments: productModel);
      },
      child: Container(
        width: 150,
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.hardEdge,
          elevation: 5,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(3.0),
                height: 80,
                width: 130,
                child: Image(
                  //todo: colocar uma imagem padrao
                  image: AssetImage('lib/assets/${productModel.image}'),
                  fit: BoxFit.fill,
                ),
              ),
              Text(
                productModel.name,
                style: TextStyle(fontSize: 12),
              )
            ],
          ),
        ),
      ),
    );
  }
}

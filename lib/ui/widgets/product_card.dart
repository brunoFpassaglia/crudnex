import 'dart:io';

import 'package:crudnex/blocs/product/product_bloc.dart';
import 'package:crudnex/blocs/product/product_events.dart';
import 'package:crudnex/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProductCard extends StatelessWidget {
  final ProductModel productModel;
  final ProductBloc productBloc;

  const ProductCard({
    Key? key,
    required this.productModel,
    required this.productBloc,
  }) : super(key: key);
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
                child: productModel.image != null
                    ? productModel.image!.startsWith('lib')
                        ? Image.asset(productModel.image!)
                        : Image.file(File(productModel.image!))
                    : Image.asset('lib/assets/default.jpeg'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    productModel.name,
                    style: TextStyle(fontSize: 12),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      productBloc.add(DeleteProduct(productModel));
                    },
                    color: Theme.of(context).errorColor,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

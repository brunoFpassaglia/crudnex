import 'package:crudnex/data/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  final ProductModel? productModel;

  const ProductPage({Key? key, required this.productModel}) : super(key: key);
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late TextEditingController priceController;
  late TextEditingController nameController;
  late TextEditingController quantityController;
  @override
  void initState() {
    super.initState();
    priceController =
        TextEditingController(text: widget.productModel?.price.toString());
    nameController =
        TextEditingController(text: widget.productModel?.name.toString());
    quantityController =
        TextEditingController(text: widget.productModel?.quantity.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productModel == null
            ? "Novo Produto"
            : widget.productModel!.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                height: 150,
                width: 150,
                child: Image(
                  //todo: colocar uma imagem padrao
                  image: widget.productModel?.image == null
                      ? AssetImage('lib/assets/default.jpeg')
                      : AssetImage('lib/assets/${widget.productModel?.image}'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Form(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    initialValue: widget.productModel?.name,
                    validator: (value) {
                      if (value == null ||
                          value.trim() == '' ||
                          value.length < 3) {
                        return "Nome invalido";
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Nome",
                      labelStyle: TextStyle(fontSize: 24),
                    ),
                  ),
                  TextFormField(
                      initialValue: widget.productModel?.price.toString(),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if ((value as int) < 0) {
                          return "Preço inválido";
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Preço",
                        labelStyle: TextStyle(fontSize: 24),
                      )),
                  TextFormField(
                      initialValue: widget.productModel?.quantity.toString(),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Quantidade em Estoque",
                        labelStyle: TextStyle(fontSize: 24),
                      )),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

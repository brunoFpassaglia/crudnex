import 'dart:io';

import 'package:crudnex/blocs/product/product_bloc.dart';
import 'package:crudnex/blocs/product/product_events.dart';
import 'package:crudnex/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';

class ProductPage extends StatefulWidget {
  final ProductModel? productModel;

  const ProductPage({Key? key, required this.productModel}) : super(key: key);
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  ProductBloc productBloc = Modular.get<ProductBloc>();
  late TextEditingController priceController;
  late TextEditingController nameController;
  late TextEditingController codeController;
  late TextEditingController quantityController;
  String? _productImage;
  final _formKey = GlobalKey<FormState>();
  bool _btnEnabled = false;
  @override
  void initState() {
    super.initState();
    codeController =
        TextEditingController(text: widget.productModel?.code.toString());
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
            Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              onChanged: () => setState(
                  () => _btnEnabled = _formKey.currentState!.validate()),
              child: Column(
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        await ImagePicker()
                            .getImage(source: ImageSource.gallery)
                            .then((value) {
                          if (value == null) return;
                          setState(() {
                            _productImage = value.path;
                          });
                        });
                      },
                      child: Container(
                        height: 150,
                        width: 150,
                        child: _productImage == null
                            ? widget.productModel?.image == null
                                ? Image.asset('lib/assets/default.jpeg')
                                : Image.asset(widget.productModel!.image!)
                            : Image.file(File(_productImage!)),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: nameController,
                    validator: _nameValidator,
                    decoration: InputDecoration(
                      labelText: "Nome",
                      labelStyle: TextStyle(fontSize: 24),
                    ),
                  ),
                  TextFormField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    validator: _priceValidator,
                    decoration: InputDecoration(
                      labelText: "Preço",
                      labelStyle: TextStyle(fontSize: 24),
                    ),
                  ),
                  TextFormField(
                    controller: codeController,
                    keyboardType: TextInputType.number,
                    validator: _codeValidator,
                    decoration: InputDecoration(
                      labelText: "Código",
                      labelStyle: TextStyle(fontSize: 24),
                    ),
                  ),
                  TextFormField(
                    controller: quantityController,
                    validator: _quantityValidator,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Quantidade em Estoque",
                      labelStyle: TextStyle(fontSize: 24),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _btnEnabled
                              ? () {
                                  //add new insert event to block and goes back
                                  productBloc.add(
                                    InserOrUpdateProduct(
                                      productModel: ProductModel(
                                        name: nameController.text,
                                        price:
                                            double.parse(priceController.text),
                                        quantity:
                                            int.parse(quantityController.text),
                                        code: int.parse(codeController.text),
                                        image: _productImage,
                                        updatedAt: DateTime.now(),
                                      ),
                                    ),
                                  );
                                  Modular.to.pop();
                                }
                              : null,
                          child: Text(
                            "Salvar",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.disabled))
                                  return Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.3);
                                return Theme.of(context).colorScheme.primary;
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: widget.productModel != null
                        ? Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text("Deletar"),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Theme.of(context).errorColor),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : null,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _priceValidator(value) {
    final isDigitsOnly = double.tryParse(value!);
    return isDigitsOnly == null ? "Preço inválido" : null;
  }

  String? _codeValidator(value) {
    final isDigitsOnly = int.tryParse(value!);
    return isDigitsOnly == null ? "Código inválido" : null;
  }

  String? _quantityValidator(value) {
    final isDigitsOnly = int.tryParse(value!);
    return isDigitsOnly == null ? "Código inválido" : null;
  }

  String? _nameValidator(value) {
    if (value == null || value.trim() == '' || value.length < 3) {
      return "Nome invalido";
    }
  }
}

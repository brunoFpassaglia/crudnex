import 'package:crudnex/data/models/product_model.dart';
import 'package:crudnex/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProductModel> products = [];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Pagina inicial"),
        ),
        body: Column(
          children: [
            TabBar(
              tabs: [
                Container(
                    child: Icon(
                  Icons.list_alt,
                  size: 40,
                )),
                Container(
                    child: Icon(
                  Icons.grid_on,
                  size: 40,
                ))
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  BlocProvider(create: create),
                  Text("grid"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

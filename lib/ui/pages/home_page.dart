import 'package:crudnex/blocs/auth/auth_bloc.dart';
import 'package:crudnex/blocs/auth/auth_events.dart';
import 'package:crudnex/blocs/product/product_bloc.dart';
import 'package:crudnex/blocs/product/product_events.dart';
import 'package:crudnex/blocs/product/product_state.dart';
import 'package:crudnex/ui/widgets/custom_error_widget.dart';
import 'package:crudnex/ui/widgets/loading_widget.dart';
import 'package:crudnex/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProductBloc productBloc = Modular.get<ProductBloc>();
  var _orderBy;

  int _orderByAlphabetical(a, b) {
    return a.name.compareTo(b.name);
  }

  int _orderByPrice(a, b) {
    return a.price.compareTo(b.price);
  }

  int _orderByUpdateAt(a, b) {
    return a.updatedAt.compareTo(b.updatedAt);
  }

  // products are loaded alphabetically by default
  @override
  void initState() {
    super.initState();
    productBloc.add(FetchProduct());
    _orderBy = _orderByAlphabetical;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pagina inicial"),
        actions: [
          Container(
              margin: EdgeInsets.all(4),
              child: IconButton(
                icon: Icon(Icons.sort_by_alpha),
                onPressed: () {
                  setState(() {
                    _orderBy = _orderByAlphabetical;
                  });
                },
              )),
          Container(
              margin: EdgeInsets.all(4),
              child: IconButton(
                icon: Icon(Icons.monetization_on_rounded),
                onPressed: () {
                  setState(() {
                    _orderBy = _orderByPrice;
                  });
                },
              )),
          Container(
            margin: EdgeInsets.all(4),
            child: IconButton(
              icon: Icon(Icons.access_time),
              onPressed: () {
                setState(() {
                  _orderBy = _orderByUpdateAt;
                });
              },
            ),
          ),
          Container(
            child: IconButton(
              icon: Icon(
                Icons.logout,
                color: Theme.of(context).errorColor,
              ),
              onPressed: () {
                Modular.get<AuthBloc>().add(LoggedOut());
              },
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocProvider<ProductBloc>.value(
              value: productBloc,
              // depending on the product_bloc state, can be rendered the grid,
              // a msg when there are no products, or an error widget
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductSuccess) {
                    state.products.sort(_orderBy);
                    return GridView.count(
                      crossAxisCount: 2,
                      children: state.products
                          .map((product) => Center(
                                  child: ProductCard(
                                productModel: product,
                                productBloc: productBloc,
                              )))
                          .toList(),
                    );
                  }
                  if (state is ProductEmpty) {
                    return Center(
                      child: Container(
                        child: Text("N??o existem produtos salvos"),
                      ),
                    );
                  }
                  if (state is ProductFailure) {
                    return CustomErrorWidget();
                  }
                  return LoadingWidget();
                },
              ),
            ),
          ),
        ],
      ),
      // navigates to product page to add a new product
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Modular.to.pushNamed('/product', arguments: null);
          },
          child: Icon(
            Icons.add,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          backgroundColor: Theme.of(context).primaryColor),
    );
  }
}

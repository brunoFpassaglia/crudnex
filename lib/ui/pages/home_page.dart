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

  @override
  void initState() {
    super.initState();
    productBloc.add(FetchProduct());
    _orderBy = _orderByAlphabetical;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
                  BlocProvider<ProductBloc>.value(
                    value: productBloc,
                    child: BlocBuilder<ProductBloc, ProductState>(
                      builder: (context, state) {
                        if (state is ProductSuccess) {
                          state.products.sort(_orderBy);
                          return ListView(
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
                              child: Text("Não existem produtos salvos"),
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
                  Text("grid"),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Modular.to.pushNamed('/product', arguments: null);
            },
            child: Icon(
              Icons.add,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            backgroundColor: Theme.of(context).primaryColor),
      ),
    );
  }
}

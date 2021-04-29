import 'package:crudnex/blocs/auth/auth_bloc.dart';
import 'package:crudnex/blocs/auth/auth_states.dart';
import 'package:crudnex/blocs/login/login_bloc.dart';
import 'package:crudnex/blocs/product/product_bloc.dart';
import 'package:crudnex/data/idata_source.dart';
import 'package:crudnex/data/local_data_source.dart';
import 'package:crudnex/data/repositories/product_repository.dart';
import 'package:crudnex/services/login_service.dart';
import 'package:crudnex/ui/pages/home_page.dart';
import 'package:crudnex/ui/pages/login_page.dart';
import 'package:crudnex/ui/pages/product_page.dart';
import 'package:crudnex/ui/pages/splash_page.dart';
import 'package:crudnex/ui/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind<AuthBloc>((_) => AuthBloc()),
    Bind<LoginBloc>((_) => LoginBloc()),
    Bind<ProductBloc>((_) => ProductBloc()),
    Bind<LoginService>((_) => LoginService()),
    Bind<IDataSource>((_) => LocalDataSource()),
    Bind<ProductRepository>((_) => ProductRepository()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, __) => BlocProvider<AuthBloc>.value(
        value: Modular.get<AuthBloc>(),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthUninitialized) {
              return SplashPage();
            }
            if (state is AuthAuthenticated) {
              return HomePage();
            }
            if (state is AuthUnauthenticated) {
              return LoginPage();
            }
            if (state is AuthLoading) {
              return Center(child: LoadingWidget());
            }
            return SplashPage();
          },
        ),
      ),
    ),
    ChildRoute('/login', child: (_, __) => LoginPage()),
    ChildRoute('/product',
        child: (_, args) => ProductPage(productModel: args.data))
  ];
}

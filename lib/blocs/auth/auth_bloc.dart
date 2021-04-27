import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:crudnex/data/models/product_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:crudnex/constants/constants.dart';
import 'package:crudnex/services/login_service.dart';
import 'package:crudnex/blocs/auth/auth_events.dart';
import 'package:crudnex/blocs/auth/auth_states.dart';
import 'package:flutter/services.dart' show rootBundle;

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginService loginService = Modular.get<LoginService>();
  AuthBloc() : super(AuthUninitialized());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStarted) {
      yield AuthUninitialized();
      await Hive.openBox(AUTH_BOX);
      await Hive.openBox(DATA_BOX);
      Iterable objs =
          json.decode(await rootBundle.loadString('lib/assets/db_seeder.json'));
      List<ProductModel> products =
          List<ProductModel>.from(objs.map((e) => ProductModel.fromMap(e)));
      Hive.box(DATA_BOX).put('products', objs);
      // products.forEach((element) {
      // // path:"/data/user/0/com.example.crudnex/app_flutter/data.hive"
      // Hive.box(DATA_BOX).put(element.code, element);
      // });
      // if (loginService.hasToken()) {
      yield AuthAuthenticated();
      // } else {
      // yield AuthUnauthenticated();
      // }
    }
    if (event is LoggedIn) {
      Iterable objs = json.decode('lib/data/db_seeder.json');
      List<ProductModel> products =
          List<ProductModel>.from(objs.map((e) => ProductModel.fromJson(e)));
      products.forEach((element) {
        Hive.box(DATA_BOX).put(element.code, element);
      });
      yield AuthAuthenticated();
    }
    if (event is LoggedOut) {
      yield AuthLoading();
      await loginService.deleteToken();
      yield AuthUnauthenticated();
    }
  }
}

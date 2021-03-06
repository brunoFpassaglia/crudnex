import 'package:bloc/bloc.dart';
import 'package:crudnex/data/DbSeeder.dart';
import 'package:crudnex/data/models/product_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:crudnex/constants/constants.dart';
import 'package:crudnex/services/login_service.dart';
import 'package:crudnex/blocs/auth/auth_events.dart';
import 'package:crudnex/blocs/auth/auth_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginService loginService = Modular.get<LoginService>();
  final seeder = DbSeeder();
  AuthBloc() : super(AuthUninitialized());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStarted) {
      await Hive.openBox(AUTH_BOX);
      Hive.registerAdapter(ProductModelAdapter());
      await Hive.openBox(DATA_BOX);
      await Future.delayed(Duration(seconds: 3));
      if (loginService.hasToken()) {
        yield AuthAuthenticated();
      } else {
        yield AuthUnauthenticated();
      }
    }
    if (event is LoggedIn) {
      await seeder.seedProducts();
      yield AuthAuthenticated();
    }
    if (event is LoggedOut) {
      yield AuthLoading();
      await loginService.deleteToken();
      await seeder.deleteData();
      yield AuthUnauthenticated();
    }
  }
}

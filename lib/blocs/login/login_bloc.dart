import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:crudnex/blocs/auth/auth_bloc.dart';
import 'package:crudnex/blocs/auth/auth_events.dart';
import 'package:crudnex/blocs/login/login_events.dart';
import 'package:crudnex/blocs/login/login_states.dart';
import 'package:crudnex/services/login_service.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginService loginService = Modular.get<LoginService>();
  final AuthBloc authBloc = Modular.get<AuthBloc>();

  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();
      try {
        var token = await loginService.login(
          email: event.email,
          password: event.password,
        );
        await loginService.persistToken(token: token);
        yield LoginSuccess();
        authBloc.add(LoggedIn());
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}

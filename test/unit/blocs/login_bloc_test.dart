import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:crudnex/app_module.dart';
import 'package:crudnex/blocs/login/login_bloc.dart';
import 'package:crudnex/blocs/login/login_events.dart';
import 'package:crudnex/blocs/login/login_states.dart';
import 'package:crudnex/services/login_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import 'auth_bloc_test.mocks.dart';

import 'package:mockito/mockito.dart';

void main() {
  final loginServiceMock = MockLoginService();

  Hive.init(Directory.current.path + '/test/hive_testing_dir');
  setUp(() {
    initModule(AppModule(),
        replaceBinds: [
          Bind.instance<LoginService>(loginServiceMock),
        ],
        initialModule: true);
  });

  tearDownAll(() {
    Hive.deleteFromDisk();
  });

  group(
    'Should yield LoginSuccess state ',
    () {
      blocTest<LoginBloc, LoginState>(
        'when receives a token from api',
        build: () {
          when(loginServiceMock.login(
                  email: 'algum email', password: 'algumasenha'))
              .thenAnswer((_) async => 'token');
          when(loginServiceMock.persistToken()).thenAnswer((_) async => null);
          return LoginBloc();
        },
        act: (loginBloc) => loginBloc.add(
            LoginButtonPressed(email: 'algum email', password: 'algumasenha')),
        expect: () => [LoginLoading(), LoginSuccess()],
      );
    },
  );

  group('Should yield LoginError ', () {
    blocTest<LoginBloc, LoginState>(
      'when an exceptioon occur during login post',
      build: () {
        var error = Exception('some exception');
        when(loginServiceMock.login(
                email: 'algum email', password: 'algumasenha'))
            .thenThrow(error);
        return LoginBloc();
      },
      act: (loginBloc) => loginBloc.add(
        LoginButtonPressed(email: 'algum email', password: 'algumasenha'),
      ),
      expect: () => [
        LoginLoading(),
        LoginFailure(error: 'Exception: some exception'),
      ],
    );
  });
}

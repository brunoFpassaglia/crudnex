import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:crudnex/app_module.dart';
import 'package:crudnex/blocs/auth/auth_bloc.dart';
import 'package:crudnex/blocs/auth/auth_events.dart';
import 'package:crudnex/blocs/auth/auth_states.dart';
import 'package:crudnex/constants/constants.dart';
import 'package:crudnex/data/DbSeeder.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:hive/hive.dart';

import 'package:crudnex/services/login_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_bloc_test.mocks.dart';

@GenerateMocks([LoginService, DbSeeder])
void main() {
  final mock = MockLoginService();
  final seed = MockDbSeeder();

  Hive.init(Directory.current.path + '/test/hive_testing_dir');
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    Hive.openBox(AUTH_BOX);
    Hive.openBox(DATA_BOX);
    initModule(AppModule(),
        replaceBinds: [
          Bind.instance<LoginService>(mock),
        ],
        initialModule: true);
  });

  tearDownAll(() {
    Hive.deleteFromDisk();
  });

  group('Should yield authenticated', () {
    blocTest<AuthBloc, AuthState>('when login is valid',
        build: () {
          when(mock.hasToken()).thenReturn(true);
          return AuthBloc();
        },
        act: (bloc) => bloc.add(AppStarted()),
        expect: () => [
              AuthAuthenticated(),
            ]);

    blocTest<AuthBloc, AuthState>(
      'when LoggedIn event is dispatched',
      build: () {
        when(seed.seedProducts()).thenAnswer((_) async => null);
        return AuthBloc();
      },
      act: (bloc) => bloc.add(LoggedIn()),
      expect: () => [AuthAuthenticated()],
    );
  });

  group('Should yield unauthenticated', () {
    blocTest<AuthBloc, AuthState>(
      'When loged out event is dispatched',
      build: () {
        when(mock.deleteToken()).thenAnswer((_) async => null);
        when(seed.deleteData()).thenAnswer((_) async => null);
        return AuthBloc();
      },
      act: (bloc) => bloc.add(LoggedOut()),
      expect: () => [
        AuthLoading(),
        AuthUnauthenticated(),
      ],
    );
  });
}

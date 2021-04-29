import 'package:crudnex/data/idata_source.dart';
import 'package:crudnex/services/login_exception.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:crudnex/constants/constants.dart';

class LoginService {
  final IDataSource dataSource = Modular.get<IDataSource>();
  Future<String> login(
      {required String email, required String password}) async {
    if (email == DEFAULT_EMAIL && password == DEFAULT_PASSWORD) {
      return 'OfxkmdS2ivRWqFtM7iI7dyRvMFrvMUuyYmRSg0U5';
    } else {
      throw LoginException('Credenciais inválidas');
    }
  }

  Future<void> deleteToken() async {
    await dataSource.delete(endpoint: AUTH_BOX, key: JWT_TOKEN);
  }

  Future<void> persistToken({required String token}) async {
    await dataSource.post(endpoint: AUTH_BOX, data: {JWT_TOKEN: token});
  }

  bool hasToken() => Hive.box(AUTH_BOX).containsKey(JWT_TOKEN);
}

import 'package:crudnex/services/login_exception.dart';
import 'package:hive/hive.dart';
import 'package:crudnex/constants/constants.dart';

class LoginService {
  Future<String> login(
      {required String email, required String password}) async {
    if (email == DEFAULT_EMAIL && password == DEFAULT_PASSWORD) {
      return 'OfxkmdS2ivRWqFtM7iI7dyRvMFrvMUuyYmRSg0U5';
    } else {
      throw LoginException('Credenciais inválidas');
    }
  }

  Future<void> deleteToken() async {
    await Hive.box(AUTH_BOX).delete(JWT_TOKEN);
  }

  Future<void> persistToken({required String token}) async {
    await Hive.box(AUTH_BOX).put(JWT_TOKEN, token);
  }

  bool hasToken() => Hive.box(AUTH_BOX).containsKey(JWT_TOKEN);
}

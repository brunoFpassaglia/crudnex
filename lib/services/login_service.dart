import 'package:hive/hive.dart';
import 'package:crudnex/constants/constants.dart';

class LoginService {
  Future<String> login(
      {required String email, required String password}) async {
    return 'Hello';
  }

  //todo: deletes token from local storage and revogates it at the api
  Future<void> deleteToken() async {
    await Hive.box(AUTH_BOX).delete(JWT_TOKEN);
  }

  //todo: saves a token to local storage
  Future<void> persistToken({required String token}) async {
    await Hive.box(AUTH_BOX).put(JWT_TOKEN, token);
  }

  bool hasToken() => Hive.box(AUTH_BOX).containsKey(JWT_TOKEN);
}

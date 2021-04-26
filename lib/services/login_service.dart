import 'package:hive/hive.dart';
import 'package:crudnex/constants/auth_api.dart';
import 'package:meagenda/http/dio_client_api.dart';

class LoginService extends DioClientApi {
  Future<String> login(
      {required String email, required String password}) async {
    try {
      var response = await post(
        url: 'login',
        data: {
          "email": email,
          "password": password,
        },
      );
      var token = response["access_token"];
      return token;
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<bool> checkToken() async {
    try {
      var token = await getToken();
      var response = await get(url: 'valid', jwtToken: token);
      return response["valid"];
    } catch (e) {
      return false;
    }
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

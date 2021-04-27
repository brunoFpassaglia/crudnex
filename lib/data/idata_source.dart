abstract class IDataSource {
  Future<dynamic> get({required String endpoint, String? jwtToken});
  Future<dynamic> post({required String endpoint, String? jwtToken});
  Future<dynamic> put({required String endpoint, String? jwtToken});
  Future<dynamic> delete({required String endpoint, String? jwtToken});
}

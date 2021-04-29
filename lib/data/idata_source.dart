abstract class IDataSource {
  Future<dynamic> get({
    required String endpoint,
    String? key,
  });

  Future<dynamic> post({
    required String endpoint,
    required Map<String, dynamic> data,
  });

  Future<dynamic> put({
    required String endpoint,
    required Map<String, dynamic> data,
  });

  Future<void> delete({
    required String endpoint,
    required int key,
  });
}

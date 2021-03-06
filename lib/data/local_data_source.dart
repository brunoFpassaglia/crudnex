import 'package:crudnex/data/models/product_model.dart';
import 'package:crudnex/data/idata_source.dart';
import 'package:hive/hive.dart';

class LocalDataSource implements IDataSource {
  @override
  Future<void> delete({
    required String endpoint,
    required int key,
  }) async {
    await Hive.box(endpoint).delete(key);
  }

  @override
  Future get({
    required String endpoint,
    int? key,
  }) async {
    return Hive.box(endpoint).values;
  }

  @override
  Future post({
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    await Hive.box(endpoint).put(data.keys.first, data.values.first);
  }

  @override
  Future put({
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    await Hive.box(endpoint).put(data['code'], ProductModel.fromMap(data));
  }
}

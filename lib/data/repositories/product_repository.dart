import 'package:crudnex/constants/constants.dart';
import 'package:crudnex/data/idata_source.dart';
import 'package:crudnex/data/models/product_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProductRepository {
  final IDataSource dataSource = Modular.get<IDataSource>();

  Future<List<ProductModel>> fetchProducts() async {
    try {
      var data = await dataSource.get(endpoint: DATA_BOX);
      // final products = data.map<ProductModel>((product) => product).toList();
      final products = List<ProductModel>.from(data);
      return products;
    } catch (error) {
      rethrow;
    }
  }
}

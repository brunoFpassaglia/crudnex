import 'package:crudnex/data/idata_source.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProductRepository {
  final IDataSource dataSource = Modular.get<IDataSource>();
}

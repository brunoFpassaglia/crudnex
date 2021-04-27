import 'dart:convert';

import 'package:crudnex/constants/constants.dart';
import 'package:crudnex/data/models/product_model.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class DbSeeder {
  Future seedProducts() async {
    Iterable objs =
        json.decode(await rootBundle.loadString('lib/assets/db_seeder.json'));
    List<ProductModel> products =
        List<ProductModel>.from(objs.map((e) => ProductModel.fromMap(e)));

    products.forEach((element) {
      Hive.box(DATA_BOX).put(element.code, element);
    });
  }
}

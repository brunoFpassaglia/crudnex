import 'package:crudnex/data/models/product_model.dart';
import 'package:equatable/equatable.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState {}

class ProductSuccess extends ProductState {
  final List<ProductModel> products;

  ProductSuccess({required this.products});
}

class ProductFailure extends ProductState {}

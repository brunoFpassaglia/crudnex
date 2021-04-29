import 'package:crudnex/data/models/product_model.dart';
import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchProduct extends ProductEvent {}

class GetProduct extends ProductEvent {}

class DeleteProduct extends ProductEvent {
  final ProductModel productModel;

  DeleteProduct(this.productModel);
}

class InserOrUpdateProduct extends ProductEvent {
  final ProductModel productModel;

  InserOrUpdateProduct({required this.productModel});
}

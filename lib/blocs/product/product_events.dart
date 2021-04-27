import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchProduct extends ProductEvent {}

class GetProduct extends ProductEvent {}

class DeleteProduct extends ProductEvent {}

class UpdateProduct extends ProductEvent {}

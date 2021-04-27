import 'package:crudnex/blocs/product/product_events.dart';
import 'package:crudnex/blocs/product/product_state.dart';
import 'package:crudnex/data/models/product_model.dart';
import 'package:crudnex/data/repositories/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository = Modular.get<ProductRepository>();
  ProductBloc() : super(ProductLoading());

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is FetchProduct) {
      yield ProductLoading();
      try {
        List<ProductModel> products = await productRepository.fetchProducts();
        yield ProductSuccess(products: products);
      } catch (error) {
        yield ProductFailure();
      }
    }
    if (event is DeleteProduct) {
      try {
        // faz o delete
      } catch (error) {
        yield ProductFailure();
      } finally {
        this.add(FetchProduct());
      }
    }
    if (event is UpdateProduct) {
      yield ProductLoading();
      try {
        // faz o update
      } catch (error) {
        yield ProductFailure();
      } finally {
        this.add(FetchProduct());
      }
    }
  }
}

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
        if (products.isEmpty) {
          yield ProductEmpty();
        } else {
          yield ProductSuccess(products: products);
        }
      } catch (error) {
        yield ProductFailure();
      }
    }
    if (event is DeleteProduct) {
      try {
        await productRepository.deleteProduct(event.productModel);
      } catch (error) {
        yield ProductFailure();
      } finally {
        this.add(FetchProduct());
      }
    }
    if (event is InserOrUpdateProduct) {
      yield ProductLoading();
      try {
        await productRepository.putProduct(event.productModel);
      } catch (error) {
        yield ProductFailure();
      } finally {
        this.add(FetchProduct());
      }
    }
  }
}

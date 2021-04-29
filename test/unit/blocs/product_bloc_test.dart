import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:crudnex/app_module.dart';
import 'package:crudnex/blocs/product/product_bloc.dart';
import 'package:crudnex/blocs/product/product_events.dart';
import 'package:crudnex/blocs/product/product_state.dart';
import 'package:crudnex/data/models/product_model.dart';
import 'package:crudnex/data/repositories/product_repository.dart';
import 'package:crudnex/services/login_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'product_bloc_test.mocks.dart';

@GenerateMocks([ProductRepository])
void main() {
  final productRepoMock = MockProductRepository();
  Hive.init(Directory.current.path + '/test/hive_testing_dir');
  setUp(() {
    initModule(AppModule(),
        replaceBinds: [
          Bind.instance<ProductRepository>(productRepoMock),
        ],
        initialModule: true);
  });

  tearDownAll(() {
    Hive.deleteFromDisk();
  });

  group('Should yield sucess state', () {
    blocTest<ProductBloc, ProductState>(
      'When there are products in database',
      build: () {
        when(productRepoMock.fetchProducts()).thenAnswer((_) async => [
              ProductModel(
                  name: 'produto',
                  price: 15,
                  quantity: 10,
                  code: 6,
                  updatedAt: DateTime.now()),
            ]);
        return ProductBloc();
      },
      act: (bloc) => bloc.add(FetchProduct()),
      expect: () => [
        isA<ProductLoading>(),
        isA<ProductSuccess>(),
      ],
    );
  });
  group('Should yield empty state', () {
    blocTest<ProductBloc, ProductState>(
      'when there are no products in database',
      build: () {
        when(productRepoMock.fetchProducts()).thenAnswer((_) async => []);
        return ProductBloc();
      },
      act: (bloc) => bloc.add(FetchProduct()),
      expect: () => [
        isA<ProductLoading>(),
        isA<ProductEmpty>(),
      ],
    );
  });
  group('Should yield failure state', () {
    blocTest<ProductBloc, ProductState>(
      'when there is an exception loading the products',
      build: () {
        when(productRepoMock.fetchProducts()).thenThrow(Exception('erro'));
        return ProductBloc();
      },
      act: (bloc) => bloc.add(FetchProduct()),
      expect: () => [
        isA<ProductLoading>(),
        isA<ProductFailure>(),
      ],
    );
  });
}

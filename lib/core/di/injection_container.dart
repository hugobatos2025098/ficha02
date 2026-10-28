import 'package:ficha02/features/products/data/datasources/product_remote_data_source.dart';
import 'package:ficha02/features/products/data/repositories/product_repository_impl.dart';
import 'package:ficha02/features/products/domain/repositories/product_repository.dart';
import 'package:ficha02/features/products/domain/usecases/get_products.dart';
import 'package:ficha02/features/products/presentation/bloc/products_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> setupDependencies() async {
  sl.registerLazySingleton(() => ProductRemoteDataSource());
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => GetProducts(sl()));
  sl.registerFactory(() => ProductsBloc(sl()));
}

import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';

// Implementação concreta do contrato ProductRepository.
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  const ProductRepositoryImpl(this.remoteDataSource);
  @override
  Future<List<Product>> getProducts() => remoteDataSource.getProducts();
}

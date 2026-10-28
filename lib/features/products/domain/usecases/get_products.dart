import '../entities/product.dart';
import '../repositories/product_repository.dart';

// Caso de uso: obter a lista de produtos.
class GetProducts {
  final ProductRepository repository;
  const GetProducts(this.repository);
  Future<List<Product>> call() => repository.getProducts();
}

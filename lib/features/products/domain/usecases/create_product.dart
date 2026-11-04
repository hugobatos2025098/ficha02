import '../entities/product.dart';
import '../repositories/product_repository.dart';

class CreateProduct {
  final ProductRepository repository;
  const CreateProduct(this.repository);

  Future<Product> call({required String name, required double price}) =>
      repository.createProduct(name: name, price: price);
}
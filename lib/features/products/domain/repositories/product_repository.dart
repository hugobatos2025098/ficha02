import '../entities/product.dart';

// Contrato que a camada Data tem de implementar.
// O Domain não sabe, nem quer saber, de onde vêm os produtos.
abstract class ProductRepository {
  Future<List<Product>> getProducts();
}

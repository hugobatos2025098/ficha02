import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/product.dart';

// Fonte de dados remota: a API pública DummyJSON.
// https://dummyjson.com/docs/products
class ProductRemoteDataSource {
  static const _baseUrl = 'https://dummyjson.com/products';

  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode != 200) {
      throw Exception('Falha ao obter produtos (HTTP ${response.statusCode})');
    }

    final body = jsonDecode(response.body);
    if (body is! Map<String, dynamic>) {
      throw const FormatException('Resposta da API inválida');
    }

    final items = body['products'];
    if (items is! List) {
      throw const FormatException('Lista de produtos ausente na resposta');
    }

    return items.map((item) {
      final json = item as Map<String, dynamic>;
      return Product(
        id: json['id'].toString(),
        name: json['title'] as String,
        price: (json['price'] as num).toDouble(),
        imageUrl: json['thumbnail'] as String?,
      );
    }).toList();
  }
}

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ficha02/core/error/exceptions.dart';
import '../models/product_model.dart';

// Fonte de dados remota: a tabela products da Supabase.
class ProductRemoteDataSource {
  final SupabaseClient client;
  const ProductRemoteDataSource(this.client);

  Future<List<ProductModel>> getProducts() async {
    try {
      // GET /rest/v1/products?select=*&order=name.asc
      final rows = await client.from('products').select().order('name');
      return rows.map(ProductModel.fromJson).toList();
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    }
  }

  Future<ProductModel> createProduct({
    required String name,
    required double price,
  }) async {
    try {
      // POST /rest/v1/products, com Prefer: return=representation
      final row = await client
          .from('products')
          .insert({'name': name, 'price': price})
          .select()
          .single();
      return ProductModel.fromJson(row);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    }
  }
}

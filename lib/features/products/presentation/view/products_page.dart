import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ficha02/features/products/data/datasources/product_remote_data_source.dart';
import 'package:ficha02/features/products/data/repositories/product_repository_impl.dart';
import 'package:ficha02/features/products/domain/usecases/get_products.dart';
import 'package:ficha02/features/products/presentation/bloc/products_bloc.dart';
import 'package:ficha02/features/products/presentation/bloc/products_event.dart';
import 'package:ficha02/features/products/presentation/view/products_view.dart';
import 'package:ficha02/features/products/domain/usecases/create_product.dart';
class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(  
      create: (_) {
        final client = Supabase.instance.client;
        final dataSource = ProductRemoteDataSource(client);
        final repository = ProductRepositoryImpl(dataSource);
        final getProducts = GetProducts(repository);
        final createProduct = CreateProduct(repository);
        return ProductsBloc(getProducts, createProduct: createProduct)
          ..add(LoadProducts());
      },
      child: const ProductsView(),
    );
  }
  }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ficha02/features/products/presentation/bloc/products_bloc.dart';
import 'package:ficha02/features/products/presentation/bloc/products_event.dart';
import 'package:ficha02/features/products/presentation/bloc/products_state.dart';

// Reage ao estado do ProductsBloc e notifica-o em resposta ao input do
// utilizador.
class ProductsView extends StatelessWidget {
  const ProductsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Produtos')),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          return switch (state) {
            ProductsInitial() || ProductsLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            ProductsError(:final message) => Center(
              child: Text('Erro: $message'),
            ),
            ProductsLoaded(:final products) => RefreshIndicator(
              onRefresh: () async =>
                  context.read<ProductsBloc>().add(RefreshProducts()),
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ListTile(
                    leading: product.imageUrl != null
                        ? Image.network(
                            product.imageUrl!,
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.shopping_bag_outlined),
                          )
                        : const Icon(Icons.shopping_bag_outlined),
                    title: Text(product.name),
                    trailing: Text('\$${product.price}'),
                  );
                },
              ),
            ),
          };
        },
      ),
    );
  }
}

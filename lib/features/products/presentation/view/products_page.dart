import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ficha02/core/di/injection_container.dart';
import 'package:ficha02/features/products/presentation/bloc/products_bloc.dart';
import 'package:ficha02/features/products/presentation/bloc/products_event.dart';
import 'products_view.dart';

// Responsável por obter um ProductsBloc do Service Locator, disparar o
// evento de carregamento inicial, e fornecê-lo ao ProductsView.
class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductsBloc>()..add(LoadProducts()),
      child: const ProductsView(),
    );
  }
}

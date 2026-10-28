import 'package:flutter/material.dart';
import 'package:ficha02/features/products/presentation/view/products_page.dart';
// Um MaterialApp que define a ProductsPage como home.
class ProductsApp extends MaterialApp {
  const ProductsApp({super.key}) : super(home: const ProductsPage());
}
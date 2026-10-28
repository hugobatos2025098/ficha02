import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:ficha02/app.dart';
import 'package:ficha02/counter_observer.dart';
import 'package:ficha02/core/di/injection_container.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  Bloc.observer = const CounterObserver();
  runApp(const ProductsApp());
}
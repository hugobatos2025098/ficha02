import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ficha02/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Lê o ficheiro .env
  await dotenv.load(fileName: '.env');

  // 2. Liga a app ao projeto Supabase
  await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL'),
    publishableKey: dotenv.get('SUPABASE_PUBLISHABLE_KEY'),
  );

  runApp(const ProductsApp());
}
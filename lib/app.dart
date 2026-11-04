import 'package:ficha02/features/products/presentation/view/products_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ficha02/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:ficha02/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ficha02/features/auth/domain/usecases/sign_in.dart';
import 'package:ficha02/features/auth/domain/usecases/sign_up.dart';
import 'package:ficha02/features/auth/domain/usecases/watch_auth_state.dart';
import 'package:ficha02/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ficha02/features/auth/presentation/bloc/auth_event.dart';
import 'package:ficha02/features/auth/presentation/view/auth_gate.dart';

class ProductsApp extends StatelessWidget {
  const ProductsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final client = Supabase.instance.client;
        final dataSource = AuthRemoteDataSource(client);
        final repository = AuthRepositoryImpl(dataSource);
        return AuthBloc(
          watchAuthState: WatchAuthState(repository),
          signIn: SignIn(repository),
          signUp: SignUp(repository),
        )..add(AuthSubscriptionRequested());
      },
      child: const MaterialApp(home: AuthGate()),
    );
  }
}
// Um MaterialApp que define a ProductsPage como home.
class ProductsApp extends MaterialApp {
  const ProductsApp({super.key}) : super(home: const ProductsPage());
}
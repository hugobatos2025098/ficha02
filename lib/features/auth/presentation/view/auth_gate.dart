import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ficha02/features/products/presentation/products.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
import 'login_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) => switch (state) {
        AuthInitial() =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
        Authenticated() => const ProductsPage(),
        Unauthenticated() || AuthLoading() || AuthError() => const LoginPage(),
      },
    );
  }
}
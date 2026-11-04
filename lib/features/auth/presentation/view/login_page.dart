import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _nome = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _isRegister = false;

  @override
  void dispose() {
    _nome.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    final bloc = context.read<AuthBloc>();
    if (_isRegister) {
      bloc.add(AuthSignUpRequested(
        nome: _nome.text.trim(),
        email: _email.text.trim(),
        password: _password.text,
      ));
    } else {
      bloc.add(AuthLoginRequested(
        email: _email.text.trim(),
        password: _password.text,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isRegister ? 'Criar conta' : 'Entrar')),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final loading = state is AuthLoading;
          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              if (_isRegister)
                TextField(
                  controller: _nome,
                  decoration: const InputDecoration(labelText: 'Nome'),
                ),
              TextField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _password,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: loading ? null : _submit,
                child: loading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(_isRegister ? 'Registar' : 'Entrar'),
              ),
              TextButton(
                onPressed: loading
                    ? null
                    : () => setState(() => _isRegister = !_isRegister),
                child: Text(_isRegister
                    ? 'Já tenho conta: entrar'
                    : 'Não tenho conta: registar'),
              ),
            ],
          );
        },
      ),
    );
  }
}
sealed class AuthEvent {}

// Pede para começar a acompanhar a sessão (enviado ao arrancar a app).
class AuthSubscriptionRequested extends AuthEvent {}

// Pede para entrar com uma conta existente.
class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;
  AuthLoginRequested({required this.email, required this.password});
}

// Pede para criar uma conta nova (e o respetivo perfil).
class AuthSignUpRequested extends AuthEvent {
  final String nome;
  final String email;
  final String password;
  AuthSignUpRequested({
    required this.nome,
    required this.email,
    required this.password,
  });
}
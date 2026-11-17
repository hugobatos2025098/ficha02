import '../repositories/auth_repository.dart';

class SignIn {
  final AuthRepository repository;
  const SignIn(this.repository);

  Future<void> call({
    required String email,
    required String password,
  }) =>
      repository.signIn(email: email, password: password);
}

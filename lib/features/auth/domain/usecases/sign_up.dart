import '../repositories/auth_repository.dart';

class SignUp {
  final AuthRepository repository;
  const SignUp(this.repository);

  Future<void> call({
    required String nome,
    required String email,
    required String password,
  }) async {
    // 1. Criar a conta no Supabase Auth
    final user = await repository.signUp(email: email, password: password);

    // 2. Criar o perfil, com o id da conta acabada de criar
    await repository.createProfile(userId: user.id, nome: nome, email: email);
  }
}
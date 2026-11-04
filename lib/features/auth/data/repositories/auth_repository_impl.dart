import 'package:ficha02/features/auth/domain/entities/app_user.dart';

abstract class AuthRepository {
  // Emite o utilizador atual sempre que a sessão muda (null = sem sessão).
  Stream<AppUser?> authStateChanges();

  // Cria a conta no Supabase Auth e devolve o utilizador criado.
  Future<AppUser> signUp({required String email, required String password});

  // Cria a linha do utilizador na tabela profiles.
  Future<void> createProfile({
    required String userId,
    required String nome,
    required String email,
  });

  Future<void> signIn({required String email, required String password});
}
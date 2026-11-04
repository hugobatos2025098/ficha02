import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ficha02/core/error/exceptions.dart';
import '../../domain/entities/app_user.dart';

class AuthRemoteDataSource {
  final SupabaseClient client;
  const AuthRemoteDataSource(this.client);

  Stream<AppUser?> authStateChanges() {
    return client.auth.onAuthStateChange.map((data) {
      final user = data.session?.user;
      if (user == null) return null;
      return AppUser(id: user.id, email: user.email ?? '');
    });
  }

  Future<AppUser> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final response =
          await client.auth.signUp(email: email, password: password);
      final user = response.user;
      if (user == null) {
        throw const ServerException('Não foi possível criar a conta');
      }
      return AppUser(id: user.id, email: user.email ?? email);
    } on AuthException catch (e) {
      throw ServerException(e.message);
    }
  }

  Future<void> createProfile({
    required String userId,
    required String nome,
    required String email,
  }) async {
    try {
      await client
          .from('profiles')
          .insert({'id': userId, 'nome': nome, 'email': email});
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      await client.auth.signInWithPassword(email: email, password: password);
    } on AuthException catch (e) {
      throw ServerException(e.message);
    }
  }
}
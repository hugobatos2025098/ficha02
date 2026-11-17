// import 'package:ficha02/features/auth/domain/entities/app_user.dart';

// abstract class AuthRepository {
//   // Emite o utilizador atual sempre que a sessão muda (null = sem sessão).
//   Stream<AppUser?> authStateChanges();

//   // Cria a conta no Supabase Auth e devolve o utilizador criado.
//   Future<AppUser> signUp({required String email, required String password});

//   // Cria a linha do utilizador na tabela profiles.
//   Future<void> createProfile({
//     required String userId,
//     required String nome,
//     required String email,
//   });

//   Future<void> signIn({required String email, required String password});
// }


import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  const AuthRepositoryImpl(this.remoteDataSource);

  @override
  Stream<AppUser?> authStateChanges() => remoteDataSource.authStateChanges();

  @override
  Future<AppUser> signUp({
    required String email,
    required String password,
  }) =>
      remoteDataSource.signUp(email: email, password: password);

  @override
  Future<void> createProfile({
    required String userId,
    required String nome,
    required String email,
  }) =>
      remoteDataSource.createProfile(
        userId: userId,
        nome: nome,
        email: email,
      );

  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) =>
      remoteDataSource.signIn(email: email, password: password);
}
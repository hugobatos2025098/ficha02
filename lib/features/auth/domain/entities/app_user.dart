import 'package:equatable/equatable.dart';

// O utilizador autenticado, tal como a app o vê.
// Não depende de nenhuma classe da Supabase.
class AppUser extends Equatable {
  final String id;
  final String email;

  const AppUser({required this.id, required this.email});

  @override
  List<Object?> get props => [id, email];
}
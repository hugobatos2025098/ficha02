// Erro vindo de um serviço externo (Supabase, API HTTP...).
// A camada Data lança-o; a Presentation mostra a mensagem.
class ServerException implements Exception {
  final String message;
  const ServerException(this.message);

  @override
  String toString() => message;
}
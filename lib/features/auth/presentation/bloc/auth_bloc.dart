import 'package:bloc/bloc.dart';
import 'package:ficha02/features/auth/domain/entities/app_user.dart';
import 'package:ficha02/features/auth/domain/usecases/sign_in.dart';
import 'package:ficha02/features/auth/domain/usecases/sign_up.dart';
import 'package:ficha02/features/auth/domain/usecases/watch_auth_state.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.watchAuthState,
    required this.signIn,
    required this.signUp,
  }) : super(AuthInitial()) {
    on<AuthSubscriptionRequested>(_onSubscriptionRequested);
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthSignUpRequested>(_onSignUpRequested);
  }

  final WatchAuthState watchAuthState;
  final SignIn signIn;
  final SignUp signUp;

  // A sessão é a fonte de verdade: cada alteração gera um novo estado.
  Future<void> _onSubscriptionRequested(
    AuthSubscriptionRequested event,
    Emitter<AuthState> emit,
  ) {
    return emit.forEach<AppUser?>(
      watchAuthState(),
      onData: (user) => user == null ? Unauthenticated() : Authenticated(user),
    );
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await signIn(email: event.email, password: event.password);
      // Não é preciso emit(Authenticated(...)): o stream trata disso.
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignUpRequested(
    AuthSignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await signUp(
        nome: event.nome,
        email: event.email,
        password: event.password,
      );
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
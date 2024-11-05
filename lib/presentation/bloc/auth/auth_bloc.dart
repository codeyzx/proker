import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proker/domain/repositories/auth_repository.dart';
import 'package:proker/presentation/bloc/auth/auth_event.dart';
import 'package:proker/presentation/bloc/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthInitial()) {
    on<AppLoaded>(_onAppLoaded);
  }

  void _onAppLoaded(AppLoaded event, Emitter<AuthState> emit) async {
    try {} catch (e) {
      emit(const AuthFailure(message: 'Autentikasi gagal'));
    }
  }
}

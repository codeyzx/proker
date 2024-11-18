import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:proker/src/core/usecase/usecase.dart';
import 'package:proker/src/core/utils/failure_converter.dart';
import 'package:proker/src/core/utils/logger.dart';
import 'package:proker/src/features/auth/domain/entities/user_entity.dart';
import 'package:proker/src/features/auth/domain/usecases/check_signin_status_usecase.dart';
import 'package:proker/src/features/auth/domain/usecases/login_usecase.dart';
import 'package:proker/src/features/auth/domain/usecases/logout_usecase.dart';
import 'package:proker/src/features/auth/domain/usecases/register_usecase.dart';
import 'package:proker/src/features/auth/domain/usecases/usecase_params.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final AuthLoginUseCase _loginUseCase;
  final AuthRegisterUseCase _registerUseCase;
  final AuthLogoutUseCase _logoutUseCase;
  final AuthCheckSignInStatusUseCase _checkSignInStatusUseCase;

  AuthCubit(
    this._loginUseCase,
    this._logoutUseCase,
    this._registerUseCase,
    this._checkSignInStatusUseCase,
  ) : super(const AuthState.initial());

  Future<void> login(String email, String password) async {
    emit(const AuthState.loginLoading());

    final result = await _loginUseCase.call(
      LoginParams(
        email: email,
        password: password,
      ),
    );

    result.fold(
      (l) => emit(AuthState.loginFailure(mapFailureToMessage(l))),
      (r) => emit(AuthState.loginSuccess(r)),
    );
  }

  Future<void> logout() async {
    emit(const AuthState.logoutLoading());

    final result = await _logoutUseCase.call(NoParams());

    result.fold(
      (l) => emit(AuthState.logoutFailure(mapFailureToMessage(l))),
      (r) => emit(const AuthState.logoutSuccess("Logout Success")),
    );
  }

  Future<void> register(
      {required String name,
      required String email,
      required String password,
      required String confirmPassword}) async {
    emit(const AuthState.registerLoading());

    final result = await _registerUseCase.call(
      RegisterParams(
        username: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      ),
    );

    result.fold(
      (l) => emit(AuthState.registerFailure(mapFailureToMessage(l))),
      (r) => emit(const AuthState.registerSuccess("Register Success")),
    );
  }

  Future<void> checkSignInStatus() async {
    emit(const AuthState.checkSignInStatusLoading());

    final result = await _checkSignInStatusUseCase.call(NoParams());

    result.fold(
      (l) => emit(AuthState.checkSignInStatusFailure(mapFailureToMessage(l))),
      (r) => emit(AuthState.checkSignInStatusSuccess(r)),
    );
  }

  @override
  Future<void> close() {
    logger.i("===== CLOSE AuthCubit =====");
    return super.close();
  }
}

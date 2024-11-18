part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitialState;

  // Register states
  const factory AuthState.registerLoading() = AuthRegisterLoadingState;
  const factory AuthState.registerSuccess(String message) =
      AuthRegisterSuccessState;
  const factory AuthState.registerFailure(String message) =
      AuthRegisterFailureState;

  // Login states
  const factory AuthState.loginLoading() = AuthLoginLoadingState;
  const factory AuthState.loginSuccess(UserEntity data) = AuthLoginSuccessState;
  const factory AuthState.loginFailure(String message) = AuthLoginFailureState;

  // Logout states
  const factory AuthState.logoutLoading() = AuthLogoutLoadingState;
  const factory AuthState.logoutSuccess(String message) =
      AuthLogoutSuccessState;
  const factory AuthState.logoutFailure(String message) =
      AuthLogoutFailureState;

  // Check Sign-In Status states
  const factory AuthState.checkSignInStatusLoading() =
      AuthCheckSignInStatusLoadingState;
  const factory AuthState.checkSignInStatusSuccess(UserEntity data) =
      AuthCheckSignInStatusSuccessState;
  const factory AuthState.checkSignInStatusFailure(String message) =
      AuthCheckSignInStatusFailureState;
}

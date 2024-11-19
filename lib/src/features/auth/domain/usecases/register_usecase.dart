import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proker/src/core/errors/failures.dart';
import 'package:proker/src/core/usecase/usecase.dart';
import 'package:proker/src/core/utils/extensions/string_extensions.dart';
import 'package:proker/src/features/auth/domain/repositories/auth_repository.dart';

@lazySingleton
class AuthRegisterUseCase implements UseCase<void, Params> {
  final AuthRepository _authRepository;
  const AuthRegisterUseCase(this._authRepository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    if (!params.email.isEmailValid) {
      return Left(InvalidEmailFailure());
    }

    if (!params.password.isPasswordValid ||
        !params.confirmPassword.isPasswordValid) {
      return Left(InvalidPasswordFailure());
    }

    if (params.password != params.confirmPassword) {
      return Left(PasswordNotMatchFailure());
    }

    return await _authRepository.register(params);
  }
}

class Params extends Equatable {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  const Params({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        password,
        confirmPassword,
      ];
}

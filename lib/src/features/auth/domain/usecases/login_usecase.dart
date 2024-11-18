import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proker/src/core/errors/failures.dart';
import 'package:proker/src/core/usecase/usecase.dart';
import 'package:proker/src/core/utils/extensions/string_extensions.dart';
import 'package:proker/src/features/auth/domain/entities/user_entity.dart';
import 'package:proker/src/features/auth/domain/repositories/auth_repository.dart';

@lazySingleton
class AuthLoginUseCase implements UseCase<UserEntity, Params> {
  final AuthRepository _authRepository;
  const AuthLoginUseCase(this._authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(Params params) async {
    if (!params.email.isEmailValid) {
      return Left(InvalidEmailFailure());
    }

    if (!params.password.isPasswordValid) {
      return Left(InvalidPasswordFailure());
    }

    final result = await _authRepository.login(params);

    return result;
  }
}

class Params extends Equatable {
  final String email;
  final String password;
  const Params({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}

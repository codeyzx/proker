import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proker/src/core/errors/failures.dart';
import 'package:proker/src/core/usecase/usecase.dart';
import 'package:proker/src/features/auth/domain/entities/user_entity.dart';
import 'package:proker/src/features/auth/domain/repositories/auth_repository.dart';

@singleton
class AuthCheckSignInStatusUseCase implements UseCase<UserEntity, NoParams> {
  final AuthRepository _authRepository;
  const AuthCheckSignInStatusUseCase(this._authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await _authRepository.checkSignInStatus();
  }
}

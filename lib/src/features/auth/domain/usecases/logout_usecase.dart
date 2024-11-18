import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proker/src/core/errors/failures.dart';
import 'package:proker/src/core/usecase/usecase.dart';
import 'package:proker/src/features/auth/domain/repositories/auth_repository.dart';

@lazySingleton
class AuthLogoutUseCase implements UseCase<void, NoParams> {
  final AuthRepository _authRepository;
  const AuthLogoutUseCase(this._authRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await _authRepository.logout();
  }
}

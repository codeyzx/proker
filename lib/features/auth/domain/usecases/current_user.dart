import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proker/core/common/entities/user.dart';
import 'package:proker/core/error/failures.dart';
import 'package:proker/core/usecase/usecase.dart';
import 'package:proker/features/auth/domain/repository/auth_repository.dart';

@injectable
class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository authRepository;
  CurrentUser(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}

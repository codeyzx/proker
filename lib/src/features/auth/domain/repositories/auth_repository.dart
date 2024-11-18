import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import 'package:proker/src/core/errors/failures.dart';
import 'package:proker/src/features/auth/domain/entities/user_entity.dart';
import 'package:proker/src/features/auth/domain/usecases/usecase_params.dart';

@singleton
abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(LoginParams params);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, void>> register(RegisterParams params);
  Future<Either<Failure, UserEntity>> checkSignInStatus();
}

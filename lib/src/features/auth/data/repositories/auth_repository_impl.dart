import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proker/src/core/cache/hive_local_storage.dart';
import 'package:proker/src/core/cache/secure_local_storage.dart';
import 'package:proker/src/core/errors/exceptions.dart';
import 'package:proker/src/core/errors/failures.dart';
import 'package:proker/src/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:proker/src/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:proker/src/features/auth/data/models/login_model.dart';
import 'package:proker/src/features/auth/data/models/register_model.dart';
import 'package:proker/src/features/auth/domain/entities/user_entity.dart';
import 'package:proker/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:proker/src/features/auth/domain/usecases/usecase_params.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;
  final SecureLocalStorage _secureLocalStorage;
  final HiveLocalStorage _localStorage;
  const AuthRepositoryImpl(
    this._authRemoteDataSource,
    this._authLocalDataSource,
    this._secureLocalStorage,
    this._localStorage,
  );

  @override
  Future<Either<Failure, UserEntity>> login(LoginParams params) async {
    try {
      final model = LoginModel(
        email: params.email,
        password: params.password,
      );

      final result = await _authRemoteDataSource.login(model);

      await _secureLocalStorage.save(key: "user_id", value: result.id);
      await _localStorage.save(key: "user", value: result, boxName: "cache");

      return Right(result);
    } on AuthException {
      return Left(CredentialFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final result = await _authRemoteDataSource.logout();

      await _secureLocalStorage.delete(key: "user_id");
      await _localStorage.delete(key: "user", boxName: "cache");

      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> register(RegisterParams params) async {
    try {
      final model = RegisterModel(
        name: params.name,
        email: params.email,
        password: params.password,
      );

      final result = await _authRemoteDataSource.register(model);
      return Right(result);
    } on DuplicateEmailException {
      return Left(DuplicateEmailFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> checkSignInStatus() async {
    try {
      final result = await _authLocalDataSource.checkSignInStatus();

      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart'
    as _i451;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i161;

import '../../../features/auth/data/datasources/auth_local_datasource.dart'
    as _i838;
import '../../../features/auth/data/datasources/auth_remote_datasource.dart'
    as _i1043;
import '../../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i365;
import '../../../features/auth/domain/repositories/auth_repository.dart'
    as _i234;
import '../../../features/auth/domain/usecases/check_signin_status_usecase.dart'
    as _i619;
import '../../../features/auth/domain/usecases/login_usecase.dart' as _i849;
import '../../../features/auth/domain/usecases/logout_usecase.dart' as _i1;
import '../../../features/auth/domain/usecases/register_usecase.dart' as _i879;
import '../../../features/auth/presentation/bloc/auth/auth_cubit.dart' as _i32;
import '../../cache/hive_local_storage.dart' as _i252;
import '../../cache/secure_local_storage.dart' as _i333;
import '../../common/infrastructure/fb_module.dart' as _i869;
import '../../common/infrastructure/register_module.dart' as _i183;
import '../../network/connection_checker.dart' as _i989;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final fBModule = _$FBModule();
    final registerModule = _$RegisterModule();
    gh.singleton<_i252.HiveLocalStorage>(() => _i252.HiveLocalStorage());
    gh.singleton<_i59.FirebaseAuth>(() => fBModule.getFirebaseAuth);
    gh.singleton<_i116.GoogleSignIn>(() => fBModule.getGoogleSignin);
    gh.singleton<_i451.FirebaseChatCore>(() => fBModule.getFirebaseChatCore);
    gh.singleton<_i1043.AuthRemoteDataSourceImpl>(
        () => _i1043.AuthRemoteDataSourceImpl());
    gh.lazySingleton<_i161.InternetConnection>(
        () => registerModule.internetConnection);
    gh.singleton<_i619.AuthCheckSignInStatusUseCase>(
        () => _i619.AuthCheckSignInStatusUseCase(gh<_i234.AuthRepository>()));
    gh.singleton<_i849.AuthLoginUseCase>(
        () => _i849.AuthLoginUseCase(gh<_i234.AuthRepository>()));
    gh.singleton<_i1.AuthLogoutUseCase>(
        () => _i1.AuthLogoutUseCase(gh<_i234.AuthRepository>()));
    gh.singleton<_i879.AuthRegisterUseCase>(
        () => _i879.AuthRegisterUseCase(gh<_i234.AuthRepository>()));
    gh.factory<_i32.AuthCubit>(() => _i32.AuthCubit(
          gh<_i849.AuthLoginUseCase>(),
          gh<_i1.AuthLogoutUseCase>(),
          gh<_i879.AuthRegisterUseCase>(),
          gh<_i619.AuthCheckSignInStatusUseCase>(),
        ));
    gh.singleton<_i333.SecureLocalStorage>(
        () => _i333.SecureLocalStorage(gh<_i558.FlutterSecureStorage>()));
    gh.singleton<_i989.ConnectionChecker>(
        () => _i989.ConnectionCheckerImpl(gh<_i161.InternetConnection>()));
    gh.singleton<_i365.AuthRepositoryImpl>(() => _i365.AuthRepositoryImpl(
          gh<_i1043.AuthRemoteDataSource>(),
          gh<_i838.AuthLocalDataSource>(),
          gh<_i333.SecureLocalStorage>(),
          gh<_i252.HiveLocalStorage>(),
        ));
    gh.singleton<_i838.AuthLocalDataSourceImpl>(
        () => _i838.AuthLocalDataSourceImpl(
              gh<_i333.SecureLocalStorage>(),
              gh<_i252.HiveLocalStorage>(),
            ));
    return this;
  }
}

class _$FBModule extends _i869.FBModule {}

class _$RegisterModule extends _i183.RegisterModule {}

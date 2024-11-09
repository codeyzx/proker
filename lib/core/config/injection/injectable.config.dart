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
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i161;

import '../../../features/auth/data/datasources/auth_remote_data_source.dart'
    as _i436;
import '../../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i365;
import '../../../features/auth/domain/repository/auth_repository.dart' as _i754;
import '../../../features/auth/domain/usecases/current_user.dart' as _i984;
import '../../../features/auth/domain/usecases/user_login.dart' as _i89;
import '../../../features/auth/domain/usecases/user_sign_up.dart' as _i779;
import '../../../features/auth/presentation/bloc/auth_bloc.dart' as _i748;
import '../../common/cubits/app_user/app_user_cubit.dart' as _i1005;
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
    gh.singleton<_i1005.AppUserCubit>(() => _i1005.AppUserCubit());
    gh.singleton<_i59.FirebaseAuth>(() => fBModule.getFirebaseAuth);
    gh.singleton<_i116.GoogleSignIn>(() => fBModule.getGoogleSignin);
    gh.singleton<_i451.FirebaseChatCore>(() => fBModule.getFirebaseChatCore);
    gh.lazySingleton<_i161.InternetConnection>(
        () => registerModule.internetConnection);
    gh.factory<_i436.AuthRemoteDataSource>(
        () => _i436.AuthRemoteDataSourceImpl(gh<_i59.FirebaseAuth>()));
    gh.singleton<_i989.ConnectionChecker>(
        () => _i989.ConnectionCheckerImpl(gh<_i161.InternetConnection>()));
    gh.singleton<_i754.AuthRepository>(() => _i365.AuthRepositoryImpl(
          gh<_i436.AuthRemoteDataSource>(),
          gh<_i989.ConnectionChecker>(),
        ));
    gh.factory<_i984.CurrentUser>(
        () => _i984.CurrentUser(gh<_i754.AuthRepository>()));
    gh.factory<_i89.UserLogin>(
        () => _i89.UserLogin(gh<_i754.AuthRepository>()));
    gh.factory<_i779.UserSignUp>(
        () => _i779.UserSignUp(gh<_i754.AuthRepository>()));
    gh.singleton<_i748.AuthBloc>(() => _i748.AuthBloc(
          userSignUp: gh<_i779.UserSignUp>(),
          userLogin: gh<_i89.UserLogin>(),
          currentUser: gh<_i984.CurrentUser>(),
          appUserCubit: gh<_i1005.AppUserCubit>(),
        ));
    return this;
  }
}

class _$FBModule extends _i869.FBModule {}

class _$RegisterModule extends _i183.RegisterModule {}

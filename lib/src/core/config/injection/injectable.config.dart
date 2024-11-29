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
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;

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
import '../../../features/chat/data/datasources/chat_datasource.dart' as _i759;
import '../../../features/chat/data/datasources/friend_datasource.dart'
    as _i1046;
import '../../../features/chat/data/datasources/room_datasource.dart' as _i994;
import '../../../features/chat/domain/repositories/chat_repository.dart'
    as _i75;
import '../../../features/chat/domain/repositories/friend_repository.dart'
    as _i291;
import '../../../features/chat/domain/repositories/room_repository.dart'
    as _i719;
import '../../../features/chat/presentation/bloc/friend/friend_cubit.dart'
    as _i892;
import '../../../features/chat/presentation/bloc/message/message_cubit.dart'
    as _i375;
import '../../../features/chat/presentation/bloc/room/room_cubit.dart' as _i517;
import '../../../features/event/data/datasources/event_local_datasource.dart'
    as _i476;
import '../../../features/event/data/datasources/event_remote_datasource.dart'
    as _i780;
import '../../../features/event/data/repositories/event_repository_impl.dart'
    as _i59;
import '../../../features/event/domain/repositories/event_repository.dart'
    as _i340;
import '../../../features/event/domain/usecases/create_event_usecase.dart'
    as _i534;
import '../../../features/event/domain/usecases/delete_event_usecase.dart'
    as _i883;
import '../../../features/event/domain/usecases/get_event_list_usecase.dart'
    as _i68;
import '../../../features/event/domain/usecases/update_event_usecase.dart'
    as _i441;
import '../../../features/event/presentation/bloc/event/event_cubit.dart'
    as _i20;
import '../../cache/hive_local_storage.dart' as _i252;
import '../../cache/local_storage.dart' as _i99;
import '../../cache/secure_local_storage.dart' as _i333;
import '../../common/infrastructure/fb_module.dart' as _i869;
import '../../network/network_info.dart' as _i408;

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
    final registerModule = _$RegisterModule(this);
    gh.factory<_i252.HiveLocalStorage>(() => _i252.HiveLocalStorage());
    gh.singleton<_i59.FirebaseAuth>(() => fBModule.getFirebaseAuth);
    gh.singleton<_i116.GoogleSignIn>(() => fBModule.getGoogleSignin);
    gh.singleton<_i451.FirebaseChatCore>(() => fBModule.getFirebaseChatCore);
    gh.lazySingleton<_i558.IOSOptions>(() => registerModule.iosOptions);
    gh.lazySingleton<_i558.AndroidOptions>(() => registerModule.androidOptions);
    gh.lazySingleton<_i558.LinuxOptions>(() => registerModule.linuxOptions);
    gh.lazySingleton<_i558.WindowsOptions>(() => registerModule.windowsOptions);
    gh.lazySingleton<_i558.WebOptions>(() => registerModule.webOptions);
    gh.lazySingleton<_i558.MacOsOptions>(() => registerModule.macOsOptions);
    gh.lazySingleton<_i973.InternetConnectionChecker>(
        () => registerModule.connectionChecker);
    gh.lazySingleton<_i99.LocalStorage>(() => registerModule.localStorage);
    gh.lazySingleton<_i476.EventLocalDataSource>(
        () => _i476.EventLocalDataSourceImpl(gh<_i252.HiveLocalStorage>()));
    gh.singleton<_i75.ChatRepository>(
        () => _i759.ChatDatasource(gh<_i451.FirebaseChatCore>()));
    gh.lazySingleton<_i780.EventRemoteDataSource>(
        () => const _i780.EventRemoteDataSourceImpl());
    gh.singleton<_i719.RoomRepository>(
        () => _i994.RoomDatasource(gh<_i451.FirebaseChatCore>()));
    gh.lazySingleton<_i1043.AuthRemoteDataSource>(
        () => _i1043.AuthRemoteDataSourceImpl(
              gh<_i59.FirebaseAuth>(),
              gh<_i116.GoogleSignIn>(),
              gh<_i451.FirebaseChatCore>(),
            ));
    gh.singleton<_i291.FriendRepository>(
        () => _i1046.FriendDatasource(gh<_i451.FirebaseChatCore>()));
    gh.factory<_i517.RoomCubit>(
        () => _i517.RoomCubit(gh<_i719.RoomRepository>()));
    gh.singleton<_i408.NetworkInfo>(
        () => _i408.NetworkInfoImpl(gh<_i973.InternetConnectionChecker>()));
    gh.lazySingleton<_i558.FlutterSecureStorage>(
        () => registerModule.flutterSecureStorage);
    gh.factory<_i375.MessageCubit>(
        () => _i375.MessageCubit(gh<_i75.ChatRepository>()));
    gh.factory<_i333.SecureLocalStorage>(
        () => _i333.SecureLocalStorage(gh<_i558.FlutterSecureStorage>()));
    gh.lazySingleton<_i838.AuthLocalDataSource>(
        () => _i838.AuthLocalDataSourceImpl(
              gh<_i333.SecureLocalStorage>(),
              gh<_i252.HiveLocalStorage>(),
            ));
    gh.lazySingleton<_i340.EventRepository>(() => _i59.EventRepositoryImpl(
          gh<_i780.EventRemoteDataSource>(),
          gh<_i476.EventLocalDataSource>(),
          gh<_i408.NetworkInfo>(),
          gh<_i252.HiveLocalStorage>(),
        ));
    gh.factory<_i892.FriendCubit>(
        () => _i892.FriendCubit(gh<_i291.FriendRepository>()));
    gh.lazySingleton<_i234.AuthRepository>(() => _i365.AuthRepositoryImpl(
          gh<_i1043.AuthRemoteDataSource>(),
          gh<_i838.AuthLocalDataSource>(),
          gh<_i333.SecureLocalStorage>(),
          gh<_i252.HiveLocalStorage>(),
        ));
    gh.lazySingleton<_i879.AuthRegisterUseCase>(
        () => _i879.AuthRegisterUseCase(gh<_i234.AuthRepository>()));
    gh.lazySingleton<_i849.AuthLoginUseCase>(
        () => _i849.AuthLoginUseCase(gh<_i234.AuthRepository>()));
    gh.lazySingleton<_i1.AuthLogoutUseCase>(
        () => _i1.AuthLogoutUseCase(gh<_i234.AuthRepository>()));
    gh.lazySingleton<_i619.AuthCheckSignInStatusUseCase>(
        () => _i619.AuthCheckSignInStatusUseCase(gh<_i234.AuthRepository>()));
    gh.lazySingleton<_i32.AuthCubit>(() => _i32.AuthCubit(
          gh<_i849.AuthLoginUseCase>(),
          gh<_i1.AuthLogoutUseCase>(),
          gh<_i879.AuthRegisterUseCase>(),
          gh<_i619.AuthCheckSignInStatusUseCase>(),
        ));
    gh.lazySingleton<_i441.UpdateEventUseCase>(
        () => _i441.UpdateEventUseCase(gh<_i340.EventRepository>()));
    gh.lazySingleton<_i883.DeleteEventUseCase>(
        () => _i883.DeleteEventUseCase(gh<_i340.EventRepository>()));
    gh.lazySingleton<_i534.CreateEventUseCase>(
        () => _i534.CreateEventUseCase(gh<_i340.EventRepository>()));
    gh.lazySingleton<_i68.GetEventListUseCase>(
        () => _i68.GetEventListUseCase(gh<_i340.EventRepository>()));
    gh.factory<_i20.EventCubit>(() => _i20.EventCubit(
          gh<_i534.CreateEventUseCase>(),
          gh<_i883.DeleteEventUseCase>(),
          gh<_i68.GetEventListUseCase>(),
          gh<_i441.UpdateEventUseCase>(),
        ));
    return this;
  }
}

class _$FBModule extends _i869.FBModule {}

class _$RegisterModule extends _i333.RegisterModule {
  _$RegisterModule(this._getIt);

  final _i174.GetIt _getIt;

  @override
  _i558.FlutterSecureStorage get flutterSecureStorage =>
      _i558.FlutterSecureStorage(
        iOptions: _getIt<_i558.IOSOptions>(),
        aOptions: _getIt<_i558.AndroidOptions>(),
        lOptions: _getIt<_i558.LinuxOptions>(),
        wOptions: _getIt<_i558.WindowsOptions>(),
        webOptions: _getIt<_i558.WebOptions>(),
        mOptions: _getIt<_i558.MacOsOptions>(),
      );
}

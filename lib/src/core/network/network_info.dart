import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:proker/src/core/errors/failures.dart';

typedef EitherNetwork<T> = Future<Either<Failure, T>> Function();

abstract class NetworkInfo {
  Future<Either<Failure, T>> check<T>({
    required EitherNetwork<T> connected,
    required EitherNetwork<T> notConnected,
  });

  Future<bool> get checkIsConnected;
  bool get getIsConnected;
  set setIsConnected(bool val);
}

@Singleton(as: NetworkInfo)
class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker _connectionChecker;

  bool _isConnected = true;

  NetworkInfoImpl(this._connectionChecker);

  @override
  Future<Either<Failure, T>> check<T>({
    required EitherNetwork<T> connected,
    required EitherNetwork<T> notConnected,
  }) async {
    final isConnected = await checkIsConnected;
    if (isConnected) {
      return connected.call();
    } else {
      return notConnected.call();
    }
  }

  @override
  Future<bool> get checkIsConnected async =>
      await _connectionChecker.hasConnection;

  @override
  set setIsConnected(bool val) => _isConnected = val;

  @override
  bool get getIsConnected => _isConnected;
}

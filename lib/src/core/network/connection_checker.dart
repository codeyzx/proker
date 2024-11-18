import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract interface class ConnectionChecker {
  Future<bool> get isConnected;
}

@Singleton(as: ConnectionChecker)
class ConnectionCheckerImpl implements ConnectionChecker {
  @lazySingleton
  final InternetConnection internetConnection;
  ConnectionCheckerImpl(this.internetConnection);

  @override
  Future<bool> get isConnected async =>
      await internetConnection.hasInternetAccess;
}

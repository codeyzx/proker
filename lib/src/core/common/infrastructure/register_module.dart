import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
// import 'package:hive/hive.dart';
// import 'package:path_provider/path_provider.dart';

@module
abstract class RegisterModule {
  // Registering a third-party dependency as a lazy singleton
  @lazySingleton
  InternetConnection get internetConnection => InternetConnection();

  // // Registering Hive Box asynchronously
  // @preResolve
  // Future<Box> get blogBox async {
  //   Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
  //   return Hive.box('blogs');
  // }
}

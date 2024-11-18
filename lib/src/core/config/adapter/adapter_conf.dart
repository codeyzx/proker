import 'package:hive_flutter/hive_flutter.dart';

import 'package:proker/src/core/config/adapter/adapter.dart';

void configureAdapter() {
  Hive.registerAdapter(UserAdapter());
}

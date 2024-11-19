import 'package:hive_flutter/hive_flutter.dart';

import 'package:proker/src/features/auth/data/models/user_model.dart';

class UserAdapter extends TypeAdapter<UserModel> {
  @override
  final typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final data = reader.readList();

    return UserModel(
      id: data[0],
      email: data[1],
      name: data[2],
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer.writeList([
      obj.id,
      obj.email,
      obj.name,
      obj.password,
    ]);
  }
}

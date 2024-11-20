import 'package:hive_flutter/hive_flutter.dart';
import 'package:proker/src/features/auth/data/models/user_model.dart';

class UserAdapter extends TypeAdapter<UserModel> {
  @override
  final typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final data = reader.readList();

    return UserModel(
      id: data[0] as String? ?? '',
      email: data[1] as String? ?? '',
      name: data[2] as String? ?? '',
      firstName: data[3] as String? ?? '',
      lastName: data[4] as String? ?? '',
      imageUrl: data[5] as String? ?? '',
      role: data[6] as String? ?? '',
      createdAt: UserModel.fromMillis(data[7] as int?),
      updatedAt: UserModel.fromMillis(data[8] as int?),
      lastSeen: UserModel.fromMillis(data[9] as int?),
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer.writeList([
      obj.id,
      obj.email,
      obj.name,
      obj.firstName,
      obj.lastName,
      obj.imageUrl,
      obj.role,
      obj.createdAtMillis(),
      obj.updatedAtMillis(),
      obj.lastSeenMillis(),
    ]);
  }
}

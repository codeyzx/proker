import 'package:proker/src/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required String id,
    required String email,
    required String name,
  }) : super(
          id: id,
          email: email,
          name: name,
        );

  factory UserModel.fromJson(Map<String, dynamic> json, String id) {
    return UserModel(
      id: id,
      email: json["email"],
      name: json["name"],
    );
  }
}

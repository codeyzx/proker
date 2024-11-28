import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proker/src/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required String id,
    required String email,
    required String name,
    required String firstName,
    required String lastName,
    required String imageUrl,
    required String role,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime lastSeen,
  }) : super(
          id: id,
          email: email,
          name: name,
          firstName: firstName,
          lastName: lastName,
          imageUrl: imageUrl,
          role: role,
          createdAt: createdAt,
          updatedAt: updatedAt,
          lastSeen: lastSeen,
        );

  factory UserModel.fromJson(Map<String, dynamic> json, String id) {
    return UserModel(
      id: id,
      email: json["email"],
      name: json["name"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      imageUrl: json["imageUrl"],
      role: json["role"],
      createdAt: UserEntity.fromMillis(json["createdAt"]) ?? DateTime.now(),
      updatedAt: UserEntity.fromMillis(json["updatedAt"]) ?? DateTime.now(),
      lastSeen: UserEntity.fromMillis(json["lastSeen"]) ?? DateTime.now(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "name": name,
      "firstName": firstName,
      "lastName": lastName,
      "imageUrl": imageUrl,
      "role": role,
      "createdAt": createdAtMillis(),
      "updatedAt": updatedAtMillis(),
      "lastSeen": lastSeenMillis(),
    };
  }

  static DateTime fromMillis(dynamic millis) {
    if (millis is Timestamp) {
      return millis.toDate();
    } else if (millis is int) {
      return DateTime.fromMillisecondsSinceEpoch(millis);
    }
    return DateTime.now();
  }
}

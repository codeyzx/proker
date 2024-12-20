import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';

class UserEntity extends Equatable {
  final String? id;
  final String? name;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? imageUrl;
  final String? role;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? lastSeen;
  final String? password;
  const UserEntity({
    this.id,
    this.name,
    this.email,
    this.firstName,
    this.lastName,
    this.imageUrl,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.lastSeen,
    this.password,
  });

  int? createdAtMillis() => createdAt?.millisecondsSinceEpoch;
  int? updatedAtMillis() => updatedAt?.millisecondsSinceEpoch;
  int? lastSeenMillis() => lastSeen?.millisecondsSinceEpoch;

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      imageUrl: json['imageUrl'],
      role: json['role'],
      createdAt: fromMillis(json['createdAt']),
      updatedAt: fromMillis(json['updatedAt']),
      lastSeen: fromMillis(json['lastSeen']),
      password: json['password'],
    );
  }

  //UserEntity to User flutter chat types
  User toUser() {
    return User(
      id: id ?? '',
      firstName: firstName,
      imageUrl: imageUrl,
      lastName: lastName,
      metadata: {
        'role': 'user',
        'email': email,
        'name': name,
        'createdAt': fromMillis(createdAt),
        'updatedAt': fromMillis(updatedAt),
        'lastSeen': fromMillis(lastSeen),
      },
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'imageUrl': imageUrl,
      'role': role,
      'createdAt': createdAtMillis(),
      'updatedAt': updatedAtMillis(),
      'lastSeen': lastSeenMillis(),
      'password': password,
    };
  }

  static DateTime? fromMillis(dynamic millis) {
    if (millis is Timestamp) {
      return millis.toDate();
    } else if (millis is int) {
      return DateTime.fromMillisecondsSinceEpoch(millis);
    }
    return null;
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        firstName,
        lastName,
        imageUrl,
        role,
        createdAt,
        updatedAt,
        lastSeen,
        password,
      ];
}

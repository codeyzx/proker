import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

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

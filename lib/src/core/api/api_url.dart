import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proker/src/features/auth/domain/entities/user_entity.dart';
import 'package:proker/src/features/event/domain/entities/event_entity.dart';

class ApiUrl {
  const ApiUrl._();

  static const baseUrl = "https://....com/api/v1";

  static final users = FirebaseFirestore.instance
      .collection("users")
      .withConverter<UserEntity>(
        fromFirestore: (snapshot, _) => UserEntity.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

  static final events = FirebaseFirestore.instance
      .collection("events")
      .withConverter<EventEntity>(
        fromFirestore: (snapshot, _) => EventEntity.fromJson(snapshot.data()!),
        toFirestore: (event, _) => event.toJson(),
      );
}

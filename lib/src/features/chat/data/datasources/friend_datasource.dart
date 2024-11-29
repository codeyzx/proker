import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proker/src/core/utils/logger.dart';
import 'package:proker/src/features/auth/data/models/user_model.dart';
import 'package:proker/src/features/auth/domain/entities/user_entity.dart';
import 'package:proker/src/features/chat/domain/repositories/friend_repository.dart';

@Singleton(as: FriendRepository)
class FriendDatasource implements FriendRepository {
  FriendDatasource(this.fbChatCore);
  final FirebaseChatCore fbChatCore;

  @override
  Stream<Either<String, List<UserEntity>>> watchFriends() async* {
    // yield* fbChatCore.users().map((event) {
    //   logger.e("FriendDatasource: watchFriends: $event");
    //   final users =
    //       event.map((user) => user.copyWith(role: Role.user)).toList();
    //   return right(users);
    // });
    yield* fbChatCore
        .getFirebaseFirestore()
        .collection('users')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.fold<List<UserModel>>(
            [],
            (previousValue, doc) {
              // if (firebaseUser!.uid == doc.id) return previousValue;

              final data = doc.data();
              logger.e("FriendDatasource: watchFriends: ${doc.id}");

              data['createdAt'] = data['createdAt'];
              data['id'] = doc.id;
              data['lastSeen'] = data['lastSeen'];
              data['updatedAt'] = data['updatedAt'];

              logger.e("FriendDatasource: watchFriends: $data");

              return [
                ...previousValue,
                UserModel.fromJson(
                  data,
                  doc.id,
                )
              ];
            },
          ),
        )
        .map((event) {
      logger.e("FriendDatasource: watchFriends: $event");
      final users = event.map((user) => user).toList();
      return right(users);
    });
  }
}

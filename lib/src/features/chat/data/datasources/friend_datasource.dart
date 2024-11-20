import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proker/src/features/chat/domain/repositories/friend_repository.dart';

@Singleton(as: FriendRepository)
class FriendDatasource implements FriendRepository {
  FriendDatasource(this.fbChatCore);
  final FirebaseChatCore fbChatCore;

  @override
  Stream<Either<String, List<User>>> watchFriends() async* {
    yield* fbChatCore.users().map((event) => right(event));
  }
}

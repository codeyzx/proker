import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:fpdart/fpdart.dart';

abstract class FriendRepository {
  Stream<Either<String, List<types.User>>> watchFriends();
}

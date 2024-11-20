import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:fpdart/fpdart.dart';

abstract class RoomRepository {
  Stream<Either<String, List<types.Room>>> watchRooms();
  Future<Either<String, types.Room>> createSingleRoom(types.User otherUser);
}

import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proker/src/features/chat/domain/repositories/room_repository.dart';

@Singleton(as: RoomRepository)
class RoomDatasource implements RoomRepository {
  RoomDatasource(this.fbChatCore);
  final FirebaseChatCore fbChatCore;

  @override
  Stream<Either<String, List<Room>>> watchRooms() async* {
    yield* fbChatCore.rooms().map((event) => right(event));
  }

  @override
  Future<Either<String, Room>> createSingleRoom(User otherUser) async {
    try {
      final newRoom = await fbChatCore.createRoom(otherUser);
      return right(newRoom);
    } catch (e) {
      return left("SERVER ERROR");
    }
  }
}

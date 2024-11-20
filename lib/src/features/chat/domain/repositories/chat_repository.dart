import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:fpdart/fpdart.dart';

abstract class ChatRepository {
  Stream<Either<String, List<types.Message>>> watchMessages(types.Room room);
  Future<Either<String, Unit>> sendMessage(dynamic message, String roomId);
}

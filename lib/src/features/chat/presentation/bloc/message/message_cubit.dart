import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:proker/src/features/chat/domain/repositories/chat_repository.dart';

part 'message_cubit.freezed.dart';
part 'message_state.dart';

@injectable
class MessageCubit extends Cubit<MessageState> {
  MessageCubit(this.chatRepository) : super(const MessageState.initial());
  final ChatRepository chatRepository;

  final Map<String, StreamSubscription<Either<String, List<Message>>>>
      _subscriptions = {};
  final Map<String, Message> _lastMessages = {};

  void streamMessages(Room room) {
    // Cancel existing subscription for the room if any
    _subscriptions[room.id]?.cancel();

    // Start a new subscription for the room
    final subscription = chatRepository.watchMessages(room).listen((event) {
      event.fold(
        (error) {
          emit(const MessageState.error());
        },
        (messages) {
          if (messages.isNotEmpty) {
            // Update the last message for this room
            _lastMessages[room.id] = messages.first;

            // Emit updated state with aggregated last messages
            emit(MessageState.onMessagesAndLastMessage(
                messages, Map.of(_lastMessages)));
          } else {
            _lastMessages.remove(room.id);
            emit(MessageState.onMessagesAndLastMessage(
                messages, Map.of(_lastMessages)));
          }
        },
      );
    });

    _subscriptions[room.id] = subscription;
  }

  void watchAllMessages(List<Room> rooms) {
    for (var room in rooms) {
      streamMessages(room);
    }
  }

  void sendTextMessage(PartialText text, String roomId) {
    chatRepository.sendMessage(text, roomId);
  }

  @override
  Future<void> close() {
    // Cancel all subscriptions
    for (var subscription in _subscriptions.values) {
      subscription.cancel();
    }
    _subscriptions.clear();
    return super.close();
  }
}

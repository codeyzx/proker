part of 'message_cubit.dart';

@freezed
class MessageState with _$MessageState {
  const factory MessageState.initial() = _Initial;
  const factory MessageState.loading() = _Loading;
  const factory MessageState.error() = _Error;
  const factory MessageState.onMessagesAndLastMessage(
          List<Message> messages, Map<String, Message> lastMessages) =
      _OnMessagesAndLastMessage;
}

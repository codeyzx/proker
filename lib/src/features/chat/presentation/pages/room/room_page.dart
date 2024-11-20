import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:proker/src/core/common/widgets/loader/loader.dart';
import 'package:proker/src/core/config/injection/injectable.dart';
import 'package:proker/src/core/config/router/app_router.dart';
import 'package:proker/src/features/chat/presentation/bloc/message/message_cubit.dart';
import 'package:proker/src/features/chat/presentation/bloc/room/room_cubit.dart';

@RoutePage()
class RoomPage extends StatelessWidget {
  const RoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<RoomCubit>()..watchAllRooms(),
          ),
          BlocProvider(
            create: (context) => getIt<MessageCubit>(),
          ),
        ],
        child: BlocBuilder<RoomCubit, RoomState>(
          builder: (context, state) {
            return state.maybeMap(
              loading: (_) {
                return const Loader();
              },
              orElse: () {
                return Container();
              },
              success: (value) {
                final rooms = value.rooms;
                if (rooms.isEmpty) {
                  return const Center(
                    child: Text("Tidak ada chat"),
                  );
                }

                context.read<MessageCubit>().watchAllMessages(rooms);
                return ListView.builder(
                  itemCount: rooms.length,
                  itemBuilder: (context, index) {
                    final singleRoom = rooms[index];
                    return ListTile(
                      onTap: () {
                        context.router.push(ChatRoute(room: singleRoom));
                      },
                      title: Text(singleRoom.name ?? ""),
                      leading: CircleAvatar(
                        backgroundColor: Colors.amber,
                        backgroundImage:
                            NetworkImage(singleRoom.imageUrl ?? ""),
                      ),
                      subtitle: BlocBuilder<MessageCubit, MessageState>(
                        builder: (context, messageState) {
                          return messageState.maybeMap(
                            orElse: () => const LastRepliedMessageWidget(),
                            onMessagesAndLastMessage: (state) {
                              final lastMessage =
                                  state.lastMessages[singleRoom.id] ??
                                      TextMessage(
                                        id: 'default',
                                        author: const User(id: 'default'),
                                        text: 'No messages yet',
                                        createdAt: DateTime.now()
                                            .millisecondsSinceEpoch,
                                      );

                              final lastMessageText =
                                  (lastMessage is TextMessage)
                                      ? lastMessage.text
                                      : "No messages yet";

                              return LastRepliedMessageWidget(
                                message: lastMessageText,
                                isRead: false,
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushRoute(const FriendRoute());
        },
        child: const Icon(Icons.message),
      ),
    );
  }
}

// Updated widget for displaying the last replied message with read status
class LastRepliedMessageWidget extends StatelessWidget {
  final String? message;
  final bool isRead;

  const LastRepliedMessageWidget(
      {super.key, this.message, this.isRead = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      message ?? "No messages yet",
      style: TextStyle(
        color: !isRead ? Colors.grey : Colors.black,
        fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

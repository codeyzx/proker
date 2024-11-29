import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proker/src/core/config/injection/injectable.dart';
import 'package:proker/src/core/config/router/app_router.dart';
import 'package:proker/src/features/chat/presentation/bloc/friend/friend_cubit.dart';
import 'package:proker/src/features/chat/presentation/bloc/room/room_cubit.dart';

@RoutePage()
class FriendPage extends StatefulWidget {
  const FriendPage({super.key});

  @override
  State<FriendPage> createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<FriendCubit>()..streamAllFriends(),
        ),
        BlocProvider(
          create: (context) => getIt<RoomCubit>(),
        ),
      ],
      child: BlocListener<RoomCubit, RoomState>(
        listener: (context, state) {
          state.maybeMap(
            orElse: () {},
            loading: (e) {},
            onRoomCreated: (resp) {
              context.router.popAndPush(ChatRoute(room: resp.room));
            },
          );
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Friend List"),
          ),
          body: BlocBuilder<FriendCubit, FriendState>(
            builder: (context, state) {
              return state.maybeMap(
                orElse: () {
                  return Container();
                },
                loading: (e) {
                  return const Center(child: CircularProgressIndicator());
                },
                success: (e) {
                  final users = e.users;
                  return BlocBuilder<RoomCubit, RoomState>(
                    builder: (context, state) {
                      return ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final singleUser = users[index];
                          return ListTile(
                            onTap: () {
                              //create room
                              context
                                  .read<RoomCubit>()
                                  .createSingleRoom(singleUser.toUser());
                            },
                            title: Text(singleUser.firstName ?? ""),
                            leading: CircleAvatar(
                              backgroundColor: Colors.amber,
                              backgroundImage:
                                  NetworkImage(singleUser.imageUrl ?? ""),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

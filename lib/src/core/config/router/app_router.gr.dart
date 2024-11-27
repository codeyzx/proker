// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AddEventPage]
class AddEventRoute extends PageRouteInfo<void> {
  const AddEventRoute({List<PageRouteInfo>? children})
      : super(
          AddEventRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddEventRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AddEventPage();
    },
  );
}

/// generated route for
/// [ChatPage]
class ChatRoute extends PageRouteInfo<ChatRouteArgs> {
  ChatRoute({
    Key? key,
    required Room room,
    List<PageRouteInfo>? children,
  }) : super(
          ChatRoute.name,
          args: ChatRouteArgs(
            key: key,
            room: room,
          ),
          initialChildren: children,
        );

  static const String name = 'ChatRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChatRouteArgs>();
      return ChatPage(
        key: args.key,
        room: args.room,
      );
    },
  );
}

class ChatRouteArgs {
  const ChatRouteArgs({
    this.key,
    required this.room,
  });

  final Key? key;

  final Room room;

  @override
  String toString() {
    return 'ChatRouteArgs{key: $key, room: $room}';
  }
}

/// generated route for
/// [CreateEventPage]
class CreateEventRoute extends PageRouteInfo<void> {
  const CreateEventRoute({List<PageRouteInfo>? children})
      : super(
          CreateEventRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateEventRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CreateEventPage();
    },
  );
}

/// generated route for
/// [EventListPage]
class EventListRoute extends PageRouteInfo<void> {
  const EventListRoute({List<PageRouteInfo>? children})
      : super(
          EventListRoute.name,
          initialChildren: children,
        );

  static const String name = 'EventListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const EventListPage();
    },
  );
}

/// generated route for
/// [EventPage]
class EventRoute extends PageRouteInfo<void> {
  const EventRoute({List<PageRouteInfo>? children})
      : super(
          EventRoute.name,
          initialChildren: children,
        );

  static const String name = 'EventRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const EventPage();
    },
  );
}

/// generated route for
/// [FriendPage]
class FriendRoute extends PageRouteInfo<void> {
  const FriendRoute({List<PageRouteInfo>? children})
      : super(
          FriendRoute.name,
          initialChildren: children,
        );

  static const String name = 'FriendRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FriendPage();
    },
  );
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomePage();
    },
  );
}

/// generated route for
/// [KelolaEventPage]
class KelolaEventRoute extends PageRouteInfo<void> {
  const KelolaEventRoute({List<PageRouteInfo>? children})
      : super(
          KelolaEventRoute.name,
          initialChildren: children,
        );

  static const String name = 'KelolaEventRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const KelolaEventPage();
    },
  );
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfilePage();
    },
  );
}

/// generated route for
/// [ResetPasswordPage]
class ResetPasswordRoute extends PageRouteInfo<void> {
  const ResetPasswordRoute({List<PageRouteInfo>? children})
      : super(
          ResetPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ResetPasswordPage();
    },
  );
}

/// generated route for
/// [RoomPage]
class RoomRoute extends PageRouteInfo<void> {
  const RoomRoute({List<PageRouteInfo>? children})
      : super(
          RoomRoute.name,
          initialChildren: children,
        );

  static const String name = 'RoomRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RoomPage();
    },
  );
}

/// generated route for
/// [SignInPage]
class SignInRoute extends PageRouteInfo<void> {
  const SignInRoute({List<PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SignInPage();
    },
  );
}

/// generated route for
/// [SignUpPage]
class SignUpRoute extends PageRouteInfo<void> {
  const SignUpRoute({List<PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SignUpPage();
    },
  );
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashPage();
    },
  );
}

/// generated route for
/// [StreamingRoomPage]
class StreamingRoomRoute extends PageRouteInfo<StreamingRoomRouteArgs> {
  StreamingRoomRoute({
    Key? key,
    required bool isHost,
    required String userName,
    required String userID,
    required String liveID,
    List<PageRouteInfo>? children,
  }) : super(
          StreamingRoomRoute.name,
          args: StreamingRoomRouteArgs(
            key: key,
            isHost: isHost,
            userName: userName,
            userID: userID,
            liveID: liveID,
          ),
          initialChildren: children,
        );

  static const String name = 'StreamingRoomRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<StreamingRoomRouteArgs>();
      return StreamingRoomPage(
        key: args.key,
        isHost: args.isHost,
        userName: args.userName,
        userID: args.userID,
        liveID: args.liveID,
      );
    },
  );
}

class StreamingRoomRouteArgs {
  const StreamingRoomRouteArgs({
    this.key,
    required this.isHost,
    required this.userName,
    required this.userID,
    required this.liveID,
  });

  final Key? key;

  final bool isHost;

  final String userName;

  final String userID;

  final String liveID;

  @override
  String toString() {
    return 'StreamingRoomRouteArgs{key: $key, isHost: $isHost, userName: $userName, userID: $userID, liveID: $liveID}';
  }
}

/// generated route for
/// [TabPage]
class TabRoute extends PageRouteInfo<void> {
  const TabRoute({List<PageRouteInfo>? children})
      : super(
          TabRoute.name,
          initialChildren: children,
        );

  static const String name = 'TabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TabPage();
    },
  );
}

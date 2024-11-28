import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:proker/src/features/auth/presentation/pages/reset_password_page.dart';
import 'package:proker/src/features/auth/presentation/pages/sign_in_page.dart';
import 'package:proker/src/features/auth/presentation/pages/sign_up_page.dart';
import 'package:proker/src/features/chat/presentation/pages/chat/chat_page.dart';
import 'package:proker/src/features/chat/presentation/pages/friends/friends_page.dart';
import 'package:proker/src/features/chat/presentation/pages/room/room_page.dart';
import 'package:proker/src/features/event/presentation/pages/add_event.dart';
import 'package:proker/src/features/event/presentation/pages/create_event_page.dart';
import 'package:proker/src/features/event/presentation/pages/event_list_page.dart';
import 'package:proker/src/features/event/presentation/pages/event_page.dart';
import 'package:proker/src/features/event/presentation/pages/kelola_event.dart';
import 'package:proker/src/features/feed/presentation/pages/feed_page.dart';
import 'package:proker/src/features/home/presentation/home_page.dart';
import 'package:proker/src/features/home/presentation/profile_page.dart';
import 'package:proker/src/features/home/presentation/splash_page.dart';
import 'package:proker/src/features/home/presentation/widgets/tab_page.dart';
import 'package:proker/src/features/streaming/presentation/streaming_room_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: TabRoute.page,
          children: [
            AutoRoute(page: HomeRoute.page),
            AutoRoute(page: EventRoute.page),
            AutoRoute(page: KelolaEventRoute.page),
            AutoRoute(page: FeedRoute.page),
            AutoRoute(page: ProfileRoute.page),
          ],
        ),
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: SignInRoute.page),
        AutoRoute(page: SignUpRoute.page),
        AutoRoute(page: ResetPasswordRoute.page),
        AutoRoute(page: FriendRoute.page),
        AutoRoute(page: ChatRoute.page),
        AutoRoute(page: RoomRoute.page),
        AutoRoute(page: EventListRoute.page),
        AutoRoute(page: CreateEventRoute.page),
        AutoRoute(page: StreamingRoomRoute.page),
        AutoRoute(page: AddEventRoute.page),
      ];
}

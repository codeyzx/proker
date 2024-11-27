import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:proker/src/core/blocs/theme/theme_bloc.dart';
import 'package:proker/src/core/common/widgets/status_bar/status_bar_widget.dart';
import 'package:proker/src/core/config/router/app_router.dart';
import 'package:proker/src/core/config/themes/app_colors.dart';
import 'package:proker/src/features/auth/presentation/bloc/auth/auth_cubit.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return StatusBarWidget(
            brightness: Brightness.dark,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: context.w(18)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: context.h(50)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Profile',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: context.sp(32),
                          ),
                        ),
                        BlocBuilder<ThemeBloc, ThemeState>(
                          builder: (context, themeState) {
                            return Switch(
                              value: themeState.isDarkMode,
                              onChanged: (value) {
                                context
                                    .read<ThemeBloc>()
                                    .add(ToggleThemeEvent());
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: context.h(18)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        state is AuthAuthenticatedState
                            ? CircleAvatar(
                                radius: context.r(18),
                                backgroundImage: NetworkImage(
                                  state.data.imageUrl ??
                                      "https://via.placeholder.com/150",
                                ),
                              )
                            : CircleAvatar(
                                radius: context.r(18),
                              ),
                        SizedBox(width: context.w(18)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: context.w(150),
                              child: Text(
                                state is AuthAuthenticatedState
                                    ? state.data.name ?? "User"
                                    : "User",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: context.sp(18),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Text(
                              state is AuthAuthenticatedState
                                  ? state.data.email ?? ""
                                  : "",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: context.sp(18),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: context.h(1),
                      margin: EdgeInsets.symmetric(vertical: context.h(18)),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Akun Kamu",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: context.sp(18),
                          ),
                        ),
                        SizedBox(height: context.h(18)),
                        InkWell(
                          onTap: state is AuthAuthenticatedState
                              ? () {
                                  context.router.push(StreamingRoomRoute(
                                    isHost: true,
                                    liveID: '12345',
                                    userID: state.data.id.toString(),
                                    userName: state.data.name.toString(),
                                  ));
                                }
                              : () {},
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.person_rounded,
                                size: 30,
                              ),
                              SizedBox(width: context.w(18)),
                              Expanded(
                                child: Container(
                                  padding:
                                      EdgeInsets.only(bottom: context.h(18)),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : AppColors.cardBorder,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Ubah Profil",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: context.sp(18),
                                        ),
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: context.h(18)),
                        InkWell(
                          onTap: state is AuthAuthenticatedState
                              ? () {
                                  context.router.push(StreamingRoomRoute(
                                    isHost: false,
                                    liveID: '12345',
                                    userID: state.data.id.toString(),
                                    userName: state.data.name.toString(),
                                  ));
                                }
                              : () {},
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.lock_rounded,
                                size: 30,
                              ),
                              SizedBox(width: context.w(18)),
                              Expanded(
                                child: Container(
                                  padding:
                                      EdgeInsets.only(bottom: context.h(18)),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : AppColors.cardBorder,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Ubah Password",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: context.sp(18),
                                        ),
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: context.h(18)),
                        Text(
                          "Bantuan",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: context.sp(18),
                          ),
                        ),
                        SizedBox(height: context.h(18)),
                        InkWell(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.email_rounded,
                                size: 30,
                              ),
                              SizedBox(width: context.w(18)),
                              Expanded(
                                child: Container(
                                  padding:
                                      EdgeInsets.only(bottom: context.h(18)),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : AppColors.cardBorder,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Kontak Kami",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: context.sp(18),
                                        ),
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: context.h(18)),
                        InkWell(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.report_rounded,
                                size: 30,
                              ),
                              SizedBox(width: context.w(18)),
                              Expanded(
                                child: Container(
                                  padding:
                                      EdgeInsets.only(bottom: context.h(18)),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : AppColors.cardBorder,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Laporkan Masalah",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: context.sp(18),
                                        ),
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: context.h(18)),
                        Text(
                          "Lainnya",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: context.sp(18),
                          ),
                        ),
                        SizedBox(height: context.h(18)),
                        InkWell(
                          onTap: () {},
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.library_books_rounded,
                                size: 30,
                              ),
                              SizedBox(width: context.w(18)),
                              Expanded(
                                child: Container(
                                  padding:
                                      EdgeInsets.only(bottom: context.h(18)),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : AppColors.cardBorder,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Syarat & Ketentuan",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: context.sp(18),
                                        ),
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: context.h(18)),
                        InkWell(
                          onTap: () {
                            // context.router.replaceAll([SignInRoute()]);
                            context.read<AuthCubit>().logout();
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.logout_rounded,
                                size: 30,
                                color: Colors.red,
                              ),
                              SizedBox(width: context.w(18)),
                              Expanded(
                                child: Container(
                                  padding:
                                      EdgeInsets.only(bottom: context.h(18)),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : AppColors.cardBorder,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Keluar",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: context.sp(18),
                                          color: Colors.red,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 30,
                                        color: Colors.red,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

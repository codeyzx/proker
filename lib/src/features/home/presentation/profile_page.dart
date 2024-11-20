import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:proker/src/core/common/widgets/status_bar/status_bar_widget.dart';
import 'package:proker/src/core/config/router/app_router.dart';
import 'package:proker/src/core/config/themes/app_colors.dart';
import 'package:proker/src/core/utils/show_snackbar.dart';
import 'package:proker/src/features/auth/presentation/bloc/auth/auth_cubit.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLogoutSuccessState) {
            context.router.replaceAll([SignInRoute()]);
          } else if (state is AuthLogoutFailureState) {
            showSnackBar(context, Colors.red, state.message);
          }
        },
        child: BlocBuilder<AuthCubit, AuthState>(
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
                                  backgroundColor: Colors.grey,
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
                                    color: const Color(0xFF2C3E50),
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
                                  color: const Color(0xFF7F8C8D),
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
                        color: const Color(0xFFD5D8DC), // Shadow color
                        margin: EdgeInsets.symmetric(vertical: context.h(18)),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Akun Kamu",
                            style: TextStyle(
                              color: const Color(
                                  0xFF2C3E50), // Dark color for title
                              fontWeight: FontWeight.w700,
                              fontSize: context.sp(18),
                            ),
                          ),
                          SizedBox(height: context.h(18)),
                          InkWell(
                            onTap: () async {},
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.person_rounded,
                                  size: 30,
                                  color: Color(0xFFBDC3C7), // Light grey color
                                ),
                                SizedBox(width: context.w(18)),
                                Expanded(
                                  child: Container(
                                    padding:
                                        EdgeInsets.only(bottom: context.h(18)),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          width: 1,
                                          color:
                                              Color(0xFFBDC3C7), // Border color
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
                                            color: const Color(
                                                0xFF2C3E50), // Dark color for item
                                            fontWeight: FontWeight.w400,
                                            fontSize: context.sp(18),
                                          ),
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 30,
                                          color:
                                              AppColors.primary, // Splash color
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
                            onTap: () async {},
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.lock_rounded,
                                  size: 30,
                                  color: Color(0xFFBDC3C7), // Light grey color
                                ),
                                SizedBox(width: context.w(18)),
                                Expanded(
                                  child: Container(
                                    padding:
                                        EdgeInsets.only(bottom: context.h(18)),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          width: 1,
                                          color:
                                              Color(0xFFBDC3C7), // Border color
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
                                            color: const Color(
                                                0xFF2C3E50), // Dark color for item
                                            fontWeight: FontWeight.w400,
                                            fontSize: context.sp(18),
                                          ),
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 30,
                                          color:
                                              AppColors.primary, // Splash color
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
                              color: const Color(
                                  0xFF2C3E50), // Dark color for title
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
                                  color: Color(0xFFBDC3C7), // Light grey color
                                ),
                                SizedBox(width: context.w(18)),
                                Expanded(
                                  child: Container(
                                    padding:
                                        EdgeInsets.only(bottom: context.h(18)),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          width: 1,
                                          color:
                                              Color(0xFFBDC3C7), // Border color
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
                                            color: const Color(
                                                0xFF2C3E50), // Dark color for item
                                            fontWeight: FontWeight.w400,
                                            fontSize: context.sp(18),
                                          ),
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 30,
                                          color:
                                              AppColors.primary, // Splash color
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
                                  color: Color(0xFFBDC3C7), // Light grey color
                                ),
                                SizedBox(width: context.w(18)),
                                Expanded(
                                  child: Container(
                                    padding:
                                        EdgeInsets.only(bottom: context.h(18)),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          width: 1,
                                          color:
                                              Color(0xFFBDC3C7), // Border color
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
                                            color: const Color(
                                                0xFF2C3E50), // Dark color for item
                                            fontWeight: FontWeight.w400,
                                            fontSize: context.sp(18),
                                          ),
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 30,
                                          color:
                                              AppColors.primary, // Splash color
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
                              color: const Color(
                                  0xFF2C3E50), // Dark color for title
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
                                  color: Color(0xFFBDC3C7), // Light grey color
                                ),
                                SizedBox(width: context.w(18)),
                                Expanded(
                                  child: Container(
                                    padding:
                                        EdgeInsets.only(bottom: context.h(18)),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          width: 1,
                                          color:
                                              Color(0xFFBDC3C7), // Border color
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
                                            color: const Color(
                                                0xFF2C3E50), // Dark color for item
                                            fontWeight: FontWeight.w400,
                                            fontSize: context.sp(18),
                                          ),
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 30,
                                          color:
                                              AppColors.primary, // Splash color
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
                              context.read<AuthCubit>().logout();
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.logout_rounded,
                                  size: 30,
                                  color:
                                      Color(0xFFE74C3C), // Red color for logout
                                ),
                                SizedBox(width: context.w(18)),
                                Expanded(
                                  child: Container(
                                    padding:
                                        EdgeInsets.only(bottom: context.h(18)),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          width: 1,
                                          color:
                                              Color(0xFFBDC3C7), // Border color
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
                                            color: const Color(
                                                0xFFE74C3C), // Red color for item
                                            fontWeight: FontWeight.w400,
                                            fontSize: context.sp(18),
                                          ),
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 30,
                                          color: Color(
                                              0xFFE74C3C), // Red color for icon
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
      ),
    );
  }
}

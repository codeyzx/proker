import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.w(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30.r,
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(width: 14.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 220.w,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Username',
                              style: TextStyle(
                                color: const Color(
                                    0xFF2C3E50), // Dark color for name
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'example@mail.com',
                        style: TextStyle(
                          color:
                              const Color(0xFF7F8C8D), // Grey color for email
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Container(
                width: context.w(1.0),
                height: 0.6.h,
                color: const Color(0xFFD5D8DC), // Shadow color
              ),
              SizedBox(height: 18.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Akun Kamu",
                    style: TextStyle(
                      color: const Color(0xFF2C3E50), // Dark color for title
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 18.h),
                  InkWell(
                    onTap: () async {},
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.person_rounded,
                          color: Color(0xFFBDC3C7), // Light grey color
                        ),
                        SizedBox(width: 10.w),
                        Container(
                          width: context.w(0.8),
                          padding: EdgeInsets.only(bottom: 16.h),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: Color(0xFFBDC3C7), // Border color
                              ),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Ubah Profil",
                                style: TextStyle(
                                  color: const Color(
                                      0xFF2C3E50), // Dark color for item
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Color(0xFF3498DB), // Splash color
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 18.h),
                  InkWell(
                    onTap: () async {},
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.lock_rounded,
                          color: Color(0xFFBDC3C7), // Light grey color
                        ),
                        SizedBox(width: 10.w),
                        Container(
                          width: context.w(0.8),
                          padding: EdgeInsets.only(bottom: 16.h),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: Color(0xFFBDC3C7), // Border color
                              ),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Ubah Password",
                                style: TextStyle(
                                  color: const Color(
                                      0xFF2C3E50), // Dark color for item
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Color(0xFF3498DB), // Splash color
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    "Bantuan",
                    style: TextStyle(
                      color: const Color(0xFF2C3E50), // Dark color for title
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 18.h),
                  InkWell(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.email_rounded,
                          color: Color(0xFFBDC3C7), // Light grey color
                        ),
                        SizedBox(width: 10.w),
                        Container(
                          width: context.w(8.0),
                          padding: EdgeInsets.only(bottom: 16.h),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: Color(0xFFBDC3C7), // Border color
                              ),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Kontak Kami",
                                style: TextStyle(
                                  color: const Color(
                                      0xFF2C3E50), // Dark color for item
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Color(0xFF3498DB), // Splash color
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 18.h),
                  InkWell(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.report_rounded,
                          color: Color(0xFFBDC3C7), // Light grey color
                        ),
                        SizedBox(width: 10.w),
                        Container(
                          width: context.w(0.8),
                          padding: EdgeInsets.only(bottom: 16.h),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: Color(0xFFBDC3C7), // Border color
                              ),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Laporkan Masalah",
                                style: TextStyle(
                                  color: const Color(
                                      0xFF2C3E50), // Dark color for item
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Color(0xFF3498DB), // Splash color
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    "Lainnya",
                    style: TextStyle(
                      color: const Color(0xFF2C3E50), // Dark color for title
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 18.h),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.library_books_rounded,
                          color: Color(0xFFBDC3C7), // Light grey color
                        ),
                        SizedBox(width: 10.w),
                        Container(
                          width: context.w(0.8),
                          padding: EdgeInsets.only(bottom: 16.h),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: Color(0xFFBDC3C7), // Border color
                              ),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Syarat & Ketentuan",
                                style: TextStyle(
                                  color: const Color(
                                      0xFF2C3E50), // Dark color for item
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Color(0xFF3498DB), // Splash color
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 18.h),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.logout_rounded,
                          color: Color(0xFFE74C3C), // Red color for logout
                        ),
                        SizedBox(width: 10.w),
                        Container(
                          width: context.w(0.8),
                          padding: EdgeInsets.only(bottom: 16.h),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: Color(0xFFBDC3C7), // Border color
                              ),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Keluar",
                                style: TextStyle(
                                  color: const Color(
                                      0xFFE74C3C), // Red color for item
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Color(0xFFE74C3C), // Red color for icon
                              ),
                            ],
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
  }
}
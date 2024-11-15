import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:proker/core/config/router/app_router.dart';

@RoutePage()
class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.w(16),
          vertical: context.h(50),
        ),
        child: Stack(
          children: [
            // Back Button
            Padding(
              padding: EdgeInsets.only(top: context.h(12)),
              child: Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.all(context.w(8)),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFCCD1D6),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: context.sp(24),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Reset Password Text
                    Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Reset',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: context.sp(47),
                                color: const Color(0xFF04339B),
                              ),
                            ),
                            TextSpan(
                              text: ' Password',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: context.sp(47),
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.start,
                      ),

                    // Instruction Text
                    Padding(
                      padding: EdgeInsets.only(top: context.h(20)),
                      child: Text(
                        'Tolong masukkan email kamu untuk melakukan reset password.',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: context.sp(18),
                          color: const Color(0xFF747688),
                        ),
                      ),
                    ),
                    
                    // Email Text Field
                    Padding(
                      padding: EdgeInsets.only(top: context.h(24)),
                      child: Text(
                        'Email Kamu',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: context.sp(24),
                          color: const Color(0xFF001C34),
                        ),
                      ),
                    ), 

                    // Email Input
                    Padding(
                        padding: EdgeInsets.only(top: context.h(12)),
                        child: TextField(
                            decoration: InputDecoration(
                              labelText: 'abc@email.com',
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: context.sp(16),
                                color: const Color(0xFF747688),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: const Color(0xFF747688)),
                              ),
                              prefixIcon: const Icon(Icons.email),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                      ),

                    // Reset Button
                    Padding(
                      padding: EdgeInsets.only(top: context.h(40)),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            context.router.push(HomeRoute());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF04339B),
                            padding: EdgeInsets.all(context.h(16)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: Size(context.w(200), context.h(50)),
                          ),
                          child: Text(
                            'RESET PASSWORD',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: context.sp(16),
                              color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
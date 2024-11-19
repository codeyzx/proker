import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:proker/src/core/common/widgets/status_bar/status_bar_widget.dart';
import 'package:proker/src/core/config/injection/injectable.dart';
import 'package:proker/src/core/config/router/app_router.dart';
import 'package:proker/src/core/utils/show_snackbar.dart';
import 'package:proker/src/features/auth/presentation/bloc/auth/auth_cubit.dart';

@RoutePage()
class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  final emailCtr = TextEditingController(text: "admin@gmail.com");
  final pwdCtr = TextEditingController(text: "admin123");
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoginFailureState) {
            showSnackBar(context, Colors.red, state.message);
          } else if (state is AuthLoginSuccessState) {
            context.router.replaceAll([const HomeRoute()]);
          }
        },
        child: StatusBarWidget(
          brightness: Brightness.dark,
          child: Scaffold(
            body: Padding(
              padding: EdgeInsets.all(context.w(16)),
              child: Align(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        // Image HIMAKOM
                        padding: EdgeInsets.only(bottom: context.h(16)),
                        child: Image.asset(
                          'assets/images/himakom_logo.png',
                          height: context.h(150),
                        ),
                      ),
                      SizedBox(height: context.h(24)),

                      // Text "Masuk"
                      Padding(
                        padding: EdgeInsets.only(bottom: context.h(16)),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Masuk',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: context.sp(32),
                            ),
                          ),
                        ),
                      ),

                      // input email
                      TextFormField(
                        controller: emailCtr,
                        decoration: const InputDecoration(
                          labelText: 'abc@gmail.com',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: context.h(24)),

                      // input password
                      TextFormField(
                        controller: pwdCtr,
                        decoration: const InputDecoration(
                          labelText: 'Your password',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: context.h(18)),

                      // Text "Lupa Password?"

                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            context.router.push(const ResetPasswordRoute());
                          },
                          child: const Text(
                            'Lupa Password?',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      // Button for login
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          return Padding(
                            padding: EdgeInsets.only(top: context.h(40)),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  context.read<AuthCubit>().login(
                                        emailCtr.text,
                                        pwdCtr.text,
                                      );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF04339B),
                                  padding: EdgeInsets.all(context.h(16)),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  minimumSize:
                                      Size(context.w(200), context.h(50)),
                                ),
                                child: state.maybeMap(
                                  orElse: () => Text(
                                    'MASUK',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: context.sp(16),
                                      color: Colors.white,
                                    ),
                                  ),
                                  loginLoading: (e) =>
                                      const CircularProgressIndicator(),
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      // Button for forgot password
                      Padding(
                        padding: EdgeInsets.only(top: context.h(30)),
                        child: TextButton(
                          onPressed: () {
                            context.router.push(const SignUpRoute());
                          },
                          child: const Text('Lupa Password'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

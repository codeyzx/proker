import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:proker/src/core/common/widgets/status_bar/status_bar_widget.dart';
import 'package:proker/src/core/config/router/app_router.dart';
import 'package:proker/src/core/utils/show_snackbar.dart';
import 'package:proker/src/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:proker/src/features/auth/presentation/bloc/auth_login_form/auth_login_form_cubit.dart';

@RoutePage()
class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthLoginFormCubit(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoginFailureState) {
            showSnackBar(context, Colors.red, state.message);
          } else if (state is AuthAuthenticatedState) {
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
                      BlocBuilder<AuthLoginFormCubit, LoginFormState>(
                        builder: (context, state) {
                          return TextFormField(
                            onChanged: (value) => context
                                .read<AuthLoginFormCubit>()
                                .emailChanged(value),
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              prefixIcon: const Icon(Icons.email),
                              labelText: 'Your email',
                              labelStyle: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          );
                        },
                      ),
                      SizedBox(height: context.h(24)),
                      BlocBuilder<AuthLoginFormCubit, LoginFormState>(
                        builder: (context, state) {
                          return TextFormField(
                            onChanged: (value) => context
                                .read<AuthLoginFormCubit>()
                                .passwordChanged(value),
                            decoration: InputDecoration(
                              labelText: 'Your password',
                              labelStyle: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                              ),
                              border: const OutlineInputBorder(),
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(state.isObscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () => context
                                    .read<AuthLoginFormCubit>()
                                    .togglePasswordVisibility(),
                              ),
                            ),
                            obscureText: state.isObscureText,
                          );
                        },
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
                                        context
                                            .read<AuthLoginFormCubit>()
                                            .state
                                            .email,
                                        context
                                            .read<AuthLoginFormCubit>()
                                            .state
                                            .password,
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
                          child: const Text('Daftar Akun'),
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

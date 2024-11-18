import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proker/src/core/config/injection/injectable.dart';
import 'package:proker/src/core/config/router/app_router.dart';
import 'package:proker/src/core/config/themes/app_colors.dart';
import 'package:proker/src/core/utils/show_snackbar.dart';
import 'package:proker/src/features/auth/presentation/bloc/auth/auth_cubit.dart';

@RoutePage()
class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  final authCubit = getIt<AuthCubit>();

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
        child: Scaffold(
            appBar: AppBar(),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Please Login ! ",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text("Create an account so you can use this application")
                    ],
                  ),
                  const SizedBox(height: 30),
                  Column(
                    children: [
                      TextFormField(
                        controller: emailCtr,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Email",
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: pwdCtr,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Passpord",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Spacer(),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                        // return PrimaryButton(
                        //   onTap: () {
                        //     context.read<AuthCubit>().signInWithEmail(
                        //           emailCtr.text,
                        //           pwdCtr.text,
                        //         );
                        //   },
                        //   isLoading: state.maybeMap(
                        //     orElse: () => false,
                        //     loading: (e) => true,
                        //   ),
                        //   label: "Sign In",
                        // );
                        return ElevatedButton(
                          onPressed: () {
                            context
                                .read<AuthCubit>()
                                .login(emailCtr.text, pwdCtr.text);
                          },
                          child: state.maybeMap(
                            orElse: () => const Text("Sign In"),
                            loginLoading: (e) =>
                                const CircularProgressIndicator(),
                          ),
                        );
                      }),
                      const SizedBox(height: 20),
                      RichText(
                        text: TextSpan(
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              const TextSpan(text: "I don't have an account"),
                              const TextSpan(text: " "),
                              TextSpan(
                                text: "Sign Up",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context.replaceRoute(const SignUpRoute());
                                  },
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ]),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            )),
      ),
    );
  }
}

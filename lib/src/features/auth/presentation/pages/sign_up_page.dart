import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proker/src/core/config/injection/injectable.dart';
import 'package:proker/src/core/config/router/app_router.dart';
import 'package:proker/src/core/config/themes/app_colors.dart';
import 'package:proker/src/core/utils/show_snackbar.dart';
import 'package:proker/src/features/auth/presentation/bloc/auth/auth_cubit.dart';

@RoutePage()
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailCtr = TextEditingController(text: "admin@gmail.com");
  final nameCtr = TextEditingController(text: "Admin");
  final pwdCtr = TextEditingController(text: "admin123");
  final pwdConCtr = TextEditingController(text: "admin123");
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          // state.maybeMap(
          //   orElse: () {},
          //   loading: (e) {},
          //   error: (e) {
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       SnackBar(
          //         content: Text(e.errMsg),
          //         duration: const Duration(seconds: 5),
          //       ),
          //     );
          //   },
          //   success: (e) {
          //     getIt<AuthenticationCubit>().setCurrentUser(e.user);
          //     context.router.replaceAll([HomeRoute()]);
          //   },
          // );
          if (state is AuthRegisterFailureState) {
            showSnackBar(context, Colors.red, state.message);
          } else if (state is AuthRegisterSuccessState) {
            showSnackBar(context, Colors.green, "Register success");
            context.router.replaceAll([const HomeRoute()]);
          }
        },
        child: Scaffold(
          appBar: AppBar(),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create an account!",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text("Create an account so you can use this application")
                  ],
                ),
                const SizedBox(height: 30),
                Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameCtr,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Name can not be empty";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Name",
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: emailCtr,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email can not be empty";
                          }
                          final email = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value);
                          if (email == false) {
                            return "Email is not valid";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Email",
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: pwdCtr,
                        validator: (value) {
                          if (value == null || value.length < 6) {
                            return "Password min 6 chars";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Password",
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.length < 6) {
                            return "Password min 6 chars";
                          }
                          if (value != pwdCtr.text) {
                            return "Password doesn't match";
                          }
                          return null;
                        },
                        controller: pwdConCtr,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Password Confirmation",
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        // return PrimaryButton(
                        //   onTap: () {
                        //     if (formKey.currentState?.validate() == true) {
                        //       //do register
                        //       context.read<AuthCubit>().registerWithEmail(
                        //             emailCtr.text,
                        //             pwdConCtr.text,
                        //             nameCtr.text,
                        //           );
                        //     }
                        //   },
                        //   isLoading: state.maybeMap(
                        //     orElse: () => false,
                        //     loading: (e) => true,
                        //   ),
                        //   label: "Sign Up",
                        // );
                        return ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState?.validate() == true) {
                              context.read<AuthCubit>().register(
                                    email: emailCtr.text,
                                    password: pwdCtr.text,
                                    confirmPassword: pwdConCtr.text,
                                    name: nameCtr.text,
                                  );
                            }
                          },
                          child: state.maybeMap(
                            orElse: () => const Text("Sign Up"),
                            registerLoading: (e) =>
                                const CircularProgressIndicator(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                            child: Divider(
                          color: Colors.grey.shade400,
                          thickness: 1.5,
                        )),
                        const SizedBox(width: 20),
                        Text(
                          "Or Sign Up with",
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                            child: Divider(
                          color: Colors.grey.shade400,
                          thickness: 1.5,
                        )),
                      ],
                    ),
                    const SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            const TextSpan(text: "I already have an account"),
                            const TextSpan(text: " "),
                            TextSpan(
                              text: "Sign In",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.replaceRoute(SignInRoute());
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

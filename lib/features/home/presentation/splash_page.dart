import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChrome, SystemUiOverlayStyle;
import 'package:proker/core/config/router/app_router.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      // GoRouter.of(context).go('/');
      context.router.push(const HomeRoute());
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
    ));

    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(
            //   'assets/images/logo.png', // Replace with your logo path
            //   width: 150,
            //   height: 150,
            // ),
            SizedBox(height: 20),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Proker',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: 'Hub',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 40,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

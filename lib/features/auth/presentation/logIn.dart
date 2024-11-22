import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:proker/core/config/router/app_router.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  final ValueNotifier<bool> passwordNotifier = ValueNotifier<bool>(true);
 
  @override
  _LoginPageState createState() => _LoginPageState();
} 

class _LoginPageState extends State<LoginPage> {
  bool isObscureText = true; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body: Padding(
        padding: EdgeInsets.all(context.w(16)),
        child: Align(
          alignment: Alignment.bottomCenter,
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
                TextField(
                  decoration: InputDecoration(
                    labelText: 'abc@gmail.com',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: context.h(24)),

                // input password 
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Your password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          isObscureText = !isObscureText; // Password visibility
                        });
                      },
                      child: Icon(
                        isObscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    ),
                  ),
                  obscureText: isObscureText,
                ),SizedBox(height: context.h(18)),

                // Text "Lupa Password?"
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Lupa Password?',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                 // Button for login
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
                        'MASUK',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: context.sp(16),
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),

                // Button for forgot password
                Padding(
                  padding: EdgeInsets.only(top: context.h(30)),
                  child: TextButton(
                    onPressed: () {
                      context.router.push(SignupRoute());
                    },
                    child: Text('Lupa Password'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
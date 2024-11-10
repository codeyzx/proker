import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:proker/core/common/widgets/status_bar/status_bar_widget.dart';
import 'package:proker/core/config/router/app_router.dart';
import 'package:proker/core/config/themes/app_colors.dart';
import 'package:proker/gen/assets.gen.dart';

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
    _navigateToHome();
  }

  /// Navigate to the Home page after a delay
  void _navigateToHome() {
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      context.router.push(const HomeRoute());
    });
  }

  @override
  Widget build(BuildContext context) {
    return StatusBarWidget(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLogo(context),
              _buildSplashText(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Widget to build the logo with responsive width
  Widget _buildLogo(BuildContext context) {
    return Assets.images.appLogo.image(
      width: context.w(200), // Use ScreenUtil extension for width
      fit: BoxFit.fitWidth,
    );
  }

  /// Widget to build the splash text with responsive font size and shadows
  Widget _buildSplashText(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          _buildTextSpan('Proker', FontWeight.w800),
          _buildTextSpan('Hub', FontWeight.normal),
        ],
      ),
    );
  }

  /// Helper method to create a TextSpan with text shadow
  TextSpan _buildTextSpan(String text, FontWeight fontWeight) {
    return TextSpan(
      text: text,
      style: TextStyle(
        fontFamily: 'Manrope',
        fontSize:
            context.sp(40), // Responsive font size using ScreenUtil extension
        fontWeight: fontWeight,
        color: Colors.white, // Text color is white
        shadows: _textShadows, // Reused shadow style
      ),
    );
  }

  /// Common shadow effect used for both parts of the text
  List<Shadow> get _textShadows {
    return const [
      Shadow(color: Colors.black, offset: Offset(2, 2)),
      Shadow(color: Colors.black, offset: Offset(-2, -2)),
      Shadow(color: Colors.black, offset: Offset(2, -2)),
      Shadow(color: Colors.black, offset: Offset(-2, 2)),
    ];
  }
}

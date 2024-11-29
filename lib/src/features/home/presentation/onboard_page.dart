import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:proker/src/core/config/router/app_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

@RoutePage()
class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {

    bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(top: context.h(30)),
        child: PageView(
          controller: pageController,
          onPageChanged: (index) {
            if (index == 2) {
              setState(() {
                isLastPage = true;
              });
            }
          },
          children:  [
            OnboardingContent(
                imageAsset: "assets/images/himakom_logo.png",
                imageWidth: context.w(300),
                imageHeight: context.h(250),
                title: "Program Kerja Terbaru",
                subtitle:
                    "Temukan Program Kerja Terbaru yang tersedia melalui aplikasi ProkerHub"),
            OnboardingContent(
              imageAsset: "assets/images/himakom_logo.png",
              imageWidth: context.w(300),
              imageHeight: context.h(250),
              title: "Program Kerja Terpopuler",
              subtitle:
                  "Jelajahi Program kerja Terpopuler yang sedang berlangsung di HIMAKOM saat ini",
            ),
            OnboardingContent(
              imageAsset: "assets/images/himakom_logo.png",
              imageWidth: context.w(300),
              imageHeight: context.h(250),
              title: "Program Kerja Mendatang",
              subtitle:
                  "Dapatkan informasi Program Kerja yang akan datang dan akan dilaksanakan oleh HIMAKOM",
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.only(bottom: context.h(52), left: context.w(34), right: context.w(34)),
        height:context.h(170),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: SmoothPageIndicator(
                controller: pageController,
                count: 3,
                effect: ExpandingDotsEffect(
                  activeDotColor: const Color(0xFF04339B),
                  dotColor: const Color(0xFF04339B).withOpacity(0.30),
                  dotWidth: context.w(12),
                  dotHeight: context.h(12),
                ),
                onDotClicked: (index) => pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                ),
              ),
            ),
            isLastPage
                ? SizedBox(
                    width: context.w(320),
                    height: context.h(50),
                    child: ElevatedButton(
                      onPressed: () {
                        context.router.replaceAll([SignInRoute()]);
                      },
                      child: const Text("Gabung Sekarang"),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => pageController.jumpToPage(2),
                        child: const Text("Skip"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: const Text("Next"),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

class OnboardingContent extends StatelessWidget {
  final String imageAsset;
  final double imageWidth;
  final double imageHeight;
  final String title;
  final String subtitle;

  const OnboardingContent({
    super.key,
    required this.imageAsset,
    required this.imageWidth,
    required this.imageHeight,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: context.h(20.0)),
      child: Column(
        children: [
          Center(
            child: Image.asset(
              imageAsset,
              width: context.w(imageWidth),
              height: context.h(imageHeight),
            ),
          ),
          SizedBox(
            height: context.h(13.46),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height:context.h(25.0)),
          SizedBox(
            width: context.w(350),
            child: Text(
              subtitle,
              style: const TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

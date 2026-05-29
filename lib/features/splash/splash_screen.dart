import 'dart:async';

import 'package:dailycore/core/constants/App_Colors.dart';
import 'package:dailycore/core/constants/App_Text_Style.dart';
import 'package:dailycore/widget/custom_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          duration: Duration(milliseconds: 400),
          child: CustomBottomNavbar()
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.accentLight,
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/images/svg/splash_screen.svg",
                  width: 200,
                  height: MediaQuery.of(context).size.width,
                ),
                SizedBox(height: 20),
                Text(
                  "Daily Core",
                  style: AppTextStyles.display.copyWith(
                    color: AppColors.onPrimary,
                  ),
                ),
                Text(
                  "Stay Consistent, Stay Strong",
                  style: AppTextStyles.subheading.copyWith(
                    color: AppColors.onPrimary,
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

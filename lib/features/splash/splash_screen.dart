import 'dart:async';

import 'package:dailycore/core/constants/App_Colors.dart';
import 'package:dailycore/core/constants/App_Text_Style.dart';
import 'package:dailycore/features/auth/login_sreen.dart';
import 'package:dailycore/providers/auth_provider.dart';
import 'package:dailycore/widget/custom_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Use WidgetsBinding to wait until the build is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkLogin();
    });
  }

  Future<void> checkLogin() async {
    final auth = context.read<AuthProvider>();
    await auth.loadUser();

    await Future.delayed(const Duration(seconds: 2));

    if (auth.isLogin) {
      Timer(Duration(seconds: 2), () {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 400),
            child: CustomBottomNavbar(),
          ),
        );
      });
    } else {
      Timer(Duration(seconds: 2), () {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 400),
            child: LoginScreen(),
          ),
        );
      });
    }
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

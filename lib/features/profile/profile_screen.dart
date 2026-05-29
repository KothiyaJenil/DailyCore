import 'package:dailycore/core/constants/App_Text_Style.dart';
import 'package:dailycore/features/auth/login_sreen.dart';
import 'package:dailycore/widget/custom_app_bar.dart';
import 'package:dailycore/widget/heat_map_daily_tracker.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Profile",
        actions: [
          IconButton(
            onPressed: () async {
              // await authVm.logout();
              Navigator.pushReplacement(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: LoginScreen(),
                ),
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),

                  boxShadow: [
                    BoxShadow(
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                      color: Colors.black.withOpacity(0.08),
                    ),
                  ],
                ),

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("user.username", style: AppTextStyles.heading),
                              const SizedBox(height: 6),
                              Text("user.email", style: AppTextStyles.body),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    // divider
                    Container(height: 2, color: Colors.grey.shade500),
                    const SizedBox(height: 25),

                  ],
                ),
              ),
              SizedBox(height: 25,),
              Text("Your Daily Track", style: AppTextStyles.subheading,),
              SizedBox(height: 5,),
              HeatMapDailyTracker(),
            ],
          ),
        ),
      ),
    );
  }
}

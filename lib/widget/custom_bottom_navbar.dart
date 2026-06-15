import 'package:dailycore/core/constants/App_Colors.dart';
import 'package:dailycore/features/home/home_screen.dart';
import 'package:dailycore/features/profile/profile_screen.dart';
import 'package:dailycore/features/routine/routine_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBottomNavbar extends StatefulWidget {
  const CustomBottomNavbar({super.key});

  @override
  State<CustomBottomNavbar> createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar> {
    int _currentIndex = 1;
    final List<Widget> _screens = const [
      HomeScreen(),
      RoutineScreen(),
      ProfileScreen(),
    ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.primaryDark,
        unselectedItemColor: AppColors.textSecondary,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house),
            activeIcon: Icon(CupertinoIcons.house_fill),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.square_list),
            activeIcon: Icon(CupertinoIcons.square_list_fill),
            label: "Routine",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            activeIcon: Icon(CupertinoIcons.person_fill),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

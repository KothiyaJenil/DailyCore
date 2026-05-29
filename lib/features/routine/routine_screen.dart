import 'package:dailycore/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';

class RoutineScreen extends StatefulWidget {
  const RoutineScreen({super.key});

  @override
  State<RoutineScreen> createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Routine"),
      body: Center(child: Text("routine list"),),
      // floatingActionButton: FloatingButton(),
    );
  }
}

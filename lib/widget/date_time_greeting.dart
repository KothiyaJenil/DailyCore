import 'package:dailycore/core/constants/App_Text_Style.dart';
import 'package:flutter/material.dart';
import "package:intl/intl.dart";

(String, String) getGreeting(){
  final hour = DateTime.now().hour;
  String greeting;
  String date = DateFormat("EEEE, dd MMMM yyyy").format(DateTime.now());

  if (hour < 12) {
    greeting = "Good Morning";
  } else if (hour < 17) {
    greeting = "Good Afternoon";
  } else if (hour < 20) {
    greeting = "Good Evening";
  } else {
    greeting = "Good Night";
  }
  return (greeting, date);
}

class GreetingText extends StatelessWidget {
  const GreetingText({super.key});

  @override
  Widget build(BuildContext context) {
    // final user = context.read<AuthViewmodel>().currentUser!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: AppTextStyles.body, // Base style for the RichText
            children: [
              TextSpan(text: "${getGreeting().$1}, ", style: AppTextStyles.heading),
              TextSpan(
                text:
                "user.username", // Changed redundant greeting to a placeholder name
                style: AppTextStyles.subheading,
              ),
            ],
          ),
        ),
        SizedBox(height: 5 ,),
        Text(getGreeting().$2, style: AppTextStyles.body),
      ],
    );
  }
}

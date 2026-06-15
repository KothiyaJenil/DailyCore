import 'package:dailycore/core/constants/App_Colors.dart';
import 'package:dailycore/core/constants/App_Text_Style.dart';
import 'package:flutter/material.dart';


class CustomDaySelector extends StatefulWidget {
  final Function(List<int>) onChanged;
  const CustomDaySelector({super.key, required this.onChanged});

  @override
  State<CustomDaySelector> createState() => _CustomDaySelectorState();
}

class _CustomDaySelectorState extends State<CustomDaySelector> {

  final List<Map<String, dynamic>> days = [
    {"day": "mon", "value": 1},
    {"day": "tue", "value": 2},
    {"day": "wed", "value": 3},
    {"day": "thu", "value": 4},
    {"day": "fir", "value": 5},
    {"day": "sat", "value": 6},
    {"day": "sun", "value": 7},
  ];

  List<int> selectedDay = [];

  void toggleDay(int day){
    setState(() {
      if(selectedDay.contains(day)){
        selectedDay.remove(day);
      } else {
        selectedDay.add(day);
      }
      widget.onChanged(selectedDay);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: days.map((day) {
        bool isSelected = selectedDay.contains(day["value"]);
        return GestureDetector(
         onTap: () => toggleDay(day["value"]),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration:  BoxDecoration(
              color: isSelected ? AppColors.primaryLight : AppColors.card,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(color: Colors.grey.shade500, offset: const Offset(1, 1), blurRadius: 2)
              ]
            ),
            child: Text(day["day"], style: AppTextStyles.small.copyWith(color: isSelected ? Colors.white : Colors.black, fontWeight: isSelected ?  FontWeight.bold : FontWeight.normal)),
          ),
        );
      }).toList(),
    );
  }
}

import 'package:dailycore/core/constants/App_Colors.dart';
import 'package:flutter/material.dart';

// Input Text Field
class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final int maxLines;
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.labelText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.maxLines = 1,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(),
      ),
    );
  }
}

// TIme Input Field
class CustomTimeFormFiled extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelText;
  const CustomTimeFormFiled({
    super.key,
    required this.controller,
    this.labelText,
  });

  @override
  State<CustomTimeFormFiled> createState() => _CustomTimeFormFiledState();
}

class _CustomTimeFormFiledState extends State<CustomTimeFormFiled> {
  @override
  Widget build(BuildContext context) {
    Future<void> pickTime() async {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          widget.controller?.text = pickedTime.format(context);
        });
      }
    }

    return TextFormField(
      readOnly: true,
      controller: widget.controller,
      decoration: InputDecoration(
        label: Text(widget.labelText!),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "title is required";
        }
      },
      onTap: pickTime,
    );
  }
}



// Date Input Field
enum DayType {
  daily,
  weekdays,
  weekend,
  custom,
}

class CustomDayFormField extends StatefulWidget {
  const CustomDayFormField({super.key});

  @override
  State<CustomDayFormField> createState() => _CustomDayFormFieldState();
}

class _CustomDayFormFieldState extends State<CustomDayFormField> {
  final List<String> allDay = ["mon", "tue", "wed", "thu", "fri", "sat", "sun", ];

  List<String> selectedDays = [];


  DayType selectedOption = DayType.daily;

  void updateDays(DayType value) {
    setState(() {
      selectedOption = value;

      switch (value) {
        case DayType.daily:
          selectedDays = List.of(allDay);

          break;
        case DayType.weekdays:
          selectedDays = ["sun", "mon", "tue", "wed", "thu"];
          break;
        case DayType.weekend:
          selectedDays = ["sat", "sun"];
          break;
        case DayType.custom:
          selectedDays = [];
          break;
      }
    });
  }

  void selectCustomDay(String day) {
    if (selectedOption != "custom") return;

    setState(() {
      if (selectedDays.contains(day)) {
        selectedDays.remove(day);
      } else {
        selectedDays.add(day);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final RoutineViewmodel routineVm = Provider.of<RoutineViewmodel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<DayType>(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            label: Text("select day"),
          ),
          value: selectedOption,
          items: [
            DropdownMenuItem(value: DayType.daily, child: Text("daily")),
            DropdownMenuItem(value: DayType.weekdays, child: Text("Weekdays")),
            DropdownMenuItem(value: DayType.weekend, child: Text("Weekend")),
            DropdownMenuItem(value: DayType.custom, child: Text("Custom")),
          ],
          onChanged: (value){
            if(value != null){
              updateDays(value);
            }
          },
        ),
        SizedBox(height: 10,),
        Wrap(
          spacing: 20,
          children: allDay.map<Widget>((day) {
            final bool isSelectedDays = selectedDays.contains(day);
            return GestureDetector(
              onTap: () => selectCustomDay(day),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                padding: EdgeInsetsGeometry.symmetric(horizontal: 18, vertical: 10),
                margin: EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: isSelectedDays ? AppColors.onPrimary : AppColors.primary,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(day),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

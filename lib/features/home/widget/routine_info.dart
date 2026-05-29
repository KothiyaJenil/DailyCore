import 'package:flutter/material.dart';

class RoutineInfo extends StatelessWidget {
  final String title;
  final String value;
  const RoutineInfo({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
    children: [
      Text(
        value,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),

      const SizedBox(height: 5),

      Text(
        title,
        style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
      ),
    ],
  );
  }
}



// Widget routineInfo(String title, String value) {
//   return Column(
//     children: [
//       Text(
//         value,
//         style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//       ),
//
//       const SizedBox(height: 5),
//
//       Text(
//         title,
//         style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
//       ),
//     ],
//   );
// }

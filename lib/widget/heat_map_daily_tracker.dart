import 'package:dailycore/core/constants/App_Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class HeatMapDailyTracker extends StatefulWidget {
  const HeatMapDailyTracker({super.key});

  @override
  State<HeatMapDailyTracker> createState() => _HeatMapDailyTrackerState();
}

class _HeatMapDailyTrackerState extends State<HeatMapDailyTracker> {

  final Map<DateTime, int> datasets = {
    DateTime(2026, 5, 1): 1,
    DateTime(2026, 5, 2): 1,
    DateTime(2026, 5, 3): 1,
    DateTime(2026, 5, 4): 1,
  };

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: HeatMapCalendar(
          defaultColor: AppColors.card,
          colorMode: ColorMode.color,
          textColor: AppColors.textPrimary,
          weekTextColor: AppColors.textPrimary,
          showColorTip: false,
          monthFontSize: 16,
          weekFontSize: 12,
          flexible: true,
          datasets: datasets,
          colorsets: const {
            1: AppColors.accentLight,
            },
        ),
      ),
    );

  }
}

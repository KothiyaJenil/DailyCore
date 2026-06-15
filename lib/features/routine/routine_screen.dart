import 'package:dailycore/core/constants/App_Colors.dart';
import 'package:dailycore/core/constants/App_Text_Style.dart';
import 'package:dailycore/core/service/Routine_Service.dart';
import 'package:dailycore/data/model/routine_model.dart';
import 'package:dailycore/features/routine/widget/Floating_Button.dart';
import 'package:dailycore/widget/Custom_Scaffold_Messenger.dart';
import 'package:dailycore/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';

class RoutineScreen extends StatefulWidget {
  const RoutineScreen({super.key});

  @override
  State<RoutineScreen> createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  Future<void> refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Routine"),
      body: StreamBuilder<List<RoutineModel>>(
        stream: RoutineService().getRoutineStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Something wants wrong"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Add Routine"));
          }

          final routines = snapshot.data!;

          return RefreshIndicator(
            onRefresh: refreshData,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: routines.length,
                itemBuilder: (context, index) {
                  final routine = routines[index];
                  return GestureDetector(
                    onLongPressStart: (details) async {
                      final selected = await showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(
                          details.globalPosition.dx,
                          details.globalPosition.dy,
                          0,
                          0,
                        ), items: [
                        PopupMenuItem(value: "edit", child: Text("Edit")),
                        PopupMenuItem(value: "delete", child: Text("Delete")),
                      ],
                      );

                      if(selected == "delete"){
                        bool isDeleted = await RoutineService().deleteRoutine(routine.id!);
                        if (!mounted) return;
                        if(isDeleted){
                          CustomScaffoldMessenger.show(context: context, message: "Routine Deleted");
                        }
                      } else if(selected == "edit"){
                        print("edit");
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Card(
                        elevation: 5,
                        shadowColor: Colors.black54,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                routine.title,
                                style: AppTextStyles.subheading,
                              ),
                              subtitle: Text(
                                routine.time,
                                style: AppTextStyles.body,
                              ),
                              trailing: Text(
                                "pending",
                                style: AppTextStyles.body.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                            Divider(color: Colors.grey.shade500),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 16,
                                right: 16,
                                bottom: 8,
                              ),
                              child: _buildDays(routine.selectedDays, context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingButton(),
    );
  }
}

Widget _buildDays(List<int> selectedDays, BuildContext context) {
  List<String> days = ["mon", "tue", "wed", "thu", "fri", "sat", "sun"];

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: List.generate(days.length, (index) {
      int dayNumber = index + 1;
      bool isSelectedDays = selectedDays.contains(dayNumber);
      return Text(
        days[index],
        style: TextStyle(
          color: isSelectedDays ? AppColors.primaryLight : Colors.black,
          fontWeight: isSelectedDays ? FontWeight.bold : FontWeight.normal,
        ),
      );
    }),
  );
}

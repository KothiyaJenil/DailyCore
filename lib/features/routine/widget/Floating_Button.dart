import 'package:dailycore/core/service/Routine_Service.dart';
import 'package:dailycore/widget/custom_day_selector.dart';
import 'package:dailycore/widget/custom_form_widget.dart';
import 'package:dailycore/core/constants/App_Text_Style.dart';
import 'package:flutter/material.dart';

class FloatingButton extends StatefulWidget {
  const FloatingButton({super.key});

  @override
  State<FloatingButton> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _taskController = TextEditingController();

  List<int> selectedDays = [];
  List<String> tasks = [];

  Future<void> selectTime() async {
    TimeOfDay? pickeTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickeTime != null) {
      _timeController.text = pickeTime.format(context);
    }
  }

  void convertTasks() {
    setState(() {
      tasks = _taskController.text
          .split("\n")
          .where((tasks) => tasks.trim().isNotEmpty)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add, size: 35),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.vertical(
              top: Radius.circular(20),
            ),
          ),
          showDragHandle: true,
          builder: (context) {
            bool addRoutineTask = false;
            return StatefulBuilder(
              builder: (context, setStateBottomSheet) {
                return Padding(
                  padding: EdgeInsetsGeometry.all(16),
                  child: SingleChildScrollView(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsetsGeometry.only(bottom: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  CustomTextFormField(
                                    controller: _titleController,
                                    labelText: "title",
                                  ),
                                  SizedBox(height: 20),
                                  CustomTextFormField(
                                    onTap: selectTime,
                                    controller: _timeController,
                                    labelText: "time",
                                    readOnly: true,
                                  ),
                                  SizedBox(height: 15),
                                  CustomDaySelector(
                                    onChanged: (days) {
                                      selectedDays = days;
                                    },
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: addRoutineTask,
                                        onChanged: (value) {
                                          setStateBottomSheet(() {
                                            addRoutineTask = value!;
                                          });
                                          print(addRoutineTask.toString());
                                        },
                                      ),
                                      const Text(
                                        "Add Task",
                                        style: AppTextStyles.body,
                                      ),
                                    ],
                                  ),
                                  if (addRoutineTask)
                                    CustomTextFormField(
                                      controller: _taskController,
                                      hintText:
                                          "exercise\nstudy chapter\nroutine",
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 5,
                                    ),
                                  FilledButton(
                                    onPressed: () async {
                                      convertTasks();
                                      bool isAdded = await RoutineService()
                                          .addRoutine(
                                            title: _titleController.text,
                                            time: _timeController.text,
                                            selectedDays: selectedDays,
                                            tasks: tasks,
                                          );
                                      if(isAdded){
                                        print("data added");
                                        if(Navigator.canPop(context)){
                                          Navigator.pop(context);
                                        }
                                      } else {
                                        print("not added");
                                      }
                                      _titleController.clear();
                                      _timeController.clear();
                                      _taskController.clear();
                                      setState(() {
                                        selectedDays = [];
                                        tasks = [];
                                      });
                                      },
                                    child: Text("save"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

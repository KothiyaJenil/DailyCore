class RoutineModel {
  final String? id;
  final String? uid;
  final String title;
  final String time;
  final List<int> selectedDays;
  final List<String> tasks;

  RoutineModel({
    this.id,
    this.uid,
    required this.title,
    required this.time,
    required this.selectedDays,
    required this.tasks,
  });

  // Convert Model -> Map (Firebase)
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "uid": uid,
      "title": title,
      "time": time,
      "selectedDays": selectedDays,
      "tasks": tasks,
    };
  }

  // Convert Firebase Map -> Model
  factory RoutineModel.fromMap(
      Map<String, dynamic> map,
      ) {
    return RoutineModel(
      id: map["id"] ?? "",
      uid: map["uid"] ?? "",
      title: map["title"] ?? "",
      time: map["time"] ?? "",
      selectedDays: List<int>.from(
        map["selectedDays"] ?? [],
      ),
      tasks: List<String>.from(
        map["tasks"] ?? [],
      ),
    );
  }
  // Update specific values
  RoutineModel copyWith({
    String? id,
    String? uid,
    String? title,
    String? time,
    List<int>? selectedDays,
    List<String>? tasks,
  }) {
    return RoutineModel(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      title: title ?? this.title,
      time: time ?? this.time,
      selectedDays:
      selectedDays ?? this.selectedDays,
      tasks: tasks ?? this.tasks,
    );
  }
}
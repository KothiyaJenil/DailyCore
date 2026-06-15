import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dailycore/core/util/app_instance.dart';
import 'package:dailycore/data/model/routine_model.dart';

class RoutineService {
  final _firestore = AppInstance.firebaseFirestore;
  final _auth = AppInstance.firebaseAuth;

  String get uid => _auth.currentUser!.uid;

  Future<bool> addRoutine({
    required String title,
    required String time,
    required List<int> selectedDays,
    required List<String> tasks,
  }) async {
    try {
      final docRef = _firestore
          .collection("user")
          .doc(uid)
          .collection("routine")
          .doc();

      RoutineModel routine = RoutineModel(
        id: docRef.id,
        uid: uid,
        title: title,
        time: time,
        selectedDays: selectedDays,
        tasks: tasks,
      );

      await docRef.set(routine.toMap());

      print("data entered");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Stream<List<RoutineModel>> getRoutineStream() {
    return _firestore
        .collection("user")
        .doc(uid)
        .collection("routine")
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return RoutineModel.fromMap(doc.data());
          }).toList();
        });
  }

  Future<bool> deleteRoutine(String routineId) async {
    try{
      await _firestore.collection("user").doc(uid).collection("routine").doc(routineId).delete();
      return true;
    } catch (e){
      print(e);
      return false;
    }
  }
}

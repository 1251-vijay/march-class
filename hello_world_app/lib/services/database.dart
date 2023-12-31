import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_world_app/models/database_model.dart';

class DataBase {
  Future<String> uploadtoDatabase({
    required String name,
    required String age,
    required String location,
    required dynamic id,
  }) async {
    final FirebaseFirestore firebasestore = FirebaseFirestore.instance;
    EmployeeData employeeData =
        EmployeeData(name: name, age: age, location: location, id: id);
    String res = "error";

    try {
      await firebasestore
          .collection("Employee")
          .doc(id)
          .set(employeeData.tojson());
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<Stream<QuerySnapshot>> getdetailsfirebase() async {
    return await FirebaseFirestore.instance.collection("Employee").snapshots();
  }

  Future updatevalues({
    required String name,
    required String age,
    required String location,
    required dynamic id,
  }) async {
    EmployeeData employee =
        EmployeeData(name: name, age: age, location: location, id: id);
    return await FirebaseFirestore.instance
        .collection("Employee")
        .doc(id)
        .update(employee.tojson());
  }

  Future deletevalues({
    required dynamic id,
  }) async {
    return await FirebaseFirestore.instance
        .collection("Employee")
        .doc(id)
        .delete();
  }
}

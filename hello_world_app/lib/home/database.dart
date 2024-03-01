import 'package:cloud_firestore/cloud_firestore.dart';

import 'models.dart';

class DataBase {
  FirebaseFirestore storage = FirebaseFirestore.instance;

  getdata({
    required String username,
    required String number,
    required String age,
    required dynamic id,
    required String location,
  }) async {
    try {
      DataBaseModel dataBaseModel = DataBaseModel(
          username: username,
          number: number,
          location: location,
          age: age,
          id: id);
      await storage.collection("user").doc(id).set(dataBaseModel.tojson());
    } catch (err) {
      return err.toString();
    }
  }

  Future<Stream<QuerySnapshot>> getdetails() async {
    return await storage.collection("user").snapshots();
  }
}

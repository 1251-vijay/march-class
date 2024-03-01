import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/models/auth_models.dart';

class Auth {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore storage = FirebaseFirestore.instance;
  Future<String> signup({
    required String username,
    required String email,
    required String phonenumber,
    required String password,
  }) async {
    String res = "An internal occured";
    try {
      UserCredential cred = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      AuthModel authModel = AuthModel(
          username: username,
          uid: cred.user!.uid,
          phonenumber: phonenumber,
          email: email,
          password: password);
      await storage
          .collection("Users")
          .doc(cred.user!.uid)
          .set(authModel.tojson());
    } catch (err) {
      return err.toString();
    }
    return res;
  }
}

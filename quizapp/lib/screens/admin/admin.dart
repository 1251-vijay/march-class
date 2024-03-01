import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/screens/admin/home.dart';

class AdminPannel extends StatefulWidget {
  const AdminPannel({super.key});

  @override
  State<AdminPannel> createState() => _AdminPannelState();
}

class _AdminPannelState extends State<AdminPannel> {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Admin Pannel"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: username,
              decoration: const InputDecoration(
                  isDense: true,
                  hintText: "username",
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: password,
              decoration: const InputDecoration(
                  isDense: true,
                  hintText: "password",
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  login();
                },
                child: const Text("Login"))
          ],
        ),
      ),
    );
  }

  login() {
    FirebaseFirestore.instance.collection("admin").get().then((value) {
      value.docs.forEach((element) {
        if (element.data()["id"] != username.text.trim) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("incorrect username")));
        } else if (element.data()["password"] != password.text.trim()) {
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const AddQuiz()));
        }
      });
    });
  }
}

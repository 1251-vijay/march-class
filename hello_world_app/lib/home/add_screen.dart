import 'package:flutter/material.dart';
import 'package:hello_world_app/home/database.dart';
import 'package:random_string/random_string.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final TextEditingController usernamecontroller = TextEditingController();
  final TextEditingController agecontroller = TextEditingController();
  final TextEditingController locationcontroller = TextEditingController();
  final TextEditingController numbercontroller = TextEditingController();
  @override
  void dispose() {
    usernamecontroller.dispose();
    agecontroller.dispose();
    locationcontroller.dispose();
    numbercontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Add",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 22,
              ),
            ),
            Text(
              "Data",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.amber,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "  Name",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
              TextField(
                controller: usernamecontroller,
                decoration: InputDecoration(
                    hintText: "Enter Name",
                    isDense: true,
                    contentPadding: const EdgeInsets.all(15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "  Age",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
              TextField(
                controller: agecontroller,
                decoration: InputDecoration(
                    hintText: " Enter age",
                    isDense: true,
                    contentPadding: const EdgeInsets.all(15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "  Location",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
              TextField(
                controller: locationcontroller,
                decoration: InputDecoration(
                    hintText: "Location",
                    isDense: true,
                    contentPadding: const EdgeInsets.all(15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "  Mobile Number",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
              TextField(
                controller: numbercontroller,
                decoration: InputDecoration(
                    hintText: "Enter number",
                    isDense: true,
                    contentPadding: const EdgeInsets.all(15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  addData();
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                      child: Text(
                    "Add",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  addData() async {
    Navigator.pop(context);
    final id = randomAlpha(10);
    await DataBase().getdata(
        username: usernamecontroller.text.trim(),
        number: numbercontroller.text.trim(),
        age: agecontroller.text.trim(),
        id: id,
        location: locationcontroller.text.trim());
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Successfully added")));
  }
}

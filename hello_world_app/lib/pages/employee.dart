import 'package:flutter/material.dart';
import 'package:hello_world_app/services/database.dart';
import 'package:hello_world_app/widgets/texrfield.dart';
import 'package:random_string/random_string.dart';

class Employee extends StatefulWidget {
  const Employee({super.key});

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController agecontroller = TextEditingController();
  final TextEditingController locationcontroller = TextEditingController();
  @override
  void dispose() {
    namecontroller.dispose();
    agecontroller.dispose();
    locationcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Employee",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[200]),
            ),
            Text(
              "Form",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[200]),
            )
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "  Name",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            TextFieldCommon(
              controller: namecontroller,
              hintText: "Name",
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "  Age",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            TextFieldCommon(
              controller: agecontroller,
              hintText: "Age",
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "  Location",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            TextFieldCommon(
              controller: locationcontroller,
              hintText: "Location",
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () async {
                    String id = randomAlphaNumeric(10);
                    Navigator.pop(context);

                    await DataBase().uploadtoDatabase(
                        name: namecontroller.text,
                        age: agecontroller.text,
                        location: locationcontroller.text,
                        id: id);
                  },
                  child: const Text(
                    "Add",
                  )),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hello_world_app/pages/employee.dart';
import 'package:hello_world_app/services/database.dart';
import 'package:hello_world_app/widgets/texrfield.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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

  Stream? employeestream;
  getload() async {
    employeestream = await DataBase().getdetailsfirebase();
    setState(() {});
  }

  @override
  void initState() {
    getload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Flutter",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[200]),
            ),
            Text(
              "Firebase",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[200]),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const Employee()));
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder(
          stream: employeestream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    final ds = snapshot.data.docs[index];
                    return Container(
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 30),
                      child: Column(
                        children: [
                          Material(
                            elevation: 8,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              margin: const EdgeInsets.only(left: 20),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Name : ' + ds['name'],
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.blue[200],
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Spacer(),
                                      InkWell(
                                        onTap: () {
                                          editDetailsscreen(ds['id']);
                                          namecontroller.text = ds["name"];
                                          agecontroller.text = ds["age"];
                                          locationcontroller.text =
                                              ds["location"];
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.amber,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          await DataBase()
                                              .deletevalues(id: ds["id"]);
                                        },
                                        child: const Icon(Icons.delete),
                                      )
                                    ],
                                  ),
                                  Text(
                                    "Age : " + ds["age"],
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.orange[200],
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Location : " + ds["location"],
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.blue[200],
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ),
              );
            }
          }),
    );
  }

  Future editDetailsscreen(String id) => showDialog(
      context: context,
      builder: (_) => AlertDialog(
            content: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.cancel),
                      ),
                      const SizedBox(
                        width: 60,
                      ),
                      Text(
                        "Update",
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
                          Navigator.pop(context);
                          await DataBase().updatevalues(
                              name: namecontroller.text,
                              age: agecontroller.text,
                              location: locationcontroller.text,
                              id: id);
                        },
                        child: const Text(
                          "Update",
                        )),
                  )
                ],
              ),
            ),
          ));
}

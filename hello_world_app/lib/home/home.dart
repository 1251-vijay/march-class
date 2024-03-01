import 'package:flutter/material.dart';
import 'package:hello_world_app/home/add_screen.dart';
import 'package:hello_world_app/home/database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Stream? employestream;
  getloaddetails() async {
    employestream = await DataBase().getdetails();
    setState(() {});
  }

  @override
  void initState() {
    getloaddetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const AddScreen()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Flutter",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 22,
              ),
            ),
            Text(
              "Firebase",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.amber,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder(
          stream: employestream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: ((context, index) {
                    final ds = snapshot.data.docs[index];
                    return Container(
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Column(
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(20),
                            elevation: 5,
                            child: Container(
                              margin: EdgeInsets.only(left: 20, right: 20),
                              padding: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name : " + ds["username"],
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.blue[300],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "age : " + ds["age"],
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.amber[400],
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }));
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.amber[200],
                ),
              );
            }
          }),
    );
  }
}

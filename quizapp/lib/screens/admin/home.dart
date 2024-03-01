import 'package:flutter/material.dart';

class AddQuiz extends StatefulWidget {
  const AddQuiz({super.key});

  @override
  State<AddQuiz> createState() => _AddQuizState();
}

class _AddQuizState extends State<AddQuiz> {
  final TextEditingController option1 = TextEditingController();
  final TextEditingController option2 = TextEditingController();
  final TextEditingController option3 = TextEditingController();
  final TextEditingController option4 = TextEditingController();
  final TextEditingController correct = TextEditingController();
  String? vlaue;
  final List<String> quizitems = ["Animal", "Sports", "Random", "Fruits"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          CircleAvatar(
            radius: 70,
            backgroundColor: Colors.black,
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: option1,
            decoration: const InputDecoration(
                isDense: true,
                hintText: "password",
                border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: option2,
            decoration: const InputDecoration(
                isDense: true,
                hintText: "password",
                border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: option3,
            decoration: const InputDecoration(
                isDense: true,
                hintText: "password",
                border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: option4,
            decoration: const InputDecoration(
                isDense: true,
                hintText: "password",
                border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: correct,
            decoration: const InputDecoration(
                isDense: true,
                hintText: "password",
                border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Color(0xFFececf8),
                borderRadius: BorderRadius.circular(20)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                onChanged: (value) {
                  setState(() {
                    this.vlaue = value;
                  });
                },
                items: quizitems
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(
                          e,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                        ),
                      ),
                    )
                    .toList(),
                dropdownColor: Colors.white,
                value: vlaue,
                hint: Text("categoriey"),
              ),
            ),
          ),
          ElevatedButton(onPressed: () {}, child: const Text("Add"))
        ],
      ),
    );
  }
}

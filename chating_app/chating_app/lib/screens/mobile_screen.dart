// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chating_app/features/auth/controller/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:chating_app/features/select_contact/screens/select_screen.dart';
import 'package:chating_app/screens/chat_screen.dart';
import 'package:chating_app/wigets/contact_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MobileScreen extends ConsumerStatefulWidget {
  const MobileScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends ConsumerState<MobileScreen>
    with WidgetsBindingObserver {
  final nameController = TextEditingController();
  bool isShown = false;
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        ref.read(authControllerProvider).userIsonlineOrOffline(true);
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        ref.read(authControllerProvider).userIsonlineOrOffline(false);
      default:
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ContactScreen()));
                },
                icon: const Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_horiz,
                  color: Colors.white,
                  size: 30,
                ))
          ],
          backgroundColor: Colors.black,
          title: const Text(
            "Chats",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
            child: SizedBox(
              height: 40,
              child: TextFormField(
                // onFieldSubmitted: (_) {
                //   setState(() {
                //     isShown = true;
                //   });
                // },
                onChanged: (val) {
                  if (val.isEmpty) {
                    // Navigator.pop(context);
                    setState(() {
                      isShown = false;
                    });
                  } else {
                    setState(() {
                      isShown = true;
                    });
                  }
                },
                controller: nameController,
                decoration: const InputDecoration(
                    // isCollapsed: true,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: "Search",
                    // isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: Color.fromRGBO(29, 31, 31, 1)),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          isShown
              ? FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  future: FirebaseFirestore.instance
                      .collection("users")
                      .where("name",
                          isGreaterThanOrEqualTo: nameController.text)
                      .get(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Expanded(
                      child: ListView.builder(
                          itemCount: (snapshot.data! as dynamic).docs.length,
                          itemBuilder: ((context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ChatScreen(
                                            message: (snapshot.data! as dynamic)
                                                .docs[index]["name"],
                                            uid: (snapshot.data! as dynamic)
                                                .docs[index]["uid"])));
                              },
                              child: ListTile(
                                title: Text((snapshot.data! as dynamic)
                                    .docs[index]["name"]
                                    .toString()),
                                leading: CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage(
                                      (snapshot.data! as dynamic)
                                          .docs[index]["profilePic"]
                                          .toString()),
                                ),
                              ),
                            );
                          })),
                    );
                  })
              : const Expanded(child: ContactList())
        ])));
  }
}

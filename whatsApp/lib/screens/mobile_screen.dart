import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/common/utlis/colors.dart';
import 'package:whatsapp/features/auth/controllers/auth_contoller.dart';
import 'package:whatsapp/features/selecet_contacts/screens/select_screen.dart';
import 'package:whatsapp/widgets/contact_list.dart';

class MobileScreen extends ConsumerStatefulWidget {
  const MobileScreen({super.key});

  @override
  ConsumerState<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends ConsumerState<MobileScreen>
    with WidgetsBindingObserver {
  final name = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        ref.read(authController).setuserState(true);
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
        ref.read(authController).setuserState(false);
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  TextField(
                    controller: name,
                  );
                },
                icon: const Icon(
                  Icons.search,
                  color: greyColor,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert,
                  color: greyColor,
                ))
          ],
          title: const Text(
            "WhatsApp",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: greyColor),
          ),
          bottom: const TabBar(
              unselectedLabelColor: greyColor,
              indicatorColor: tabColor,
              labelColor: tabColor,
              indicatorWeight: 4,
              labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              tabs: [
                Tab(
                  text: "chats",
                ),
                Tab(
                  text: "status",
                ),
                Tab(
                  text: "calls",
                ),
              ]),
        ),
        body: const ContactList(),
        floatingActionButton: FloatingActionButton(
            backgroundColor: messageColor,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const SelectScreen()));
            },
            child: const Icon(
              Icons.comment,
              color: greyColor,
            )),
      ),
    );
  }
}

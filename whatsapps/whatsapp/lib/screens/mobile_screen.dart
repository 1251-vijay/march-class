import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/common/utils/colors.dart';
import 'package:whatsapp/features/chat/controller/chat_controller.dart';
import 'package:whatsapp/features/select_contacts/select_contact_screen.dart';
import 'package:whatsapp/widgets/contact_list.dart';

class MobileScreen extends ConsumerStatefulWidget {
  const MobileScreen({super.key});

  @override
  ConsumerState<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends ConsumerState<MobileScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        ref.read(chatController).setUserData(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
        ref.read(chatController).setUserData(false);
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          title: const Text(
            "WhatsApp",
            style: TextStyle(color: Colors.grey, fontSize: 20),
          ),
          actions: const [
            Icon(
              Icons.search,
              color: Colors.grey,
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.more_vert,
              color: Colors.grey,
            )
          ],
          bottom: const TabBar(
              indicatorColor: tabColor,
              unselectedLabelColor: Colors.grey,
              labelColor: tabColor,
              indicatorWeight: 4,
              labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              tabs: [
                Tab(
                  child: Text(" Chats"),
                ),
                Tab(
                  child: Text(" Status"),
                ),
                Tab(
                  child: Text("Calls"),
                )
              ]),
        ),
        body: const ContactList(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: messageColor,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (builder) => const SelectContactScreen()));
          },
          child: const Icon(Icons.message),
        ),
      ),
    );
  }
}

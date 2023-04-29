import 'package:flutter/material.dart';
import 'package:whp/screens/status_screen.dart';
import '../Chat_Widgets/chatscreen.dart';
import '../Contacts/contact_screen.dart';
import 'calls_screen.dart';
import 'camera_screen.dart';

class MyHomePage extends StatefulWidget {
  static const String routeName = 'myHomepage';
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  double yourWidth = 70;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("V- Chat",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        actions: const [
          Icon(Icons.search),
          Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
          Icon(Icons.more_vert),
          Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
        ],
        backgroundColor: const Color(0xff075E54),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: <Widget>[
            Container(
              height: 50,
              width: 30,
              alignment: Alignment.center,
              child: const Icon(
                Icons.camera_alt,
              ),
            ),
            Container(
                width: yourWidth,
                height: 50,
                alignment: Alignment.center,
                child: const Text(
                  "Chats",
                  style: TextStyle(fontSize: 17),
                )),
            Container(
                width: yourWidth,
                height: 50,
                alignment: Alignment.center,
                child: const Text(
                  "Status",
                  style: TextStyle(fontSize: 17),
                )),
            Container(
                width: yourWidth,
                height: 50,
                alignment: Alignment.center,
                child: const Text(
                  "Calls",
                  style: TextStyle(fontSize: 17),
                )),
          ],
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          indicatorSize: TabBarIndicatorSize.label,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          CameraScreen(),
          ChatScreen(),
          StatusScreen(),
          CallsScreen()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, ContactScreen.routeName);
        },
        backgroundColor: Colors.green.withRed(70),
        child: const Icon(
          Icons.message_outlined,
        ),
      ),
    );
  }
}

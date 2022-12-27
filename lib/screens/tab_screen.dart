import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_app/screens/chat/chat_screen.dart';
import 'package:siakad_app/screens/home/home_screen.dart';
import 'package:siakad_app/screens/notif/notif_screen.dart';
import 'package:siakad_app/screens/profile/profile_screen.dart';
import 'package:siakad_app/test.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _setectedIndex = 0;

  String dataku = 'anying';

  final tabs = [
    const HomeScreen(),
    const ChatScreen(),
    const NotifScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_setectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 5,
              offset: const Offset(5, 0), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            buildNavigationItem(
                0, 'assets/icons/home-active.png', 'assets/icons/home.png'),
            buildNavigationItem(
                1, 'assets/icons/chat-active.png', 'assets/icons/chat.png'),
            buildNavigationItem(
                2, 'assets/icons/notif-active.png', 'assets/icons/notif.png'),
            buildNavigationItem(3, 'assets/icons/profile-active.png',
                'assets/icons/profile.png'),
          ],
        ),
      ),
    );
  }

  Widget buildNavigationItem(int index, String image1, String image2) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _setectedIndex = index;
        });
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image.asset(
            index == _setectedIndex ? image1 : image2,
          ),
        ),
        // child: Text(dataku),
        height: 65,
        width: MediaQuery.of(context).size.width / 4,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
      ),
    );
  }
}

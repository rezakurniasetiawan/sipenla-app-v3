import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_app/screens/chat/component/chat_llist.dart';
import 'package:siakad_app/screens/chat/component/contact_list.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String? firstName, lastName, photoProfile;
  String role = '';

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      role = preferences.getString("role")!;
      firstName = preferences.getString("first_name");
      lastName = preferences.getString("last_name");
      photoProfile = preferences.getString("photoUser");
    });
  }

  @override
  void initState() {
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          role == 'admin' ? 'Pesan' : 'Layanan Pengguna',
          style: const TextStyle(
            fontSize: 20,
            color: Color(0xff4B556B),
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Color(0xff4B556B),
        ),
      ),
      body: (role == '')
          ? Column(
              children: const [
                Expanded(
                    child: Center(
                  child: CircularProgressIndicator(color: Color(0xff4B556B)),
                ))
              ],
            )
          : (role == 'admin')
              ? ContactListAdmin(
                  role: role,
                )
              : ChatList(
                  role: role,
                  nameRoom: '',
                  idRoomAdmin: '',
                ),
    );
  }
}

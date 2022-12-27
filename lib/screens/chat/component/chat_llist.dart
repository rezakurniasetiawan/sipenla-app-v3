import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:siakad_app/services/chat_service.dart';

import '../../../constan.dart';
import '../../../models/api_response_model.dart';
import '../../../models/chat_model.dart';
import '../../../services/auth_service.dart';
import 'package:http/http.dart' as http;

class ChatList extends StatefulWidget {
  const ChatList(
      {Key? key,
      required this.role,
      required this.nameRoom,
      required this.idRoomAdmin})
      : super(key: key);

  final String role, nameRoom, idRoomAdmin;

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  StreamController<List<dynamic>> _streamController = StreamController();

  TextEditingController chatFrom = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _needsScroll = false;

  Timer? _timer;

  Future listChat({required int idRooms}) async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(baseURL + '/api/chat/chat/$idRooms'),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
    );
    print(response.statusCode);
    List<dynamic> dataChat = jsonDecode(response.body)['data'];
    _streamController.add(dataChat);
  }

  int idRoom = 0;
  Future getIdRoom() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(baseURL + '/api/chat/roomuser'),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      int jsonData = json.decode(response.body)['data']['room_id'];
      setState(() {
        idRoom = jsonData;
        print(idRoom);
        setState(() {
          _timer = Timer.periodic(
              const Duration(seconds: 2),
              (timer) => listChat(
                  idRooms: widget.role == 'admin'
                      ? int.parse(widget.idRoomAdmin)
                      : idRoom));
        });
      });
    }
  }

  void fungsipostChat() async {
    ApiResponse response = await postChat(
        message: chatFrom.text,
        roomId:
            widget.role == 'admin' ? widget.idRoomAdmin : idRoom.toString());
    if (response.error == null) {
      setState(() {
        fungsiUpdtaepostChat();
      });
    }
  }

  void fungsiUpdtaepostChat() async {
    ApiResponse response = await updatePostChat(
        message: chatFrom.text,
        idRoom: widget.role == 'admin' ? widget.idRoomAdmin : idRoom.toString(),
        status: widget.role == 'admin' ? 'tidak' : 'ada');
    if (response.error == null) {
      chatFrom.clear();
      // _scrollToEnd();
    }
  }

  String handleNull = '';

  // _scrollToEnd() async {
  //   _scrollController.animateTo(_scrollController.position.maxScrollExtent,
  //       duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
  // }

  @override
  void initState() {
    super.initState();
    if (widget.role != 'admin') {
      getIdRoom();
    }
    if (widget.role == 'admin') {
      print('jalankan');
      _timer = Timer.periodic(
          const Duration(seconds: 2),
          (timer) => listChat(
              idRooms: widget.role == 'admin'
                  ? int.parse(widget.idRoomAdmin)
                  : idRoom));
    }
  }

  @override
  void dispose() {
    if (_timer!.isActive) _timer!.cancel();
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            widget.role == 'admin'
                ? SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const SizedBox(
                                height: 50,
                                width: 50,
                                child: Icon(Icons.arrow_back)),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.nameRoom,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Color(0xff4B556B),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox(),
            // Expanded(
            //   child: ListView(
            //     padding: const EdgeInsets.all(20),
            //     children: List.generate(
            //       messages.length,
            //       (index) {
            //         return MessageBox(
            //           image: messages[index]['profileImg'],
            //           isMe: messages[index]['isMe'],
            //           message: messages[index]['message'],
            //         );
            //       },
            //     ),
            //   ),
            // ),
            Expanded(
              child: StreamBuilder<List<dynamic>>(
                stream: _streamController.stream,
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    final list = snapshot.data as List<dynamic>;
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      if (_scrollController.hasClients) {
                        _scrollController.animateTo(
                            _scrollController.position.maxScrollExtent,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                      }
                    });
                    return ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: list.length,
                      controller: _scrollController,
                      itemBuilder: (BuildContext context, int index) {
                        return MessageBox(
                          // image: list[index]['profileImg'],
                          isMe: list[index]['isMe'],
                          message: list[index]['message'],
                        );
                      },
                    );
                  } else if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (!snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    return Text('No Posts');
                  } else {
                    return Center(child: Text('No Data'));
                  }
                },
              ),
            ),
            // ignore: avoid_unnecessary_containers
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 60,
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: const Color(0xff2E447C),
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Center(
                                  child: TextFormField(
                                    controller: chatFrom,
                                    cursorColor: Colors.black,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Ketik Pesan",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 7),
                          GestureDetector(
                            onTap: () {
                              // _scrollController.animateTo(
                              //     _scrollController.position.maxScrollExtent,
                              //     duration: Duration(milliseconds: 200),
                              //     curve: Curves.bounceIn);
                              if (chatFrom.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Pesan tidak boleh kosong')));
                              } else {
                                fungsipostChat();
                              }
                            },
                            child: Container(
                              height: 45,
                              width: 45,
                              // color: Colors.blue,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: const Offset(
                                        2, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.send,
                                color: Color(0xff2E447C),
                                size: 20,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChatNull extends StatelessWidget {
  const ChatNull({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 132,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xff4B556B4D),
          width: 1.5,
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          '<>Pesan ini terhubung langsung dengan pelayanan customer service. Pesan anda akan kami balas saat jam oprasional senin-jum’at pukul 08.00 - 16.00<>',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xff4B556B4D),
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      width: MediaQuery.of(context).size.width,
    );
  }
}

class MessageBox extends StatelessWidget {
  const MessageBox(
      {Key? key,
      // required this.image,
      required this.isMe,
      required this.message})
      : super(key: key);

  final bool isMe;
  final String message;
  // final String image;

  @override
  Widget build(BuildContext context) {
    if (isMe) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: FractionalOffset.centerLeft,
                    end: FractionalOffset.centerRight,
                    colors: [
                      Color(0xff2E447C),
                      Color(0xff3774C3),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(
                    message,
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ),
            ),
            // Container(
            //   height: 30,
            //   width: 30,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(12),
            //       image: DecorationImage(
            //           image: AssetImage(image), fit: BoxFit.cover)),
            // ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(
                    message,
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:siakad_app/screens/chat/component/chat_llist.dart';
import 'package:siakad_app/services/chat_service.dart';

import '../../../constan.dart';
import '../../../models/api_response_model.dart';
import '../../../models/chat_model.dart';
import '../../../services/auth_service.dart';
import 'package:http/http.dart' as http;

class ContactListAdmin extends StatefulWidget {
  const ContactListAdmin({
    Key? key,
    required this.role,
  }) : super(key: key);

  final String role;

  @override
  State<ContactListAdmin> createState() => _ContactListAdminState();
}

class _ContactListAdminState extends State<ContactListAdmin> {
  StreamController<List<dynamic>> _streamController = StreamController();

  Timer? _timer;

  Future listRoom() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(baseURL + '/api/chat/room'),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
    );
    print(response.statusCode);
    List dataChat = jsonDecode(response.body)['data'];
    if (response.statusCode == 200) {
      _streamController.add(dataChat);
    }
  }

  void fungsiupdateReadAdmin({required String idRoom}) async {
    ApiResponse response = await updateReadAdmin(
        idRoom: idRoom, status: widget.role == 'admin' ? 'tidak' : 'ada');
    if (response.error == null) {
      print('sukses');
    }
  }
  // bool _loading = true;
  // List<dynamic> listRoomChat = [];
  // Future<void> fungsiGetRoomChat() async {
  //   ApiResponse response = await getRoomChat();
  //   if (response.error == null) {
  //     setState(() {
  //       listRoomChat = response.data as List<dynamic>;
  //       _loading = _loading ? !_loading : _loading;
  //     });
  //   } else if (response.error == unauthorized) {
  //     logout().then((value) => {
  //           Navigator.of(context).pushAndRemoveUntil(
  //               MaterialPageRoute(
  //                   builder: (context) => const GetStartedScreen()),
  //               (route) => false)
  //         });
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text('${response.error}'),
  //     ));
  //   }
  // }

  @override
  void initState() {
    super.initState();
    listRoom();
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) => listRoom());
  }

  @override
  void dispose() {
    if (_timer!.isActive) _timer!.cancel();
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            decoration: BoxDecoration(
                color: const Color(0xffE8E9EC),
                borderRadius: BorderRadius.circular(100)),
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.search),
                  border: InputBorder.none,
                  hintText: 'Pencarian',
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Expanded(
          child: StreamBuilder(
            stream: _streamController.stream,
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                final list = snapshot.data as List<dynamic>;
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ItemContact(
                      tab: () {
                        setState(() {
                          fungsiupdateReadAdmin(
                              idRoom: list[index]['room_id'].toString());
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatList(
                                      role: widget.role,
                                      nameRoom: list[index]['name_room'],
                                      idRoomAdmin:
                                          list[index]['room_id'].toString(),
                                    )));
                      },
                      image: list[index]['image_profile'],
                      name: list[index]['name_room'],
                      message: list[index]['message'].toString(),
                      status: list[index]['status'],
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
        // Expanded(
        //   child: ListView.builder(
        //       itemCount: listRoomChat.length,
        //       itemBuilder: (BuildContext context, int index) {
        //         RoomChatModel roomChatModel = listRoomChat[index];
        //         String tanggal =
        //             DateFormat('dd-MM-yyyy').format(roomChatModel.createdAt);

        //       }),
        // ),
      ],
    );
  }
}

class ItemContact extends StatelessWidget {
  const ItemContact(
      {Key? key,
      required this.tab,
      required this.name,
      required this.image,
      required this.message,
      required this.status})
      : super(key: key);

  final VoidCallback tab;
  final String name, message, status;
  final dynamic image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: GestureDetector(
            onTap: tab,
            child: SizedBox(
              height: 120,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    right: 10,
                    left: 15,
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 5), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          // Container(
                          //   height: 60,
                          //   width: 60,
                          //   decoration: BoxDecoration(
                          //     image: const DecorationImage(
                          //         image: AssetImage(
                          //           'assets/image/cathezz.jpg',
                          //         ),
                          //         fit: BoxFit.cover),
                          //     borderRadius: BorderRadius.circular(50),
                          //   ),
                          // ),
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: image != null
                                ? CachedNetworkImage(
                                    imageUrl: image,
                                    fit: BoxFit.cover,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      height: 60.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    placeholder: (context, url) => Shimmer(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        gradient: const LinearGradient(stops: [
                                          0.2,
                                          0.5,
                                          0.6
                                        ], colors: [
                                          Colors.grey,
                                          Colors.white12,
                                          Colors.grey,
                                        ])),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  )
                                : Shimmer(
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                    gradient: const LinearGradient(
                                      stops: [0.2, 0.5, 0.6],
                                      colors: [
                                        Colors.grey,
                                        Colors.white12,
                                        Colors.grey,
                                      ],
                                    ),
                                  ),
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      name,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff4B556B),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      message,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff4B556B),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      '02/07/22',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff4B556B),
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0.5),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ))
                        ],
                      ),
                    ),
                  ),
                  status == 'ada'
                      ? Positioned(
                          right: 0,
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: const LinearGradient(
                                begin: FractionalOffset.centerLeft,
                                end: FractionalOffset.centerRight,
                                colors: [
                                  Color(0xff2E447C),
                                  Color(0xff3774C3),
                                ],
                              ),
                            ),
                            // child: const Center(
                            //   child: Text(
                            //     '1',
                            //     style: TextStyle(color: Colors.white),
                            //   ),
                            // ),
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/jadwal_model.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:siakad_app/services/jadwal_service.dart';
import 'package:siakad_app/widget/jadwal/comp/edit_ekstra.dart';

class JadwalEkstra extends StatefulWidget {
  const JadwalEkstra({Key? key, required this.idEkstra}) : super(key: key);

  final int idEkstra;

  @override
  State<JadwalEkstra> createState() => _JadwalEkstraState();
}

class _JadwalEkstraState extends State<JadwalEkstra> {
  bool _loading = true;
  List<dynamic> _jadwalEkstra = [];
  String roleku = '';

  var dropdownvalue;

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(
            color: Colors.blueAccent,
          ),
          Container(
              margin: const EdgeInsets.only(left: 5),
              child: const Text("Loading")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  List Itemlist = [];
  Future getDay() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(baseURL + '/api/lessonschedule/getday'),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body)['data'];
      setState(() {
        Itemlist = jsonData;
      });
    }
  }

  Future<void> fungsiGetEkstrabyJadwal() async {
    String role = await getrole();
    print(widget.idEkstra);
    setState(() {
      roleku = role;
    });
    ApiResponse response = await getEkstabyJadwal(id: widget.idEkstra);
    if (response.error == null) {
      setState(() {
        _jadwalEkstra = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const GetStartedScreen()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
      ));
    }
  }

  Future<void> fungsiGetEkstrabyDay() async {
    showAlertDialog(context);
    String role = await getrole();
    setState(() {
      roleku = role;
    });
    ApiResponse response = await getEkstabyDay(
        id: widget.idEkstra, idDay: int.parse(dropdownvalue));
    if (response.error == null) {
      setState(() {
        _jadwalEkstra = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
        Navigator.pop(context);
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const GetStartedScreen()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    getDay();
    fungsiGetEkstrabyJadwal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Jadwal Ekstrakulikuler',
          style: TextStyle(
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Container(
                  height: 48,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xffF0F1F2),
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        icon: const ImageIcon(
                          AssetImage('assets/icons/arrow-down.png'),
                        ),
                        dropdownColor: Color(0xffF0F1F2),
                        borderRadius: BorderRadius.circular(15),
                        hint: const Text('Hari'),
                        items: Itemlist.map((item) {
                          return DropdownMenuItem(
                            value: item['day_id'].toString(),
                            child: Text(item['day_name'].toString()),
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          setState(() {
                            dropdownvalue = newVal;
                            print(dropdownvalue);
                            if (dropdownvalue == '8') {
                              fungsiGetEkstrabyJadwal();
                            } else {
                              fungsiGetEkstrabyDay();
                            }
                          });
                        },
                        value: dropdownvalue,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
          Expanded(
            child: _loading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blueAccent,
                    ),
                  )
                : ListView.builder(
                    itemCount: _jadwalEkstra.length,
                    itemBuilder: (BuildContext context, int index) {
                      JadwalEkstraModel jadwalEkstraModel =
                          _jadwalEkstra[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 130,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.black),
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          jadwalEkstraModel.dayName,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff3774C3),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        InkWell(
                                            onTap: () async {
                                              String refresh = await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditEkstra(
                                                              jadwalEkstraModel:
                                                                  jadwalEkstraModel)));

                                              if (refresh == 'refresh') {
                                                fungsiGetEkstrabyJadwal();
                                              }
                                            },
                                            child: roleku == 'admin'
                                                ? SizedBox(
                                                    height: 18,
                                                    child: Image.asset(
                                                        'assets/icons/edit_admin.png'),
                                                  )
                                                : const SizedBox()),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      jadwalEkstraModel.extracurricularName,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff808DA6),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      jadwalEkstraModel.startTime +
                                          ' : ' +
                                          jadwalEkstraModel.endTime,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff808DA6),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      jadwalEkstraModel.firstName +
                                          ' ' +
                                          jadwalEkstraModel.lastName,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff808DA6),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }
}

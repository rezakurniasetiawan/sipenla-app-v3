import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/jadwal_model.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:siakad_app/services/jadwal_service.dart';

class JadwalMengajar extends StatefulWidget {
  const JadwalMengajar({Key? key, required this.role, }) : super(key: key);

  final String role;

  @override
  State<JadwalMengajar> createState() => _JadwalMengajarState();
}

class _JadwalMengajarState extends State<JadwalMengajar> {
  var valueDay;
  var valuemapel;
  bool _loading = true;
  List<dynamic> _JadwalGuruList = [];
  List Itemlist = [];
  List Mapellist = [];

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

  Future getMapel() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(baseURL + '/api/lessonschedule/getsubject'),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body)['data'];
      setState(() {
        Mapellist = jsonData;
      });
    }
  }

  Future<void> fungsiGetJadwalGuru() async {
    ApiResponse response = await getJadwalTeacher();
    if (response.error == null) {
      setState(() {
        _JadwalGuruList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => GetStartedScreen()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
      ));
    }
  }

  Future<void> fungsiGetJadwalbyDay() async {
    showAlertDialog(context);
    ApiResponse response =
        await getJadwalTeacherbyDay(idDay: int.parse(valueDay));
    if (response.error == null) {
      setState(() {
        _JadwalGuruList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
        Navigator.pop(context);
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => GetStartedScreen()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
      ));
    }
  }

  Future<void> fungsiGetJadwalbyMapel() async {
    showAlertDialog(context);
    ApiResponse response =
        await getJadwalTeacherbyMapel(idMapel: int.parse(valuemapel));
    if (response.error == null) {
      setState(() {
        _JadwalGuruList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
        Navigator.pop(context);
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => GetStartedScreen()),
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
    getMapel();
    fungsiGetJadwalGuru();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Jadwal Mengajar',
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
                const SizedBox(
                  height: 15,
                ),
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
                            valueDay = newVal;
                            print(valueDay);
                            if (valueDay == '8') {
                              fungsiGetJadwalGuru();
                            } else {
                              fungsiGetJadwalbyDay();
                            }
                          });
                        },
                        value: valueDay,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
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
                        hint: const Text('Mapel'),
                        items: Mapellist.map((item) {
                          return DropdownMenuItem(
                            value: item['subject_id'].toString(),
                            child: Text(item['subject_name'].toString()),
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          setState(() {
                            valuemapel = newVal;
                            print(valuemapel);
                            fungsiGetJadwalbyMapel();
                            // if (valueDay == '8') {
                            //   fungsiGetJadwalGuru();
                            // } else {
                            //   fungsiGetJadwalbyDay();
                            // }
                          });
                        },
                        value: valuemapel,
                      ),
                    ),
                  ),
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
                    itemCount: _JadwalGuruList.length,
                    itemBuilder: (BuildContext context, int index) {
                      JadwalGuruModel jadwalGuruModel = _JadwalGuruList[index];
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
                                    Text(
                                      jadwalGuruModel.dayName,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff3774C3),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      jadwalGuruModel.gradeName,
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
                                      jadwalGuruModel.startTime +
                                          ' : ' +
                                          jadwalGuruModel.endTime,
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
                                      jadwalGuruModel.subjectName,
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

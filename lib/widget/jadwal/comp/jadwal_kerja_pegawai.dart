import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/jadwal_model.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:siakad_app/services/jadwal_service.dart';

class JadwalKerjaPegawai extends StatefulWidget {
  const JadwalKerjaPegawai({Key? key}) : super(key: key);

  @override
  State<JadwalKerjaPegawai> createState() => _JadwalKerjaPegawaiState();
}

class _JadwalKerjaPegawaiState extends State<JadwalKerjaPegawai> {
  var dropdownvalue;
  bool _loading = true;
  List<dynamic> _JadwalKerjaList = [];

  List Itemlist = [];

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

  Future<void> fungsiGetJadwalKerjaPegawai() async {
    ApiResponse response = await getJadwalKerjaPegawai();
    if (response.error == null) {
      setState(() {
        _JadwalKerjaList = response.data as List<dynamic>;
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

  Future<void> fungsiGetJadwalKerjaPegawaibyDay() async {
    showAlertDialog(context);
    ApiResponse response =
        await getJadwalKerjaPegawaibyDay(id: int.parse(dropdownvalue));
    if (response.error == null) {
      setState(() {
        _JadwalKerjaList = response.data as List<dynamic>;
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
    fungsiGetJadwalKerjaPegawai();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Jadwal Kerja',
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
                            dropdownvalue = newVal;
                            print(dropdownvalue);
                            if (dropdownvalue == '8') {
                              fungsiGetJadwalKerjaPegawai();
                            } else {
                              fungsiGetJadwalKerjaPegawaibyDay();
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
                    itemCount: _JadwalKerjaList.length,
                    itemBuilder: (BuildContext context, int index) {
                      JadwalKerjaPegawaiModel jadwalKerjaPegawaiModel =
                          _JadwalKerjaList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 115,
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
                                      jadwalKerjaPegawaiModel.dayName,
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
                                      jadwalKerjaPegawaiModel.firstName +
                                          ' ' +
                                          jadwalKerjaPegawaiModel.lastName,
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
                                      jadwalKerjaPegawaiModel.startTime +
                                          ' : ' +
                                          jadwalKerjaPegawaiModel.endTime,
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

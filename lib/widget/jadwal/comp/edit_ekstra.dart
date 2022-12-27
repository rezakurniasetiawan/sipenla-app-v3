import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:intl/intl.dart';
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/jadwal_model.dart';
import 'package:http/http.dart' as http;
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/screens/tab_screen.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:siakad_app/services/jadwal_service.dart';

class EditEkstra extends StatefulWidget {
  const EditEkstra({Key? key, required this.jadwalEkstraModel})
      : super(key: key);

  final JadwalEkstraModel jadwalEkstraModel;

  @override
  State<EditEkstra> createState() => _EditEkstraState();
}

class _EditEkstraState extends State<EditEkstra> {
  bool waktumulai = true;
  bool waktuakhir = true;
  bool loading = true;

  DateTime? _dateTimeAwal;
  DateTime? _dateTimeAkhir;

  var valueDay;
  var valuePembina;
  var valueEkstra;

  List dayList = [];
  List pembinaList = [];
  List ekstraList = [];

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
        dayList = jsonData;
        valueDay = widget.jadwalEkstraModel.daysId.toString();
      });
    }
  }

  Future getEkstra() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(baseURL + '/api/extraschedule/getextra'),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body)['data'];
      setState(() {
        ekstraList = jsonData;
        valueEkstra = widget.jadwalEkstraModel.extracurricularId.toString();
      });
    }
  }

  Future getPembina() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(baseURL + '/api/extraschedule/getpembina'),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body)['data'];
      setState(() {
        pembinaList = jsonData;
        valuePembina = widget.jadwalEkstraModel.teacherId.toString();
      });
    }
  }

  void fungsiUpdateJadwalEkstra() async {
    showAlertDialog(context);
    ApiResponse response = await updatejadwalEkstra(
        id: widget.jadwalEkstraModel.extraSchedulesId,
        hariId: valueDay,
        ekstraId: valueEkstra,
        teacherId: valuePembina,
        startTIme: _dateTimeAwal.toString(),
        endTime: _dateTimeAkhir.toString());
    if (response.error == null) {
      setState(() {
        loading = false;
      });
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Berhasil Merubah Jadwal Ekstra')));
      Navigator.pop(context, 'refresh');
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const GetStartedScreen()),
                (route) => false)
          });
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  checkTimeAwal() {
    String dateku = '2022-10-29';
    String dateTimeString =
        dateku + ' ' + widget.jadwalEkstraModel.startTime.toString();
    DateTime dateTime = DateTime.parse(dateTimeString);
    setState(() {
      _dateTimeAwal = dateTime;
    });
  }

  checkTimeAkhir() {
    String dateku = '2022-10-29';
    String dateTimeString =
        dateku + ' ' + widget.jadwalEkstraModel.endTime.toString();
    DateTime dateTime = DateTime.parse(dateTimeString);
    setState(() {
      _dateTimeAkhir = dateTime;
      print('object');
    });
  }

  @override
  void initState() {
    super.initState();
    getDay();
    getEkstra();
    checkTimeAwal();
    checkTimeAkhir();
    getPembina();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Ekstrakulikuler',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Container(
                height: 48,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color(0xffF0F1F2),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      icon: const ImageIcon(
                        AssetImage('assets/icons/arrow-down.png'),
                      ),
                      dropdownColor: const Color(0xffF0F1F2),
                      borderRadius: BorderRadius.circular(15),
                      hint: const Text('Loading'),
                      items: dayList.map((item) {
                        return DropdownMenuItem(
                          value: item['day_id'].toString(),
                          child: Text(item['day_name'].toString()),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          valueDay = newVal;
                          print(valueDay);
                        });
                      },
                      value: valueDay,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 48,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color(0xffF0F1F2),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      icon: const ImageIcon(
                        AssetImage('assets/icons/arrow-down.png'),
                      ),
                      dropdownColor: const Color(0xffF0F1F2),
                      borderRadius: BorderRadius.circular(15),
                      hint: const Text('Loading'),
                      items: ekstraList.map((item) {
                        return DropdownMenuItem(
                          value: item['extracurricular_id'].toString(),
                          child: Text(item['extracurricular_name'].toString()),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          valueEkstra = newVal;
                          print(valueEkstra);
                        });
                      },
                      value: valueEkstra,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 48,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color(0xffF0F1F2),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Waktu Mulai',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      waktumulai == true
                          ? InkWell(
                              onTap: () {
                                setState(() {
                                  waktumulai = false;
                                });
                              },
                              child: const SizedBox(
                                height: 18,
                                child: ImageIcon(
                                  AssetImage('assets/icons/arrow-down.png'),
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                setState(() {
                                  waktumulai = true;
                                });
                              },
                              child: const SizedBox(
                                height: 18,
                                child: ImageIcon(
                                  AssetImage('assets/icons/arrow-right.png'),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
              waktumulai
                  ? TimePickerSpinner(
                      time: _dateTimeAwal,
                      is24HourMode: true,
                      normalTextStyle: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff323337),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1,
                      ),
                      highlightedTextStyle: const TextStyle(
                        fontSize: 20,
                        color: Color(0xff2E447C),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                      spacing: 50,
                      isShowSeconds: false,
                      itemHeight: 60,
                      isForce2Digits: true,
                      minutesInterval: 1,
                      onTimeChange: (time) {
                        setState(() {
                          _dateTimeAwal = time;
                          String formattedTime =
                              DateFormat('HH:mm:ss').format(time);
                          print(formattedTime);
                        });
                      },
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 48,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color(0xffF0F1F2),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Waktu Akhir',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      waktuakhir == true
                          ? InkWell(
                              onTap: () {
                                setState(() {
                                  waktuakhir = false;
                                });
                              },
                              child: const SizedBox(
                                height: 18,
                                child: ImageIcon(
                                  AssetImage('assets/icons/arrow-down.png'),
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                setState(() {
                                  waktuakhir = true;
                                });
                              },
                              child: const SizedBox(
                                height: 18,
                                child: ImageIcon(
                                  AssetImage('assets/icons/arrow-right.png'),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
              waktuakhir
                  ? TimePickerSpinner(
                      time: _dateTimeAkhir,
                      is24HourMode: true,
                      normalTextStyle: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff323337),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1,
                      ),
                      highlightedTextStyle: const TextStyle(
                        fontSize: 20,
                        color: Color(0xff2E447C),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                      spacing: 50,
                      isShowSeconds: false,
                      itemHeight: 60,
                      isForce2Digits: true,
                      minutesInterval: 1,
                      onTimeChange: (time) {
                        setState(() {
                          _dateTimeAkhir = time;
                          String formattedTime =
                              DateFormat('HH:mm:ss').format(time);
                          print(formattedTime);
                        });
                      },
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 48,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color(0xffF0F1F2),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      icon: const ImageIcon(
                        AssetImage('assets/icons/arrow-down.png'),
                      ),
                      dropdownColor: const Color(0xffF0F1F2),
                      borderRadius: BorderRadius.circular(15),
                      hint: const Text('Loading'),
                      items: pembinaList.map((item) {
                        return DropdownMenuItem(
                          value: item['employee_id'].toString(),
                          child: Text(item['first_name'].toString() +
                              ' ' +
                              item['last_name'].toString()),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          valuePembina = newVal;
                          print(valuePembina);
                        });
                      },
                      value: valuePembina,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  fungsiUpdateJadwalEkstra();
                },
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: const LinearGradient(
                        begin: FractionalOffset.centerLeft,
                        end: FractionalOffset.centerRight,
                        colors: [
                          Color(0xff2E447C),
                          Color(0xff3774C3),
                        ],
                      ),
                    ),
                    child: const Center(
                        child: Text(
                      "Simpan",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          letterSpacing: 1),
                    )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

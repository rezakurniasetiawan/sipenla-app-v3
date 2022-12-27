import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/jadwal_model.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/screens/tab_screen.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:siakad_app/services/jadwal_service.dart';

class EditJadwalKerja extends StatefulWidget {
  const EditJadwalKerja({Key? key, required this.jadwalKerjaModel})
      : super(key: key);

  final JadwalKerjaModel jadwalKerjaModel;

  @override
  State<EditJadwalKerja> createState() => _EditJadwalKerjaState();
}

class _EditJadwalKerjaState extends State<EditJadwalKerja> {
  var valueDay;
  var valueShift;
  var valueEmployee;

  List dayList = [];
  List shiftList = [];
  List employeeList = [];

  bool loading = true;

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
        valueDay = widget.jadwalKerjaModel.daysId.toString();
      });
    }
  }

  Future getShift() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(baseURL + '/api/lessonschedule/getshift'),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body)['data'];
      setState(() {
        shiftList = jsonData;
        valueShift = widget.jadwalKerjaModel.workshiftId.toString();
      });
    }
  }

  Future getEmployee() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(baseURL + '/api/lessonschedule/getemployee'),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body)['data'];
      setState(() {
        employeeList = jsonData;
        valueEmployee = widget.jadwalKerjaModel.employeeId.toString();
      });
    }
  }

  void fungsiUpdateJadwalKerja() async {
    showAlertDialog(context);
    ApiResponse response = await updatejadwalKerja(
        id: widget.jadwalKerjaModel.workdaysId,
        hariId: valueDay,
        workshiftId: valueShift,
        employeeId: valueEmployee);
    if (response.error == null) {
      setState(() {
        loading = false;
      });
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Berhasil Merubah Jadwal Kerja')));
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

  @override
  void initState() {
    super.initState();
    getDay();
    getShift();
    getEmployee();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Jadwal Kerja',
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
                      hint: Text('Loading'),
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
                      hint: Text('Loading'),
                      items: shiftList.map((item) {
                        return DropdownMenuItem(
                          value: item['workshift_id'].toString(),
                          child: Text(item['shift_name'].toString()),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          valueShift = newVal;
                          print(valueShift);
                        });
                      },
                      value: valueShift,
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
                      hint: Text('Loading'),
                      items: employeeList.map((item) {
                        return DropdownMenuItem(
                          value: item['employee_id'].toString(),
                          child: Text(item['first_name'].toString() +
                              ' ' +
                              item['last_name']),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          valueEmployee = newVal;
                          print(valueEmployee);
                        });
                      },
                      value: valueEmployee,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  fungsiUpdateJadwalKerja();
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

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/monitoring_model.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:siakad_app/services/monitoring_service.dart';

class RiwayatMonitoringPembelajaran extends StatefulWidget {
  const RiwayatMonitoringPembelajaran({Key? key}) : super(key: key);

  @override
  State<RiwayatMonitoringPembelajaran> createState() =>
      _RiwayatMonitoringPembelajaranState();
}

class _RiwayatMonitoringPembelajaranState
    extends State<RiwayatMonitoringPembelajaran> {
  TextEditingController tanggal = TextEditingController();

  RiwayatMonitoringModel? riwayatMonitoringModel;
  bool loading = true;
  // ignore: prefer_typing_uninitialized_variables
  var valueMapel;
  // ignore: prefer_typing_uninitialized_variables
  var valueKelas;

  String mapelName = '';
  String kelasName = '';

  List mapelList = [];
  List kelasList = [];

  Future getMapel() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(baseURL + '/api/monitoring/getsubject'),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body)['data'];
      setState(() {
        mapelList = jsonData;
      });
    }
  }

  Future getKelas() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(baseURL + '/api/monitoring/getgrade'),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body)['data'];
      setState(() {
        kelasList = jsonData;
      });
    }
  }

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

  void filterHistoryPembelajaran() async {
    showAlertDialog(context);
    ApiResponse response = await getHistoryMonitoringPembelajaran(
        kelasId: int.parse(valueKelas),
        mapelId: int.parse(valueMapel),
        tanggal: tanggal.text);
    if (response.error == null) {
      setState(() {
        riwayatMonitoringModel = response.data as RiwayatMonitoringModel;
        loading = false;
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
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  @override
  void initState() {
    super.initState();
    getMapel();
    getKelas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Monitoring Pembelajaran',
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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TextFormField(
                  controller: tanggal,
                  readOnly: true,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'dd-mm-yyyy',
                  ),
                  onTap: () async {
                    DateTime? pickedDate2 = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101));

                    if (pickedDate2 != null) {
                      // print(pickedDate);
                      String formattedDate =
                          DateFormat('yyyyMMdd').format(pickedDate2);
                      // ignore: avoid_print
                      print(formattedDate);

                      setState(() {
                        tanggal.text = formattedDate;
                      });
                    } else {
                      // ignore: avoid_print
                      print("Date is not selected");
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Wajib Di isi';
                    }
                    return null;
                  },
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
                    hint: const Text('Mata Pelajaran'),
                    items: mapelList.map((item) {
                      return DropdownMenuItem(
                        value: item['subject_id'].toString(),
                        child: Text(item['subject_name'].toString()),
                      );
                    }).toList(),
                    onChanged: (newVal) {
                      setState(() {
                        valueMapel = newVal;
                        // ignore: avoid_print
                        print(valueMapel);
                      });
                    },
                    value: valueMapel,
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
                    hint: const Text('Kelas'),
                    items: kelasList.map((item) {
                      return DropdownMenuItem(
                        value: item['grade_id'].toString(),
                        child: Text(
                          item['grade_name'].toString(),
                        ),
                      );
                    }).toList(),
                    onChanged: (newVal) {
                      setState(() {
                        valueKelas = newVal;
                        print(valueKelas);
                      });
                    },
                    value: valueKelas,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                filterHistoryPembelajaran();
              },
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 45,
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
                    "Cari",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        letterSpacing: 1),
                  )),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            riwayatMonitoringModel == null
                ? const SizedBox()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        riwayatMonitoringModel!.date,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xff4B556B),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        riwayatMonitoringModel!.grade,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xff4B556B),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        riwayatMonitoringModel!.subject,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xff4B556B),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 50,
                            width: 170,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xff4B556B),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                'Hadir \n ${riwayatMonitoringModel!.hadir} Siswa',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xff4B556B),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 50,
                            width: 170,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xff3774C3),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                'Izin \n ${riwayatMonitoringModel!.izin} Siswa',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xff3774C3),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 50,
                            width: 170,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xffFFB711),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                'Sakit \n ${riwayatMonitoringModel!.sakit} Siswa',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xffFFB711),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 50,
                            width: 170,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xffFF4238),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                'Alpa \n ${riwayatMonitoringModel!.alpha} Siswa',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xffFF4238),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}

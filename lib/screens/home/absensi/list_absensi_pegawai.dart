// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/history_absensi_model.dart';
import 'package:siakad_app/screens/home/absensi/riawayat_absensi_pegawai.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/services/absensi_service.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:http/http.dart' as http;

class ListAbsensiPegawai extends StatefulWidget {
  const ListAbsensiPegawai({Key? key}) : super(key: key);

  @override
  State<ListAbsensiPegawai> createState() => _ListAbsensiPegawaiState();
}

class _ListAbsensiPegawaiState extends State<ListAbsensiPegawai> {
  bool _loading = true;
  List<dynamic> _weekList = [];
  List<String> finalweek = [];

  String? attend, absence, leave, duty;

  StatisticModel? statisticModel;

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

  Future<void> fungsiGetWeekAbsensi() async {
    ApiResponse response = await getWeekAbsensi();
    if (response.error == null) {
      setState(() {
        _weekList = response.data as List<dynamic>;
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

  // Future<void> fungsiGetHistoryAbsensi() async {
  //   print("object");
  //   ApiResponse response = await getHistoryAbsensi();
  //   if (response.error == null) {
  //     setState(() {
  //       _RiwayatList = response.data as List<dynamic>;
  //       _loading = _loading ? !_loading : _loading;
  //     });
  //   } else if (response.error == unauthorized) {
  //     logout().then((value) => {
  //           Navigator.of(context).pushAndRemoveUntil(
  //               MaterialPageRoute(builder: (context) => GetStartedScreen()),
  //               (route) => false)
  //         });
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text('${response.error}'),
  //     ));
  //   }
  // }

  // fungsiGetStatistik() async {
  //   ApiResponse response = await getstatistic();
  //   if (response.error == null) {
  //     print('data ADA');
  //     setState(() {
  //       statisticModel = response.data as StatisticModel;
  //       _loading = false;
  //     });
  //   } else if (response.error == unauthorized) {
  //     logout().then((value) => {
  //           Navigator.of(context).pushAndRemoveUntil(
  //               MaterialPageRoute(builder: (context) => GetStartedScreen()),
  //               (route) => false)
  //         });
  //   } else {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text('${response.error}')));
  //   }
  // }
  void statistik() async {
    String token = await getToken();
    final response = await http
        .get(Uri.parse(baseURL + '/api/attendances/statistic'), headers: {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    });

    final data = jsonDecode(response.body)['data'];
    setState(() {
      _loading = false;
      attend = data['attend'];
      absence = data['absence'];
      leave = data['leave'];
      duty = data['duty'];
    });
    print(data);
  }

  double value = 50;
  bool tab = true;

  int? absenHadir;

  @override
  void initState() {
    fungsiGetWeekAbsensi();

    statistik();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Absensi",
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
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blueAccent,
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Absensi Masuk',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff4B556B),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xff4B556B),
                            width: 1.5,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            attend == null ? 'Loading' : 'Hadir $attend %',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xff4B556B),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 23,
                      ),
                      Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xff3774C3),
                            width: 1.5,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            leave == null ? 'Loading' : 'Izin / Cuti $leave %',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xff3774C3),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xffFFB711),
                            width: 1.5,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            duty == null ? 'Loading' : 'Tugas Dinas $duty %',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xffFFB711),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 23,
                      ),
                      Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xffFF4238),
                            width: 1.5,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            absence == null ? 'Loading' : 'Alpa $absence %',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xffFF4238),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: Text(
                    'Presentase Keseluruhan',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff4B556B),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // Expanded(
                //   child: ListView.builder(
                //       itemCount: finalweek.length,
                //       itemBuilder: (BuildContext context, int index) => Column(
                //             children: <Widget>[
                //               Text(finalweek[index]),
                //               SizedBox(
                //                 height: 30,
                //               )
                //             ],
                //           )),
                // ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _weekList.length,
                    itemBuilder: (BuildContext context, int index) {
                      WeekAbsensiModel weekAbsensiModel = _weekList[index];
                      // HistoryAbsensiModel historyAbsensiModel =
                      // final date = DateTime.parse(
                      //     historyAbsensiModel.createdAt.toIso8601String());
                      // String week = date.weekOfYear.toString();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              'Minggu ${weekAbsensiModel.week}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xff4B556B),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 3, left: 15),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RiwayatAbsensiPegawai(
                                              valueWeek: weekAbsensiModel.week,
                                            )));
                              },
                              child: Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey[100],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Riwayat Absensi',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff808DA6),
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                        child: Image.asset(
                                            'assets/icons/arrow-right.png'),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

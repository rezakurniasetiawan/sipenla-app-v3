import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/history_absensi_model.dart';
import 'package:siakad_app/screens/home/history_absen/riwayat_absensi_student.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/services/absensi_service.dart';
import 'package:http/http.dart' as http;
import 'package:siakad_app/services/auth_service.dart';

class ListWeekStudent extends StatefulWidget {
  const ListWeekStudent({Key? key}) : super(key: key);

  @override
  State<ListWeekStudent> createState() => _ListWeekStudentState();
}

class _ListWeekStudentState extends State<ListWeekStudent> {
  bool loading = true;
  double value = 50;

  bool _loading = true;
  List<dynamic> _weekList = [];

  String? attend, absence, sick, izin;

  Future<void> fungsiGetWeekAbsensi() async {
    ApiResponse response = await getWeekAbsensiPembelajaran();
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

  void fungsigetStatistikSiswa() async {
    String token = await getToken();
    final response = await http
        .get(Uri.parse(baseURL + '/api/monitoring/statisticmapel'), headers: {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    });

    final data = jsonDecode(response.body)['data'];
    setState(() {
      _loading = false;
      attend = data['attend'];
      absence = data['absence'];
      sick = data['sick'];
      izin = data['izin'];
    });
    print(data);
  }

  // void fungsigetStatistikEkstraSiswa() async {
  //   String token = await getToken();
  //   final response = await http
  //       .get(Uri.parse(baseURL + '/api/monitoring/statisticextra'), headers: {
  //     'Accept': 'application/json',
  //     'X-Requested-With': 'XMLHttpRequest',
  //     'Authorization': 'Bearer $token'
  //   });

  //   final data = jsonDecode(response.body)['data'];
  //   setState(() {
  //     _loading = false;
  //     attend = data['attend'];
  //     absence = data['absence'];
  //     sick = data['sick'];
  //     izin = data['izin'];
  //   });
  //   print(data);
  // }

  @override
  void initState() {
    super.initState();
    fungsiGetWeekAbsensi();
    fungsigetStatistikSiswa();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Absensi',
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Center(
            child: Text(
              'Kelas',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff4B556B),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Center(
            child: Text(
              'Semester Gasal/Genap Tahun',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Color(0xff4B556B),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
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
                      izin == null ? 'Loading' : 'Izin $izin %',
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
                      sick == null ? 'Loading' : 'Sakit $sick %',
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
                      absence == null ? 'Loading' : 'Izin $absence %',
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
          _loading
              ? const Expanded(
                  child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.blueAccent,
                  ),
                ))
              : Expanded(
                  child: ListView.builder(
                    itemCount: _weekList.length,
                    itemBuilder: (BuildContext context, int index) {
                      WeekAbsensiPembelajaranModel
                          weekAbsensiPembelajaranModel = _weekList[index];
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
                              'Minggu ${weekAbsensiPembelajaranModel.week}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xff4B556B),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 3, left: 15),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RiwayatAbsensiStudent(
                                              valueWeek:
                                                  weekAbsensiPembelajaranModel
                                                      .week,
                                            )));
                              },
                              child: Container(
                                padding: const EdgeInsets.only(top: 10),
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
                          )
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

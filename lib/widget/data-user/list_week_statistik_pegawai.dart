import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/history_absensi_model.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/services/absensi_service.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:siakad_app/widget/data-user/riwayat_pegawai_byweek.dart';

import '../../constan.dart';

class ListWeekStatistikPegawai extends StatefulWidget {
  const ListWeekStatistikPegawai({Key? key, required this.idEmployee})
      : super(key: key);

  final String idEmployee;

  @override
  State<ListWeekStatistikPegawai> createState() =>
      _ListWeekStatistikPegawaiState();
}

class _ListWeekStatistikPegawaiState extends State<ListWeekStatistikPegawai> {
  String? attend, absence, leave, duty;
  bool _loading = true;
  List<dynamic> _weekList = [];
  Future<void> fungsiGetWeekAbsensi() async {
    ApiResponse response =
        await getWeekAbsensibyIdEmployee(idEmployee: widget.idEmployee);
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

  void statistik() async {
    String token = await getToken();
    final response = await http.get(
        Uri.parse(baseURL + '/api/data/statistic/${widget.idEmployee}'),
        headers: {
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Bearer $token'
        });

    final data = jsonDecode(response.body)['data'];
    setState(() {
      _loading = false;
      attend = data['attend'];
      absence = data['absence'];
      leave = data['izin'];
      duty = data['sick'];
    });
    print(data);
  }

  @override
  void initState() {
    super.initState();
    fungsiGetWeekAbsensi();
    statistik();
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
        backgroundColor: Colors.white,
        body: Column(
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
                        leave == null ? 'Loading' : 'Cuti $leave %',
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
            Expanded(
              child: _loading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blueAccent,
                      ),
                    )
                  : ListView.builder(
                      itemCount: _weekList.length,
                      itemBuilder: (BuildContext context, int index) {
                        WeekAbsensiPembelajaranModel
                            weekAbsensiPembelajaranModel = _weekList[index];

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
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
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 3, left: 15),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RiwayatPegawaibyWeek(
                                                valueWeek:
                                                    weekAbsensiPembelajaranModel
                                                        .week,
                                                idEmployee: widget.idEmployee,
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
                            )
                          ],
                        );
                      }),
            )
          ],
        ));
  }
}

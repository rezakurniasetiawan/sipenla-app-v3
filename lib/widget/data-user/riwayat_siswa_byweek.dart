import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/history_absensi_model.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/services/absensi_service.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:week_of_year/date_week_extensions.dart';

import '../../constan.dart';

class RiwayatSiswabyWeek extends StatefulWidget {
  const RiwayatSiswabyWeek(
      {Key? key, required this.valueWeek, required this.idStudent})
      : super(key: key);

  final String valueWeek, idStudent;

  @override
  State<RiwayatSiswabyWeek> createState() => _RiwayatSiswabyWeekState();
}

class _RiwayatSiswabyWeekState extends State<RiwayatSiswabyWeek> {
  bool _loading = true;
  List<dynamic> _postList = [];

  Future<void> fungsiGetHistoryAbsensi() async {
    ApiResponse response =
        await getHistoryAbsensiSiswabyId(idStudent: widget.idStudent);
    if (response.error == null) {
      setState(() {
        _postList = response.data as List<dynamic>;
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

  @override
  void initState() {
    super.initState();
    fungsiGetHistoryAbsensi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Riwayat Absensi",
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
            : ListView.builder(
                itemCount: _postList.length,
                itemBuilder: (BuildContext context, int index) {
                  HistoryAbsensiPembelajaranModel
                      historyAbsensiPembelajaranModel = _postList[index];
                  final date = DateTime.parse(historyAbsensiPembelajaranModel
                      .createdAt
                      .toIso8601String());
                  String week = date.weekOfYear.toString();

                  return Column(
                    children: [
                      week == widget.valueWeek
                          ? ItemRiwayat(
                              date: date.year.toString() +
                                  '-' +
                                  date.month.toString() +
                                  '-' +
                                  date.day.toString(),
                              ket: historyAbsensiPembelajaranModel.status,
                              mapel:
                                  historyAbsensiPembelajaranModel.subjectName,
                              waktu: historyAbsensiPembelajaranModel.waktu,
                            )
                          : const SizedBox(),
                    ],
                  );
                }));
  }
}

class ItemRiwayat extends StatelessWidget {
  const ItemRiwayat(
      {Key? key,
      required this.date,
      required this.waktu,
      required this.mapel,
      required this.ket})
      : super(key: key);

  final String date, waktu, mapel, ket;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(20),
            ),
            height: 150,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Tanggal',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xff808DA6),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              ': ',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xff808DA6),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(date),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Waktu',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xff808DA6),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              ': ',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xff808DA6),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(waktu),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Mata Pelajaran',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xff808DA6),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              ': ',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xff808DA6),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(mapel),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Ket',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xff808DA6),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              ': ',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xff808DA6),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(ket),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/history_absensi_model.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/services/absensi_service.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:week_of_year/date_week_extensions.dart';

class RiwayatAbsensiPegawai extends StatefulWidget {
  const RiwayatAbsensiPegawai({Key? key, required this.valueWeek})
      : super(key: key);

  final String valueWeek;

  @override
  State<RiwayatAbsensiPegawai> createState() => _RiwayatAbsensiPegawaiState();
}

class _RiwayatAbsensiPegawaiState extends State<RiwayatAbsensiPegawai> {
  bool _loading = true;
  List<dynamic> _postList = [];

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

  // get all posts
  Future<void> fungsiGetHistoryAbsensi() async {
    print("object");
    ApiResponse response = await getHistoryAbsensi();
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
    fungsiGetHistoryAbsensi();
    super.initState();
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
        body: ListView.builder(
            itemCount: _postList.length,
            itemBuilder: (BuildContext context, int index) {
              HistoryAbsensiModel historyAbsensiModel = _postList[index];
              final date = DateTime.parse(
                  historyAbsensiModel.createdAt.toIso8601String());
              String week = date.weekOfYear.toString();
              String dateCekIn = DateFormat('dd/M/yyyy KK:mm:ss a')
                  .format(historyAbsensiModel.checkIn);
              String dateCekOut = DateFormat('dd/M/yyyy KK:mm:ss a')
                  .format(historyAbsensiModel.checkOut);

              print(historyAbsensiModel.employeeId.bitLength * 20);

              return Column(
                children: [
                  week == widget.valueWeek
                      ? ItemRiwayat(
                          date: historyAbsensiModel.date,
                          cekin: dateCekIn,
                          cekout: dateCekOut,
                          ket: historyAbsensiModel.status == 'ac'
                              ? 'Hadir'
                              : historyAbsensiModel.status == 'aae'
                                  ? 'Tidak Hadir'
                                  : '',
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
      required this.cekin,
      required this.cekout,
      required this.ket})
      : super(key: key);

  final String date, cekin, cekout, ket;

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
            // height: 150,
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
                    height: 20,
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
                              'Waktu Masuk',
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
                        child: Text(cekin),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
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
                              'Waktu Keluar',
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
                        child: Text(cekout),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
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
                          child: ket == 'Tidak Hadir'
                              ? Text(
                                  ket,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xffFF4238),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              : Text(
                                  ket,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff83BC10),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ))
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

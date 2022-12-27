// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/fasilitas_model.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:siakad_app/services/fasilitas_service.dart';
import 'package:siakad_app/widget/fasilitas/comp/detail_aprrove_siswa.dart';

class AprroveSiswaPengembalian extends StatefulWidget {
  const AprroveSiswaPengembalian({Key? key}) : super(key: key);

  @override
  State<AprroveSiswaPengembalian> createState() =>
      _AprroveSiswaPengembalianState();
}

class _AprroveSiswaPengembalianState extends State<AprroveSiswaPengembalian> {
  bool _loading = true;
  List<dynamic> _PengembalianList = [];

  Future<void> fungsiGetpengembalian() async {
    ApiResponse response = await getAprroveSiswaPengembalianFasilitas();
    if (response.error == null) {
      print('halo');
      setState(() {
        _PengembalianList = response.data as List<dynamic>;
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

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(
            color: Colors.blueAccent,
          ),
          Container(margin: EdgeInsets.only(left: 5), child: Text("Loading")),
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

  void fungsiAprrovePengFas(int loadId) async {
    showAlertDialog(context);
    ApiResponse response = await aprrovePengembalianFasilitas(idLoan: loadId);
    if (response.error == null) {
      print("Pengajuan Suskses");
      Navigator.pop(context);
      setState(() {
        fungsiGetpengembalian();
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Berhasil Konfirmasi Pengembalian Fasilitas')));
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => GetStartedScreen()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Ada Kesalahan')));
    }
  }

  @override
  void initState() {
    super.initState();
    fungsiGetpengembalian();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Pengembalian Fasilitas",
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
            : RefreshIndicator(
                onRefresh: () => fungsiGetpengembalian(),
                child: ListView.builder(
                    itemCount: _PengembalianList.length,
                    itemBuilder: (BuildContext context, int index) {
                      AprrovePeminjamanSiswaModel aprrovePeminjamanSiswaModel =
                          _PengembalianList[index];
                      String tanggalawal = DateFormat('dd MMMM yyyy')
                          .format(aprrovePeminjamanSiswaModel.fromDate);
                      String tanggalakhir = DateFormat('dd MMMM yyyy')
                          .format(aprrovePeminjamanSiswaModel.toDate);
                      return Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            width: 130,
                                            child: Text(
                                              "Kode Fasilitas",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Poppins',
                                                color: Color(0xff2E447C),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                            child: Text(
                                              ": ",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Poppins',
                                                color: Color(0xff2E447C),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              aprrovePeminjamanSiswaModel
                                                  .facilityCode,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Poppins',
                                                color: Color(0xff2E447C),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            width: 130,
                                            child: Text(
                                              "Nama Fasilitas",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Poppins',
                                                color: Color(0xff2E447C),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                            child: Text(
                                              ": ",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Poppins',
                                                color: Color(0xff2E447C),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              aprrovePeminjamanSiswaModel
                                                  .facilityName,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Poppins',
                                                color: Color(0xff2E447C),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            width: 130,
                                            child: Text(
                                              "Jumlah Fasilitas",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Poppins',
                                                color: Color(0xff2E447C),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                            child: Text(
                                              ": ",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Poppins',
                                                color: Color(0xff2E447C),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              aprrovePeminjamanSiswaModel
                                                  .totalFacility,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Poppins',
                                                color: Color(0xff2E447C),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            width: 130,
                                            child: Text(
                                              "Keterangan",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Poppins',
                                                color: Color(0xff2E447C),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                            child: Text(
                                              ": ",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Poppins',
                                                color: Color(0xff2E447C),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              aprrovePeminjamanSiswaModel
                                                  .status,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Poppins',
                                                color: Color(0xff2E447C),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DetailAprroveSiswa(
                                                  aprrovePeminjamanSiswaModel:
                                                      aprrovePeminjamanSiswaModel,
                                                  tanggalakhir: tanggalakhir,
                                                  tanggalawal: tanggalawal,
                                                )));
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Color(0xff2E447C),
                                      ),
                                    ),
                                    child: const Center(
                                        child: Text(
                                      "Lihat",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins',
                                          color: Color(0xff2E447C),
                                          letterSpacing: 1),
                                    )),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    fungsiAprrovePengFas(
                                        aprrovePeminjamanSiswaModel
                                            .loanFacilityId);
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
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
                                      "Konfirmasi",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                          letterSpacing: 1),
                                    )),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    }),
              ));
  }
}

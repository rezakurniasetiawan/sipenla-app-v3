import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:siakad_app/widget/perpustakaan/comp/pergawai_perpus/riwayat/detail_riwayat_sumbangan_siswa.dart';

import '../../../../../constan.dart';
import '../../../../../models/api_response_model.dart';
import '../../../../../models/perpustakaan/pengguna_perpus_model.dart';
import '../../../../../screens/started_screen.dart';
import '../../../../../services/auth_service.dart';
import '../../../../../services/perpustakaan/pengguna_perpus_service.dart';
import '../../../../text_paragraf.dart';
import 'detail_riwayat_peng_pem_pegawai.dart';
import 'detail_riwayat_peng_pem_siswa.dart';
import 'detail_riwayat_sumbangan_pegawai.dart';

class RiwayatSumbangan extends StatefulWidget {
  const RiwayatSumbangan({Key? key, required this.akses}) : super(key: key);

  final String akses;

  @override
  State<RiwayatSumbangan> createState() => _RiwayatSumbanganState();
}

class _RiwayatSumbanganState extends State<RiwayatSumbangan> {
  TextEditingController tanggal = TextEditingController();
  final String datenow = DateFormat('yyyyMMdd').format(DateTime.now());

  bool _loading = true;
  List<dynamic> bookSiswaPerpusList = [];

  Future<void> fungsigethistorysumbangstudent(String datetx) async {
    ApiResponse response = await gethistorysumbangstudent(date: datetx);
    if (response.error == null) {
      setState(() {
        bookSiswaPerpusList = response.data as List<dynamic>;
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

  Future<void> fungsigethistorysumbangemployee(String datetx) async {
    ApiResponse response = await gethistorysumbangemployee(date: datetx);
    if (response.error == null) {
      setState(() {
        bookSiswaPerpusList = response.data as List<dynamic>;
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
    tanggal.text = datenow;
    if (widget.akses == 'siswa') {
      fungsigethistorysumbangstudent(tanggal.text);
    } else {
      fungsigethistorysumbangemployee(tanggal.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Riwayat Perpustakaan ",
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
            const Text(
              "Tanggal",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
                color: Color(0xff4B556B),
              ),
            ),
            InkWell(
              onTap: () async {
                DateTime? pickedDate2 = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101));

                if (pickedDate2 != null) {
                  String formattedDate2 =
                      DateFormat('yyyyMMdd').format(pickedDate2);
                  print(formattedDate2);

                  setState(() {
                    tanggal.text = formattedDate2;
                  });
                } else {
                  print("Date is not selected");
                }
              },
              child: Container(
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
                      Text(
                        tanggal.text == '' ? 'yyyy-mm-dd' : tanggal.text,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                        child: ImageIcon(
                          AssetImage('assets/icons/calendar_month.png'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                if (widget.akses == 'siswa') {
                  fungsigethistorysumbangstudent(tanggal.text);
                } else {
                  fungsigethistorysumbangemployee(tanggal.text);
                }
              },
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
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
                    "Cari",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
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
            widget.akses == 'siswa'
                ? Expanded(
                    child: ListView.builder(
                        itemCount: bookSiswaPerpusList.length,
                        itemBuilder: (BuildContext context, int index) {
                          HistorySumbangBukuSiswaModel
                              historySumbangBukuSiswaModel =
                              bookSiswaPerpusList[index];
                          return Column(
                            children: [
                              TextParagraf(
                                  title: 'Nama',
                                  value: historySumbangBukuSiswaModel
                                          .firstName +
                                      ' ' +
                                      historySumbangBukuSiswaModel.lastName),
                              TextParagraf(
                                  title: 'Kode Buku',
                                  value: historySumbangBukuSiswaModel.bookCode),
                              TextParagraf(
                                  title: 'Tanggal',
                                  value: historySumbangBukuSiswaModel.date),
                              TextParagraf(
                                  title: 'Keterangan',
                                  value: historySumbangBukuSiswaModel.status),
                              TextParagraf(
                                  title: 'Status',
                                  value: historySumbangBukuSiswaModel.status),
                              GestureDetector(
                                onTap: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailRiwayatSumbanganSiswaPerpus(
                                                historySumbangBukuSiswaModel:
                                                    historySumbangBukuSiswaModel,
                                              )));
                                  // String refresh = await Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             DetailPengembalianFasilitas(
                                  //               tanggalakhir: tanggalakhir,
                                  //               tanggalawal: tanggalawal,
                                  //               idLoad:
                                  //                   pengembalianFasilitasSiswaModel
                                  //                       .loanFacilityId,
                                  //               imageFas:
                                  //                   pengembalianFasilitasSiswaModel
                                  //                       .image,
                                  //               jumlahFas:
                                  //                   pengembalianFasilitasSiswaModel
                                  //                       .numberOfFacility,
                                  //               kodeFas:
                                  //                   pengembalianFasilitasSiswaModel
                                  //                       .facilityCode,
                                  //               nameFas:
                                  //                   pengembalianFasilitasSiswaModel
                                  //                       .facilityName,
                                  //             )));
                                },
                                child: Center(
                                  child: Container(
                                    width: 100,
                                    height: 27,
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
                                      "Detail",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                      ),
                                    )),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 20),
                                child: Container(
                                  height: 1,
                                  color: Color(0xff4B556B),
                                ),
                              )
                            ],
                          );
                        }),
                  )
                : Expanded(
                    child: ListView.builder(
                        itemCount: bookSiswaPerpusList.length,
                        itemBuilder: (BuildContext context, int index) {
                          HistorySumbangBukuPegawaiModel
                              historySumbangBukuPegawaiModel =
                              bookSiswaPerpusList[index];
                          return Column(
                            children: [
                              TextParagraf(
                                  title: 'Nama',
                                  value: historySumbangBukuPegawaiModel
                                          .firstName +
                                      ' ' +
                                      historySumbangBukuPegawaiModel.lastName),
                              TextParagraf(
                                  title: 'Kode Buku',
                                  value:
                                      historySumbangBukuPegawaiModel.bookCode),
                              TextParagraf(
                                  title: 'Tanggal',
                                  value: historySumbangBukuPegawaiModel.date),
                              TextParagraf(
                                  title: 'Keterangan',
                                  value: historySumbangBukuPegawaiModel.status),
                              TextParagraf(
                                  title: 'Status',
                                  value: historySumbangBukuPegawaiModel.status),
                              GestureDetector(
                                onTap: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailRiwayatSumbanganPegawaiPerpus(
                                                historySumbangBukuPegawaiModel:
                                                    historySumbangBukuPegawaiModel,
                                              )));

                                  // if (refresh == 'refresh') {
                                  //   fungsigetsumbanganemployee();
                                  // }
                                  // String refresh = await Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             DetailPengembalianFasilitas(
                                  //               tanggalakhir: tanggalakhir,
                                  //               tanggalawal: tanggalawal,
                                  //               idLoad:
                                  //                   pengembalianFasilitasSiswaModel
                                  //                       .loanFacilityId,
                                  //               imageFas:
                                  //                   pengembalianFasilitasSiswaModel
                                  //                       .image,
                                  //               jumlahFas:
                                  //                   pengembalianFasilitasSiswaModel
                                  //                       .numberOfFacility,
                                  //               kodeFas:
                                  //                   pengembalianFasilitasSiswaModel
                                  //                       .facilityCode,
                                  //               nameFas:
                                  //                   pengembalianFasilitasSiswaModel
                                  //                       .facilityName,
                                  //             )));
                                },
                                child: Center(
                                  child: Container(
                                    width: 100,
                                    height: 27,
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
                                      "Detail",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                      ),
                                    )),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 20),
                                child: Container(
                                  height: 1,
                                  color: Color(0xff4B556B),
                                ),
                              )
                            ],
                          );
                        }),
                  )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../constan.dart';
import '../../../../../models/api_response_model.dart';
import '../../../../../models/perpustakaan/pegawai_perpus_model.dart';
import '../../../../../models/perpustakaan/pengguna_perpus_model.dart';
import '../../../../../screens/started_screen.dart';
import '../../../../../services/auth_service.dart';
import '../../../../../services/perpustakaan/pengguna_perpus_service.dart';
import '../../../../text_paragraf.dart';
import 'detail_riwayat_peng_pem_pegawai.dart';
import 'detail_riwayat_peng_pem_siswa.dart';

class RiwayatPengPem extends StatefulWidget {
  const RiwayatPengPem({Key? key, required this.akses}) : super(key: key);

  final String akses;

  @override
  State<RiwayatPengPem> createState() => _RiwayatPengPemState();
}

class _RiwayatPengPemState extends State<RiwayatPengPem> {
  TextEditingController tanggal = TextEditingController();
  final String datenow = DateFormat('yyyyMMdd').format(DateTime.now());

  bool _loading = true;
  List<dynamic> bookSiswaPerpusList = [];

  Future<void> fungsigethistorysumbangstudent(String datetx) async {
    ApiResponse response = await gethistorystudent(date: datetx);
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
    ApiResponse response = await gethistoryemployee(date: datetx);
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
                          RiwayatPengajuanBukuSiswaPerpusModel
                              riwayatPengajuanBukuSiswaPerpusModel =
                              bookSiswaPerpusList[index];
                          return Column(
                            children: [
                              TextParagraf(
                                  title: 'Nama',
                                  value: riwayatPengajuanBukuSiswaPerpusModel
                                          .firstName +
                                      ' ' +
                                      riwayatPengajuanBukuSiswaPerpusModel
                                          .lastName),
                              TextParagraf(
                                  title: 'Kode Buku',
                                  value: riwayatPengajuanBukuSiswaPerpusModel
                                      .bookCode),
                              TextParagraf(
                                  title: 'Tanggal',
                                  value: riwayatPengajuanBukuSiswaPerpusModel
                                          .toDate.day
                                          .toString() +
                                      '-' +
                                      riwayatPengajuanBukuSiswaPerpusModel
                                          .toDate.month
                                          .toString() +
                                      '-' +
                                      riwayatPengajuanBukuSiswaPerpusModel
                                          .toDate.year
                                          .toString()),
                              TextParagraf(
                                  title: 'Keterangan',
                                  value: riwayatPengajuanBukuSiswaPerpusModel
                                      .status),
                              TextParagraf(
                                  title: 'Status',
                                  value: riwayatPengajuanBukuSiswaPerpusModel
                                      .status),
                              GestureDetector(
                                onTap: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailRiwayatPengPemSiswa(
                                                pengajuanBukuSiswaPerpusModel:
                                                    riwayatPengajuanBukuSiswaPerpusModel,
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
                          PengajuanBukuPegawaiPerpusModel
                              pengajuanBukuPegawaiPerpusModel =
                              bookSiswaPerpusList[index];
                          return Column(
                            children: [
                              TextParagraf(
                                  title: 'Nama',
                                  value: pengajuanBukuPegawaiPerpusModel
                                          .firstName +
                                      ' ' +
                                      pengajuanBukuPegawaiPerpusModel.lastName),
                              TextParagraf(
                                  title: 'Kode Buku',
                                  value:
                                      pengajuanBukuPegawaiPerpusModel.bookCode),
                              TextParagraf(
                                  title: 'Tanggal',
                                  value: pengajuanBukuPegawaiPerpusModel
                                          .toDate.day
                                          .toString() +
                                      '-' +
                                      pengajuanBukuPegawaiPerpusModel
                                          .toDate.month
                                          .toString() +
                                      '-' +
                                      pengajuanBukuPegawaiPerpusModel
                                          .toDate.year
                                          .toString()),
                              TextParagraf(
                                  title: 'Keterangan',
                                  value:
                                      pengajuanBukuPegawaiPerpusModel.status),
                              TextParagraf(
                                  title: 'Status',
                                  value:
                                      pengajuanBukuPegawaiPerpusModel.status),
                              GestureDetector(
                                onTap: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailRiwayatPengPemPegawai(
                                                pengajuanBukuPegawaiPerpusModel:
                                                    pengajuanBukuPegawaiPerpusModel,
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

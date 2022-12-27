import 'package:flutter/material.dart';
import 'package:siakad_app/widget/perpustakaan/comp/pergawai_perpus/sumbang/detail_sumbangan_pegawai.dart';

import '../../../../../constan.dart';
import '../../../../../models/api_response_model.dart';
import '../../../../../models/perpustakaan/pegawai_perpus_model.dart';
import '../../../../../screens/started_screen.dart';
import '../../../../../services/auth_service.dart';
import '../../../../../services/perpustakaan/pegawai_perpus_services.dart';
import '../../../../text_paragraf.dart';

class SumbangBukuPegawai extends StatefulWidget {
  const SumbangBukuPegawai({Key? key}) : super(key: key);

  @override
  State<SumbangBukuPegawai> createState() => _SumbangBukuPegawaiState();
}

class _SumbangBukuPegawaiState extends State<SumbangBukuPegawai> {
  bool _loading = true;
  List<dynamic> bookSiswaPerpusList = [];

  Future<void> fungsigetsumbanganemployee() async {
    ApiResponse response = await getsumbanganemployee();
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
    fungsigetsumbanganemployee();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sumbang Buku",
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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
            itemCount: bookSiswaPerpusList.length,
            itemBuilder: (BuildContext context, int index) {
              SumbanganPegawaiModel sumbanganPegawaiModel =
                  bookSiswaPerpusList[index];
              return Column(
                children: [
                  TextParagraf(
                      title: 'Nama',
                      value: sumbanganPegawaiModel.firstName +
                          ' ' +
                          sumbanganPegawaiModel.lastName),
                  TextParagraf(
                      title: 'NUPTK', value: sumbanganPegawaiModel.nuptk),
                  TextParagraf(
                      title: 'Kode Buku',
                      value: sumbanganPegawaiModel.bookCode),
                  TextParagraf(
                      title: 'Nama Buku',
                      value: sumbanganPegawaiModel.bookName),
                  TextParagraf(
                      title: 'Jumlah Buku',
                      value: sumbanganPegawaiModel.numberOfBook),
                  GestureDetector(
                    onTap: () async {
                      String refresh = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailSumbanganPegawai(
                                    sumbanganPegawaiModel:
                                        sumbanganPegawaiModel,
                                  )));

                      if (refresh == 'refresh') {
                        fungsigetsumbanganemployee();
                      }
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
                          "Lihat",
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
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Container(
                      height: 1,
                      color: Color(0xff4B556B),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}

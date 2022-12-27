import 'package:flutter/material.dart';
import 'package:siakad_app/widget/perpustakaan/comp/pergawai_perpus/sumbang/detail_sumbangan_siswa.dart';

import '../../../../../constan.dart';
import '../../../../../models/api_response_model.dart';
import '../../../../../models/perpustakaan/pegawai_perpus_model.dart';
import '../../../../../screens/started_screen.dart';
import '../../../../../services/auth_service.dart';
import '../../../../../services/perpustakaan/pegawai_perpus_services.dart';
import '../../../../text_paragraf.dart';

class SumbangBukuSiswa extends StatefulWidget {
  const SumbangBukuSiswa({Key? key}) : super(key: key);

  @override
  State<SumbangBukuSiswa> createState() => _SumbangBukuSiswaState();
}

class _SumbangBukuSiswaState extends State<SumbangBukuSiswa> {
  bool _loading = true;
  List<dynamic> bookSiswaPerpusList = [];

  Future<void> fungsiGetSumbanganStudent() async {
    ApiResponse response = await getSumbanganStudent();
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
    fungsiGetSumbanganStudent();
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
                SumbanganSiswaModel sumbanganSiswaModel =
                    bookSiswaPerpusList[index];
                return Column(
                  children: [
                    TextParagraf(
                        title: 'Nama',
                        value: sumbanganSiswaModel.firstName +
                            ' ' +
                            sumbanganSiswaModel.lastName),
                    TextParagraf(
                        title: 'NISN', value: sumbanganSiswaModel.nisn),
                    TextParagraf(
                        title: 'Kode Buku',
                        value: sumbanganSiswaModel.bookCode),
                    TextParagraf(
                        title: 'Nama Buku',
                        value: sumbanganSiswaModel.bookName),
                    TextParagraf(
                        title: 'Jumlah Buku',
                        value: sumbanganSiswaModel.numberOfBook),
                    GestureDetector(
                      onTap: () async {
                        String refresh = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailSumbanganSiswa(
                                      sumbanganSiswaModel: sumbanganSiswaModel,
                                    )));

                        if (refresh == 'refresh') {
                          fungsiGetSumbanganStudent();
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
              })),
    );
  }
}

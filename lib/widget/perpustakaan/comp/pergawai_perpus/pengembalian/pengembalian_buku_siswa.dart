import 'package:flutter/material.dart';
import 'package:siakad_app/widget/perpustakaan/comp/pergawai_perpus/pengembalian/detail_pengembalian_buku_siswa.dart';

import '../../../../../models/perpustakaan/pegawai_perpus_model.dart';
import '../../../../text_paragraf.dart';

import '../../../../../constan.dart';
import '../../../../../models/api_response_model.dart';
import '../../../../../screens/started_screen.dart';
import '../../../../../services/auth_service.dart';
import '../../../../../services/perpustakaan/pegawai_perpus_services.dart';

class PengembalianBukuSiswa extends StatefulWidget {
  const PengembalianBukuSiswa({Key? key}) : super(key: key);

  @override
  State<PengembalianBukuSiswa> createState() => _PengembalianBukuSiswaState();
}

class _PengembalianBukuSiswaState extends State<PengembalianBukuSiswa> {
  bool _loading = true;
  List<dynamic> bookPerpusList = [];

  Future<void> fungsiGetAprrovePengembalian() async {
    ApiResponse response = await getGetAprrovePengembalianBukuSiswa();
    if (response.error == null) {
      setState(() {
        bookPerpusList = response.data as List<dynamic>;
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
    fungsiGetAprrovePengembalian();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pengembalian Buku",
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
          child: ListView.builder(
              itemCount: bookPerpusList.length,
              itemBuilder: (BuildContext context, int index) {
                PengajuanBukuSiswaPerpusModel pengajuanBukuSiswaPerpusModel =
                    bookPerpusList[index];
                return Column(
                  children: [
                    TextParagraf(
                        title: 'Nama',
                        value: pengajuanBukuSiswaPerpusModel.firstName +
                            ' ' +
                            pengajuanBukuSiswaPerpusModel.lastName),
                    TextParagraf(
                        title: 'NISN',
                        value: pengajuanBukuSiswaPerpusModel.nisn),
                    TextParagraf(
                        title: 'Kode Buku',
                        value: pengajuanBukuSiswaPerpusModel.bookCode),
                    TextParagraf(
                        title: 'Nama Buku',
                        value: pengajuanBukuSiswaPerpusModel.bookName),
                    TextParagraf(
                        title: 'Jumlah Buku',
                        value: pengajuanBukuSiswaPerpusModel.totalBook),
                    GestureDetector(
                      onTap: () async {
                        String refresh = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailPengembalianBukuSiswa(
                                      pengajuanBukuSiswaPerpusModel:
                                          pengajuanBukuSiswaPerpusModel,
                                    )));

                        if (refresh == 'refresh') {
                          fungsiGetAprrovePengembalian();
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

                        // if (refresh == 'refresh') {
                        //   checkUser();
                        // }
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

import 'package:flutter/material.dart';
import 'package:siakad_app/widget/perpustakaan/comp/pengguna/detail_pengembalian_pengguna.dart';

import '../../../../constan.dart';
import '../../../../models/api_response_model.dart';
import '../../../../models/perpustakaan/pengguna_perpus_model.dart';
import '../../../../screens/started_screen.dart';
import '../../../../services/auth_service.dart';
import '../../../../services/perpustakaan/pengguna_perpus_service.dart';

class PengembalianBukuPengguna extends StatefulWidget {
  const PengembalianBukuPengguna({Key? key}) : super(key: key);

  @override
  State<PengembalianBukuPengguna> createState() =>
      _PengembalianBukuPenggunaState();
}

class _PengembalianBukuPenggunaState extends State<PengembalianBukuPengguna> {
  bool _loading = true;
  List<dynamic> bookOngoingList = [];
  Future<void> fungsiGetOngoing() async {
    ApiResponse response = await getOngoungPerpus();
    if (response.error == null) {
      setState(() {
        bookOngoingList = response.data as List<dynamic>;
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
    fungsiGetOngoing();
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
      backgroundColor: Colors.white,
      body: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView.builder(
              itemCount: bookOngoingList.length,
              itemBuilder: (BuildContext context, int index) {
                PengembalianOngoingPenggunaPerpusModel
                    pengembalianOngoingPenggunaPerpusModel =
                    bookOngoingList[index];
                return Column(
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 120,
                          child: Text(
                            'Kode Buku',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xff4B556B),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const Text(
                          ': ',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xff4B556B),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          // pengembalianFasilitasModel.facilityCode,
                          pengembalianOngoingPenggunaPerpusModel.bookCode,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xff4B556B),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 120,
                          child: Text(
                            'Nama Buku',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xff4B556B),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const Text(
                          ': ',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xff4B556B),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          // pengembalianFasilitasModel.facilityCode,
                          pengembalianOngoingPenggunaPerpusModel.bookName,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xff4B556B),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 120,
                          child: Text(
                            'Jumlah Buku',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xff4B556B),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const Text(
                          ': ',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xff4B556B),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          // pengembalianFasilitasModel.facilityCode,
                          pengembalianOngoingPenggunaPerpusModel.numberOfBook,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xff4B556B),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () async {
                        String refresh = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailPengembalianPengguna(
                                      pengembalianOngoingPenggunaPerpusModel:
                                          pengembalianOngoingPenggunaPerpusModel,
                                    )));

                        if (refresh == 'refresh') {
                          fungsiGetOngoing();
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

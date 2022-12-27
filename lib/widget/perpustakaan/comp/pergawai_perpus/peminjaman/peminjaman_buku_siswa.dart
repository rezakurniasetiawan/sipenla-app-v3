import 'package:flutter/material.dart';
import 'package:siakad_app/widget/text_paragraf.dart';

import '../../../../../constan.dart';
import '../../../../../models/api_response_model.dart';
import '../../../../../models/perpustakaan/pegawai_perpus_model.dart';
import '../../../../../screens/started_screen.dart';
import '../../../../../services/auth_service.dart';
import '../../../../../services/perpustakaan/pegawai_perpus_services.dart';
import 'detail_peminjaman_buku_siswa.dart';

class PeminjamanBukuSiswa extends StatefulWidget {
  const PeminjamanBukuSiswa({Key? key}) : super(key: key);

  @override
  State<PeminjamanBukuSiswa> createState() => _PeminjamanBukuSiswaState();
}

class _PeminjamanBukuSiswaState extends State<PeminjamanBukuSiswa> {
  bool _loading = true;
  List<dynamic> bookSiswaPerpusList = [];

  Future<void> fungsiGetBookPerpus() async {
    ApiResponse response = await getPengajuanBookSiswaPerpus();
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
    fungsiGetBookPerpus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Peminjaman Buku",
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
        child: _loading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.blueAccent,
                ),
              )
            : ListView.builder(
                itemCount: bookSiswaPerpusList.length,
                itemBuilder: (BuildContext context, int index) {
                  PengajuanBukuSiswaPerpusModel2 pengajuanBukuSiswaPerpusModel2 =
                      bookSiswaPerpusList[index];
                  return Column(
                    children: [
                      TextParagraf(
                          title: 'Nama',
                          value: pengajuanBukuSiswaPerpusModel2.firstName +
                              ' ' +
                              pengajuanBukuSiswaPerpusModel2.lastName),
                      TextParagraf(
                          title: 'NISN',
                          value: pengajuanBukuSiswaPerpusModel2.nisn),
                      TextParagraf(
                          title: 'Kode Buku',
                          value: pengajuanBukuSiswaPerpusModel2.bookCode),
                      TextParagraf(
                          title: 'Nama Buku',
                          value: pengajuanBukuSiswaPerpusModel2.bookName),
                      TextParagraf(
                          title: 'Jumlah Buku',
                          value: pengajuanBukuSiswaPerpusModel2.totalBook),
                      GestureDetector(
                        onTap: () async {
                          String refresh = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailPeminjamanbukuSiswa(
                                        pengajuanBukuSiswaPerpusModel2:
                                            pengajuanBukuSiswaPerpusModel2,
                                      )));

                          if (refresh == 'refresh') {
                            fungsiGetBookPerpus();
                          }
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

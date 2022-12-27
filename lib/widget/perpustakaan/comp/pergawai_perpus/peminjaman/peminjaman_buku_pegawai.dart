import 'package:flutter/material.dart';

import '../../../../../models/perpustakaan/pegawai_perpus_model.dart';
import '../../../../text_paragraf.dart';
import 'detail_peminjaman_buku_pegawai.dart';
import '../../../../../constan.dart';
import '../../../../../models/api_response_model.dart';
import '../../../../../screens/started_screen.dart';
import '../../../../../services/auth_service.dart';
import '../../../../../services/perpustakaan/pegawai_perpus_services.dart';

class PeminjamanBukuPegawai extends StatefulWidget {
  const PeminjamanBukuPegawai({Key? key}) : super(key: key);

  @override
  State<PeminjamanBukuPegawai> createState() => _PeminjamanBukuPegawaiState();
}

class _PeminjamanBukuPegawaiState extends State<PeminjamanBukuPegawai> {
  bool _loading = true;
  List<dynamic> bookSiswaPerpusList = [];

  Future<void> fungsiGetBookPerpus() async {
    ApiResponse response = await getPengajuanBookPegawaiPerpus();
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
                  PengajuanBukuPegawaiPerpusModel
                      pengajuanBukuPegawaiPerpusModel =
                      bookSiswaPerpusList[index];
                  return Column(
                    children: [
                      TextParagraf(
                          title: 'Nama',
                          value: pengajuanBukuPegawaiPerpusModel.firstName +
                              ' ' +
                              pengajuanBukuPegawaiPerpusModel.lastName),
                      TextParagraf(
                          title: 'NISN',
                          value: pengajuanBukuPegawaiPerpusModel.nuptk),
                      TextParagraf(
                          title: 'Kode Buku',
                          value: pengajuanBukuPegawaiPerpusModel.bookCode),
                      TextParagraf(
                          title: 'Nama Buku',
                          value: pengajuanBukuPegawaiPerpusModel.bookName),
                      TextParagraf(
                          title: 'Jumlah Buku',
                          value: pengajuanBukuPegawaiPerpusModel.totalBook),
                      GestureDetector(
                        onTap: () async {
                          String refresh = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailPeminjamanBukuPegawai(
                                        pengajuanBukuPegawaiPerpusModel:
                                            pengajuanBukuPegawaiPerpusModel,
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

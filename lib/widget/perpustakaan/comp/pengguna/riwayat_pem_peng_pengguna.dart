import 'package:flutter/material.dart';

import '../../../../constan.dart';
import '../../../../models/api_response_model.dart';
import '../../../../models/perpustakaan/pengguna_perpus_model.dart';
import '../../../../screens/started_screen.dart';
import '../../../../services/auth_service.dart';
import '../../../../services/perpustakaan/pengguna_perpus_service.dart';
import '../../../text_paragraf.dart';

class RiwayatPemPengPengguna extends StatefulWidget {
  const RiwayatPemPengPengguna({Key? key}) : super(key: key);

  @override
  State<RiwayatPemPengPengguna> createState() => _RiwayatPemPengPenggunaState();
}

class _RiwayatPemPengPenggunaState extends State<RiwayatPemPengPengguna> {
  bool _loading = true;
  List<dynamic> riwayatPengPemList = [];

  Future<void> fingsiGetRiwayatPengPem() async {
    ApiResponse response = await getRiwayatPengPemPengguna();
    if (response.error == null) {
      setState(() {
        riwayatPengPemList = response.data as List<dynamic>;
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
    fingsiGetRiwayatPengPem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Riwayat",
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
                    itemCount: riwayatPengPemList.length,
                    itemBuilder: (BuildContext context, int index) {
                      RiwayarPengPemModel riwayarPengPemModel =
                          riwayatPengPemList[index];
                      return Column(
                        children: [
                          TextParagraf(
                            title: 'Kode Buku',
                            value: riwayarPengPemModel.bookCode,
                          ),
                          TextParagraf(
                            title: 'Nama Buku',
                            value: riwayarPengPemModel.bookName,
                          ),
                          TextParagraf(
                            title: 'Pengarang',
                            value: riwayarPengPemModel.bookCreator,
                          ),
                          TextParagraf(
                            title: 'Tahun Buku',
                            value: riwayarPengPemModel.bookYear,
                          ),
                          TextParagraf(
                            title: 'Tanggal',
                            value: riwayarPengPemModel.date,
                          ),
                          // TextParagraf(
                          //   title: 'Keterangan',
                          //   value: riwayarPengPemModel.status,
                          // ),
                          // TextParagraf(
                          //   title: 'Status',
                          //   value: riwayarPengPemModel.status,
                          // ),
                          // TextParagraf(title: 'Denda', value: 'MASIH BELUM'),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              height: 1,
                              color: Color(0xff4B556B),
                            ),
                          )
                        ],
                      );
                    })));
  }
}

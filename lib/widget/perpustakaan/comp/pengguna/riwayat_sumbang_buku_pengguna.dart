import 'package:flutter/material.dart';

import '../../../../constan.dart';
import '../../../../models/api_response_model.dart';
import '../../../../models/perpustakaan/pengguna_perpus_model.dart';
import '../../../../screens/started_screen.dart';
import '../../../../services/auth_service.dart';
import '../../../../services/perpustakaan/pengguna_perpus_service.dart';
import '../../../text_paragraf.dart';

class RiwayatSumbangBukuPengguna extends StatefulWidget {
  const RiwayatSumbangBukuPengguna({Key? key}) : super(key: key);

  @override
  State<RiwayatSumbangBukuPengguna> createState() =>
      _RiwayatSumbangBukuPenggunaState();
}

class _RiwayatSumbangBukuPenggunaState
    extends State<RiwayatSumbangBukuPengguna> {
  bool _loading = true;
  List<dynamic> bookSiswaPerpusList = [];

  Future<void> fungsigethistorysumbangbyuser() async {
    ApiResponse response = await gethistorysumbangbyuser();
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
    fungsigethistorysumbangbyuser();
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
          child: ListView.builder(
              itemCount: bookSiswaPerpusList.length,
              itemBuilder: (BuildContext context, int index) {
                RiwayarPengPemModel2 riwayarPengPemModel2 =
                    bookSiswaPerpusList[index];
                return Column(
                  children: [
                    TextParagraf(
                        title: 'Kode Buku',
                        value: riwayarPengPemModel2.bookCode),
                    TextParagraf(
                        title: 'Nama Buku',
                        value: riwayarPengPemModel2.bookName),
                    TextParagraf(
                        title: 'Pengarang',
                        value: riwayarPengPemModel2.bookCreator),
                    TextParagraf(
                        title: 'Tahun Buku',
                        value: riwayarPengPemModel2.bookYear),
                    TextParagraf(
                        title: 'Status', value: riwayarPengPemModel2.status),
                    TextParagraf(
                        title: 'Tanggal', value: riwayarPengPemModel2.date),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
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

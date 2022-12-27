import 'package:flutter/material.dart';

class TataCara extends StatefulWidget {
  const TataCara({Key? key}) : super(key: key);

  @override
  State<TataCara> createState() => _TataCaraState();
}

class _TataCaraState extends State<TataCara> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tata Cara Dan Persyaratan Mutasi",
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
          children: [
            const Center(
              child: Text(
                "Tata Cara Dan Persyaratan Mutasi",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xff4B556B),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
            ),
            Center(
              child: Container(
                color: const Color(0xff4B556B),
                height: 2,
                width: MediaQuery.of(context).size.width * 0.7,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const ItemTataCara(
              number: '1.',
              conten:
                  'Serahkan surat permohonan pindah dari orang tua / wali ke pihak TU sekolah.',
            ),
            const ItemTataCara(
              number: '2.',
              conten:
                  'Ajukan surat pernyataan tidak sedang menjalani sanksi sekolah, surat permohonan pindah dari sekolah asal, dan surat rekomendasi dinas melalui TU.',
            ),
            const ItemTataCara(
              number: '3.',
              conten:
                  'Selanjutnya masukkan data dan unggah semua dokumen dalam fitur mutasi SIPENLA dan simpan.',
            ),
            const ItemTataCara(
              number: '4.',
              conten:
                  'Cek status riwayat pengajuan mutasi hingga terkonfirmasi oleh kepala sekolah.',
            ),
            const ItemTataCara(
              number: '5.',
              conten:
                  'Jika terkonfirmasi maka akun siswa akan berubah seperti akun wali murid.',
            ),
          ],
        ),
      ),
    );
  }
}

class ItemTataCara extends StatelessWidget {
  const ItemTataCara({Key? key, required this.conten, required this.number})
      : super(key: key);

  final String number, conten;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              number,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xff4B556B),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                letterSpacing: 1,
              ),
            ),
            Expanded(
              child: Text(
                conten,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xff4B556B),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../text_paragraf.dart';

class DetailKonfirmasiNilaiSiswaKepsek extends StatefulWidget {
  const DetailKonfirmasiNilaiSiswaKepsek({Key? key}) : super(key: key);

  @override
  State<DetailKonfirmasiNilaiSiswaKepsek> createState() =>
      DetailKonfirmasiNilaiSiswaKepsekState();
}

class DetailKonfirmasiNilaiSiswaKepsekState
    extends State<DetailKonfirmasiNilaiSiswaKepsek> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Data Nilai Siswa",
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
        child: Column(
          children: [
            const Center(
              child: Text(
                "Nilai Rapor",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff4B556B),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
            ),
            const Center(
              child: Text(
                'Semester ',
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xff4B556B),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1,
                ),
              ),
            ),
            const Center(
              child: Text(
                'Kelas ',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xff4B556B),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xff4B556B),
                  ),
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: const [
                    TextParagraf(
                      title: 'Nama Siswa',
                      value: 'Lorem Ipsum',
                    ),
                    TextParagraf(
                      title: 'NISN',
                      value: 'Lorem Ipsum',
                    ),
                    TextParagraf(
                      title: 'Status',
                      value: 'Lorem Ipsum',
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

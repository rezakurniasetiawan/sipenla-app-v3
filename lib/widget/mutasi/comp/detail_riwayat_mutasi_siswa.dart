import 'package:flutter/material.dart';
import 'package:siakad_app/widget/mutasi/comp/view_pdf.dart';
import 'package:siakad_app/widget/text_paragraf.dart';

import '../../../models/mutasi_model.dart';

class DetailRiwayatMutasiSiswa extends StatefulWidget {
  const DetailRiwayatMutasiSiswa(
      {Key? key, required this.riwayatMutasiSiswaModel})
      : super(key: key);

  final RiwayatMutasiSiswaModel riwayatMutasiSiswaModel;

  @override
  State<DetailRiwayatMutasiSiswa> createState() =>
      _DetailRiwayatMutasiSiswaState();
}

class _DetailRiwayatMutasiSiswaState extends State<DetailRiwayatMutasiSiswa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detail Riwayat Mutasi",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 25,
                    child: Image.asset('assets/image/logo-sipenla.png'),
                  ),
                  SizedBox(
                    height: 25,
                    child: Image.asset('assets/image/kemendikbud.png'),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  "FOLUMULIR",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff4B556B),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Center(
                child: Column(
                  children: [
                    const Text(
                      "Pengajuan Mutasi",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff4B556B),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                    Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width * 0.4,
                      color: Color(0xff4B556B),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextParagraf(
                  title: '1. Nama Depan',
                  value: widget.riwayatMutasiSiswaModel.firstName),
              TextParagraf(
                  title: '2. Nama Belakang',
                  value: widget.riwayatMutasiSiswaModel.lastName),
              TextParagraf(
                  title: '3. Nama NISN',
                  value: widget.riwayatMutasiSiswaModel.nisn),
              TextParagraf(
                  title: '4. Tempat, Tanggal Lahir',
                  value: widget.riwayatMutasiSiswaModel.placeOfBirth +
                      widget.riwayatMutasiSiswaModel.dateOfBirth
                          .toIso8601String()),
              TextParagraf(
                  title: '5. Jenis Kelamin',
                  value: widget.riwayatMutasiSiswaModel.gender),
              TextParagraf(
                  title: '6. Agama',
                  value: widget.riwayatMutasiSiswaModel.religion),
              TextParagraf(
                  title: '7. alamat Tinggal',
                  value: widget.riwayatMutasiSiswaModel.address),
              TextParagraf(
                  title: '8. Asal Sekolah',
                  value: widget.riwayatMutasiSiswaModel.schoolOrigin),
              TextParagraf(
                  title: '9. Pindah Ke',
                  value: widget.riwayatMutasiSiswaModel.toSchool),
              const Text(
                'Nama Orang Tua / Wali',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  color: Color(0xff4B556B),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextParagraf(
                  title: 'a. Ayah',
                  value: widget.riwayatMutasiSiswaModel.fatherName),
              TextParagraf(
                  title: 'b. Ibu',
                  value: widget.riwayatMutasiSiswaModel.motherName),
              TextParagraf(
                  title: '11. Alamat Orang Tua ',
                  value: widget.riwayatMutasiSiswaModel.parentAddress),
              TextParagraftwithButton(
                title: '12. Surat Permohonan Pindah Dari Orang Tua / Wali',
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewPDF(
                              linkpdf: widget.riwayatMutasiSiswaModel
                                  .letterSchoolTransfer)));
                },
              ),
              TextParagraftwithButton(
                title: '13. Ijazah',
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewPDF(
                              linkpdf: widget
                                  .riwayatMutasiSiswaModel.letterIjazah)));
                },
              ),
              TextParagraftwithButton(
                title: '14. Rapor',
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewPDF(
                              linkpdf: widget.riwayatMutasiSiswaModel.rapor)));
                },
              ),
              TextParagraftwithButton(
                title: '15. Surat Pernyataan Tidak Sedang Menjalani Sanksi',
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewPDF(
                              linkpdf: widget
                                  .riwayatMutasiSiswaModel.letterNoSanksi)));
                },
              ),
              TextParagraftwithButton(
                title: '16. Surat Rekomendasi Dari Diknas',
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewPDF(
                              linkpdf: widget
                                  .riwayatMutasiSiswaModel.letterRecomDiknas)));
                },
              ),
              TextParagraftwithButton(
                title: '17. KK',
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewPDF(
                              linkpdf: widget
                                  .riwayatMutasiSiswaModel.kartuKeluarga)));
                },
              ),
              TextParagraftwithButton(
                title: '18. Surat Keterangan Pindah Dari Sekolah Asal',
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewPDF(
                              linkpdf: widget.riwayatMutasiSiswaModel
                                  .letterSchoolTransfer)));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextParagraftwithButton extends StatelessWidget {
  const TextParagraftwithButton(
      {Key? key, required this.press, required this.title})
      : super(key: key);

  final String title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 130,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  color: Color(0xff4B556B),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
              child: Text(
                ": ",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                  color: Color(0xff4B556B),
                ),
              ),
            ),
            InkWell(
              onTap: press,
              child: Container(
                width: 96,
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
                      letterSpacing: 1),
                )),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}

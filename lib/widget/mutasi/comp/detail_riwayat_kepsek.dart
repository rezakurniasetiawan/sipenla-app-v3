import 'package:flutter/material.dart';
import 'package:siakad_app/widget/mutasi/comp/view_pdf.dart';

import '../../../models/mutasi_model.dart';
import '../../text_paragraf.dart';

class DetailRiwayatKepsek extends StatefulWidget {
  const DetailRiwayatKepsek(
      {Key? key, required this.riwayatMutasiforKepsekModel})
      : super(key: key);

  final RiwayatMutasiforKepsekModel riwayatMutasiforKepsekModel;

  @override
  State<DetailRiwayatKepsek> createState() => _DetailRiwayatKepsekState();
}

class _DetailRiwayatKepsekState extends State<DetailRiwayatKepsek> {
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
                  value: widget.riwayatMutasiforKepsekModel.firstName),
              TextParagraf(
                  title: '2. Nama Belakang',
                  value: widget.riwayatMutasiforKepsekModel.lastName),
              TextParagraf(
                  title: '3. Nama NISN',
                  value: widget.riwayatMutasiforKepsekModel.nisn),
              TextParagraf(
                  title: '4. Tempat, Tanggal Lahir',
                  value: widget.riwayatMutasiforKepsekModel.placeOfBirth +
                      widget.riwayatMutasiforKepsekModel.dateOfBirth
                          .toIso8601String()),
              TextParagraf(
                  title: '5. Jenis Kelamin',
                  value: widget.riwayatMutasiforKepsekModel.gender),
              TextParagraf(
                  title: '6. Agama',
                  value: widget.riwayatMutasiforKepsekModel.religion),
              TextParagraf(
                  title: '7. alamat Tinggal',
                  value: widget.riwayatMutasiforKepsekModel.address),
              TextParagraf(
                  title: '8. Asal Sekolah',
                  value: widget.riwayatMutasiforKepsekModel.schoolOrigin),
              TextParagraf(
                  title: '9. Pindah Ke',
                  value: widget.riwayatMutasiforKepsekModel.toSchool),
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
                  value: widget.riwayatMutasiforKepsekModel.fatherName),
              TextParagraf(
                  title: 'b. Ibu',
                  value: widget.riwayatMutasiforKepsekModel.motherName),
              TextParagraf(
                  title: '11. Alamat Orang Tua ',
                  value: widget.riwayatMutasiforKepsekModel.parentAddress),
              TextParagraftwithButton(
                title: '12. Surat Permohonan Pindah Dari Orang Tua / Wali',
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewPDF(
                              linkpdf: widget.riwayatMutasiforKepsekModel
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
                                  .riwayatMutasiforKepsekModel.letterIjazah)));
                },
              ),
              TextParagraftwithButton(
                title: '14. Rapor',
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewPDF(
                              linkpdf:
                                  widget.riwayatMutasiforKepsekModel.rapor)));
                },
              ),
              TextParagraftwithButton(
                title: '15. Surat Pernyataan Tidak Sedang Menjalani Sanksi',
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewPDF(
                              linkpdf: widget.riwayatMutasiforKepsekModel
                                  .letterNoSanksi)));
                },
              ),
              TextParagraftwithButton(
                title: '16. Surat Rekomendasi Dari Diknas',
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewPDF(
                              linkpdf: widget.riwayatMutasiforKepsekModel
                                  .letterRecomDiknas)));
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
                                  .riwayatMutasiforKepsekModel.kartuKeluarga)));
                },
              ),
              TextParagraftwithButton(
                title: '18. Surat Keterangan Pindah Dari Sekolah Asal',
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewPDF(
                              linkpdf: widget.riwayatMutasiforKepsekModel
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

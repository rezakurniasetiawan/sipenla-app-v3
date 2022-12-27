import 'package:flutter/material.dart';
import 'package:siakad_app/widget/mutasi/comp/view_pdf.dart';

import '../../../constan.dart';
import '../../../models/api_response_model.dart';
import '../../../models/mutasi_model.dart';
import '../../../screens/started_screen.dart';
import '../../../services/auth_service.dart';
import '../../../services/mutasi_services.dart';
import '../../text_paragraf.dart';
import 'detail_riwayat_mutasi_siswa.dart';

class DetailRiwayatMutasiKepsek extends StatefulWidget {
  const DetailRiwayatMutasiKepsek(
      {Key? key, required this.riwayatMutasiforKepsekModel})
      : super(key: key);

  final RiwayatMutasiforKepsekModel riwayatMutasiforKepsekModel;

  @override
  State<DetailRiwayatMutasiKepsek> createState() =>
      _DetailRiwayatMutasiKepsekState();
}

class _DetailRiwayatMutasiKepsekState extends State<DetailRiwayatMutasiKepsek> {
  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(
            color: Colors.blueAccent,
          ),
          Container(
              margin: const EdgeInsets.only(left: 5),
              child: const Text("Loading")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void fungsiKonfirmasiMutasiKepsek(int idMutasi) async {
    showAlertDialog(context);
    ApiResponse response =
        await mutasiKonfirmasiKepsek(idMutasi: idMutasi.toString());
    if (response.error == null) {
      print("Konfirmasi Sukses");
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context, 'refresh');
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Berhasil Konfirmasi Mutasi')));
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const GetStartedScreen()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Ada Kesalahan')));
    }
  }

  void fungsiTidakKonfirmasiMutasiKepsek(int idMutasi) async {
    showAlertDialog(context);
    ApiResponse response =
        await mutasiTidakKonfirmasiKepsek(idMutasi: idMutasi.toString());
    if (response.error == null) {
      print("Tidak Konfirmasi Sukses");
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context, 'refresh');
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Berhasil Tidak Konfirmasi Mutasi')));
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const GetStartedScreen()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Ada Kesalahan')));
    }
  }

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
                      ' ' +
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
              Text(
                'Nama Orang Tua / Wali',
                style: const TextStyle(
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
                press: () {},
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Container(
                            child: AlertDialog(
                              actions: [
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 85,
                                      width: 85,
                                      child: Image.asset(
                                          'assets/icons/warning-icon.png'),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      child: Text(
                                        'Apakah Anda Yakin Ingin Melakukan Tidak Konfirmasi?',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Poppins',
                                          color: Color(0xff4B556B),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 130,
                                          height: 44,
                                          decoration: BoxDecoration(
                                              color: const Color(0xffFF4238),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                "Batal",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: 'Poppins',
                                                    color: Colors.white),
                                              )),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          width: 130,
                                          height: 44,
                                          decoration: BoxDecoration(
                                              color: const Color(0xff83BC10),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: TextButton(
                                            onPressed: () {
                                              fungsiTidakKonfirmasiMutasiKepsek(
                                                  widget
                                                      .riwayatMutasiforKepsekModel
                                                      .mutasiId);
                                            },
                                            child: const Text(
                                              "Setuju",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'Poppins',
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xff2E447C),
                        ),
                      ),
                      child: const Center(
                          child: Text(
                        "Tidak Dikonfirmasi",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: Color(0xff2E447C),
                            letterSpacing: 1),
                      )),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Container(
                            child: AlertDialog(
                              actions: [
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 85,
                                      width: 85,
                                      child: Image.asset(
                                          'assets/icons/warning-icon.png'),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      child: Text(
                                        'Apakah Anda Yakin Ingin Melakukan Konfirmasi?',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Poppins',
                                          color: Color(0xff4B556B),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 130,
                                          height: 44,
                                          decoration: BoxDecoration(
                                              color: const Color(0xffFF4238),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                "Batal",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: 'Poppins',
                                                    color: Colors.white),
                                              )),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          width: 130,
                                          height: 44,
                                          decoration: BoxDecoration(
                                              color: const Color(0xff83BC10),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: TextButton(
                                            onPressed: () {
                                              fungsiKonfirmasiMutasiKepsek(widget
                                                  .riwayatMutasiforKepsekModel
                                                  .mutasiId);
                                            },
                                            child: const Text(
                                              "Setuju",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'Poppins',
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 45,
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
                        "Konfirmasi",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            letterSpacing: 1),
                      )),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

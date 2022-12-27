import 'package:flutter/material.dart';

import '../../../../../models/perpustakaan/pegawai_perpus_model.dart';
import '../../../../laporan-keuangan/isi-saldo-page/isi-saldo/isi_saldo.dart';
import '../../../../text_paragraf.dart';
import '../../../../../constan.dart';
import '../../../../../models/api_response_model.dart';
import '../../../../../screens/started_screen.dart';
import '../../../../../services/auth_service.dart';
import '../../../../../services/perpustakaan/pegawai_perpus_services.dart';

class DetailPengembalianBukuSiswa extends StatefulWidget {
  const DetailPengembalianBukuSiswa(
      {Key? key, required this.pengajuanBukuSiswaPerpusModel})
      : super(key: key);

  final PengajuanBukuSiswaPerpusModel pengajuanBukuSiswaPerpusModel;

  @override
  State<DetailPengembalianBukuSiswa> createState() =>
      _DetailPengembalianBukuSiswaState();
}

class _DetailPengembalianBukuSiswaState
    extends State<DetailPengembalianBukuSiswa> {
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

  void fungsiAprrovePengembalianBuku(int loadId) async {
    showAlertDialog(context);
    ApiResponse response =
        await approvePengembalianBukuPerpus(idLoan: loadId.toString());
    if (response.error == null) {
      print("Pengajuan Suskses");
      Navigator.pop(context);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Berhasil Konfirmasi Pengembalian Buku')));
      setState(() {
        Navigator.pop(context, 'refresh');
      });
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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  TextParagraf(
                      title: 'Nama',
                      value: widget.pengajuanBukuSiswaPerpusModel.firstName +
                          ' ' +
                          widget.pengajuanBukuSiswaPerpusModel.lastName),
                  TextParagraf(
                      title: 'NISN',
                      value: widget.pengajuanBukuSiswaPerpusModel.nisn),
                  TextParagraf(
                      title: 'Kode Buku',
                      value: widget.pengajuanBukuSiswaPerpusModel.bookCode),
                  TextParagraf(
                      title: 'Nama Buku',
                      value: widget.pengajuanBukuSiswaPerpusModel.bookName),
                  TextParagraf(
                      title: 'Pengarang',
                      value: widget.pengajuanBukuSiswaPerpusModel.bookCreator),
                  TextParagraf(
                      title: 'Tahun Buku',
                      value: widget.pengajuanBukuSiswaPerpusModel.bookYear),
                  TextParagraf(
                      title: 'Jumlah Buku',
                      value: widget.pengajuanBukuSiswaPerpusModel.totalBook),
                  TextParagraf(
                      title: 'Tanggal Pengembalian',
                      value: widget.pengajuanBukuSiswaPerpusModel.toDate.day
                              .toString() +
                          '-' +
                          widget.pengajuanBukuSiswaPerpusModel.toDate.month
                              .toString() +
                          '-' +
                          widget.pengajuanBukuSiswaPerpusModel.toDate.year
                              .toString()),
                  TextParagraf(
                    title: 'Denda',
                    value: widget.pengajuanBukuSiswaPerpusModel.statusLoan ==
                            'Telat'
                        ? FormatCurrency.convertToIdr(
                            widget.pengajuanBukuSiswaPerpusModel.denda, 0)
                        : widget.pengajuanBukuSiswaPerpusModel.statusLoan ==
                                'Hilang'
                            ? FormatCurrency.convertToIdr(
                                int.parse(widget
                                    .pengajuanBukuSiswaPerpusModel.bookPrice),
                                0)
                            : FormatCurrency.convertToIdr(
                                widget.pengajuanBukuSiswaPerpusModel.denda, 0),
                  ),
                  TextParagraf(
                      title: 'Status',
                      value: widget.pengajuanBukuSiswaPerpusModel.statusLoan ==
                              'default'
                          ? 'Tidak Ada Denda'
                          : widget.pengajuanBukuSiswaPerpusModel.statusLoan),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>
                    //             const PengembalianBukuHilangPengguna()));
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
                      "Batal",
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
                                      'Apakah Anda Yakin Ingin Mengkonfirmasi?',
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                            fungsiAprrovePengembalianBuku(widget
                                                .pengajuanBukuSiswaPerpusModel
                                                .loanBookId);
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
    );
  }
}

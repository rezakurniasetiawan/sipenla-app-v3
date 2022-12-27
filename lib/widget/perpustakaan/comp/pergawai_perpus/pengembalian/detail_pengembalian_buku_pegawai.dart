import 'package:flutter/material.dart';

import '../../../../../constan.dart';
import '../../../../../models/api_response_model.dart';
import '../../../../../models/perpustakaan/pegawai_perpus_model.dart';
import '../../../../../screens/started_screen.dart';
import '../../../../../services/auth_service.dart';
import '../../../../../services/perpustakaan/pegawai_perpus_services.dart';
import '../../../../laporan-keuangan/isi-saldo-page/isi-saldo/isi_saldo.dart';
import '../../../../text_paragraf.dart';

class DetailPengembalianBukuPegawai extends StatefulWidget {
  const DetailPengembalianBukuPegawai(
      {Key? key, required this.pengajuanBukuPegawaiPerpusModel})
      : super(key: key);

  final PengajuanBukuPegawaiPerpusModel2 pengajuanBukuPegawaiPerpusModel;

  @override
  State<DetailPengembalianBukuPegawai> createState() =>
      _DetailPengembalianBukuPegawaiState();
}

class _DetailPengembalianBukuPegawaiState
    extends State<DetailPengembalianBukuPegawai> {
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
                      value: widget.pengajuanBukuPegawaiPerpusModel.firstName +
                          ' ' +
                          widget.pengajuanBukuPegawaiPerpusModel.lastName),
                  TextParagraf(
                      title: 'NUPTK',
                      value: widget.pengajuanBukuPegawaiPerpusModel.nuptk),
                  TextParagraf(
                      title: 'Kode Buku',
                      value: widget.pengajuanBukuPegawaiPerpusModel.bookCode),
                  TextParagraf(
                      title: 'Nama Buku',
                      value: widget.pengajuanBukuPegawaiPerpusModel.bookName),
                  TextParagraf(
                      title: 'Pengarang',
                      value:
                          widget.pengajuanBukuPegawaiPerpusModel.bookCreator),
                  TextParagraf(
                      title: 'Tahun Buku',
                      value: widget.pengajuanBukuPegawaiPerpusModel.bookYear),
                  TextParagraf(
                      title: 'Jumlah Buku',
                      value: widget.pengajuanBukuPegawaiPerpusModel.totalBook),
                  TextParagraf(
                      title: 'Tanggal Pengembalian',
                      value: widget.pengajuanBukuPegawaiPerpusModel.toDate.day
                              .toString() +
                          '-' +
                          widget.pengajuanBukuPegawaiPerpusModel.toDate.month
                              .toString() +
                          '-' +
                          widget.pengajuanBukuPegawaiPerpusModel.toDate.year
                              .toString()),
                  TextParagraf(
                    title: 'Denda',
                    value: widget.pengajuanBukuPegawaiPerpusModel.statusLoan ==
                            'Telat'
                        ? FormatCurrency.convertToIdr(
                            widget.pengajuanBukuPegawaiPerpusModel.denda, 0)
                        : widget.pengajuanBukuPegawaiPerpusModel.statusLoan ==
                                'Hilang'
                            ? FormatCurrency.convertToIdr(
                                int.parse(widget
                                    .pengajuanBukuPegawaiPerpusModel.bookPrice),
                                0)
                            : FormatCurrency.convertToIdr(
                                widget.pengajuanBukuPegawaiPerpusModel.denda,
                                0),
                  ),
                  TextParagraf(
                      title: 'Status',
                      value: widget
                                  .pengajuanBukuPegawaiPerpusModel.statusLoan ==
                              'default'
                          ? 'Tidak Ada Denda'
                          : widget.pengajuanBukuPegawaiPerpusModel.statusLoan),
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
                                                .pengajuanBukuPegawaiPerpusModel
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

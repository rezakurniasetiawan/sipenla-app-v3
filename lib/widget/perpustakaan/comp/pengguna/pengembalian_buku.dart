import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:siakad_app/widget/perpustakaan/comp/pengguna/denda/pembayaran_denda.dart';

import '../../../../models/perpustakaan/pengguna_perpus_model.dart';
import 'detail_pengembalian_pengguna.dart';
import '../../../../constan.dart';
import '../../../../models/api_response_model.dart';
import '../../../../screens/started_screen.dart';
import '../../../../services/auth_service.dart';
import '../../../../services/perpustakaan/pengguna_perpus_service.dart';

class PengembalianBukuLast extends StatefulWidget {
  const PengembalianBukuLast(
      {Key? key, required this.pengembalianOngoingPenggunaPerpusModel})
      : super(key: key);

  final PengembalianOngoingPenggunaPerpusModel
      pengembalianOngoingPenggunaPerpusModel;

  @override
  State<PengembalianBukuLast> createState() => _PengembalianBukuLastState();
}

class _PengembalianBukuLastState extends State<PengembalianBukuLast> {
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

  void fungsiPengembalianBuku(int loadId) async {
    showAlertDialog(context);
    ApiResponse response =
        await approvePengembalianBukuPerpus(idLoan: loadId.toString());
    if (response.error == null) {
      print("Pengajuan Suskses");
      Navigator.pop(context);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Berhasil Pengajuan Pengembalian Buku')));
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Pengembalian",
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
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Center(
                    child: Container(
                      height: 116,
                      width: 83,
                      child: CachedNetworkImage(
                        imageUrl:
                            widget.pengembalianOngoingPenggunaPerpusModel.image,
                        fit: BoxFit.cover,
                        imageBuilder: (context, imageProvider) => Container(
                          width: 83.0,
                          height: 116.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        placeholder: (context, url) => Shimmer(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            gradient: const LinearGradient(stops: [
                              0.2,
                              0.5,
                              0.6
                            ], colors: [
                              Colors.grey,
                              Colors.white12,
                              Colors.grey,
                            ])),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ListDetailBuku(
                    title: 'Kode Buku',
                    value:
                        widget.pengembalianOngoingPenggunaPerpusModel.bookCode,
                  ),
                  ListDetailBuku(
                    title: 'Nama Buku',
                    value:
                        widget.pengembalianOngoingPenggunaPerpusModel.bookName,
                  ),
                  ListDetailBuku(
                    title: 'Jumlah Buku',
                    value:
                        widget.pengembalianOngoingPenggunaPerpusModel.totalBook,
                  ),
                  ListDetailBuku(
                    title: 'Pengarang',
                    value: widget
                        .pengembalianOngoingPenggunaPerpusModel.bookCreator,
                  ),
                  ListDetailBuku(
                      title: 'Tahun',
                      value: widget
                          .pengembalianOngoingPenggunaPerpusModel.bookYear),
                  ListDetailBuku(
                    title: 'Waktu Pinjam',
                    value: widget
                            .pengembalianOngoingPenggunaPerpusModel.fromDate.day
                            .toString() +
                        '-' +
                        widget.pengembalianOngoingPenggunaPerpusModel.fromDate
                            .month
                            .toString() +
                        '-' +
                        widget.pengembalianOngoingPenggunaPerpusModel.fromDate
                            .year
                            .toString(),
                  ),
                  ListDetailBuku(
                      title: 'Denda',
                      value: widget.pengembalianOngoingPenggunaPerpusModel.denda
                          .toString()),
                  ListDetailBuku(
                      title: 'Status',
                      value:
                          widget.pengembalianOngoingPenggunaPerpusModel.status),
                ],
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  if (widget.pengembalianOngoingPenggunaPerpusModel.denda ==
                      0) {
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
                                      'Pengajuan Pengembalian Buku Perpustakaan Sedang Diajukan, Tunggu  Hingga Konfirmasi Selama  30 menit.',
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
                                            color: const Color(0xff83BC10),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: TextButton(
                                          onPressed: () {
                                            fungsiPengembalianBuku(widget
                                                .pengembalianOngoingPenggunaPerpusModel
                                                .loanBookId);
                                          },
                                          child: const Text(
                                            "Oke",
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
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PembayaranDenda(
                                  valueDenda: widget
                                      .pengembalianOngoingPenggunaPerpusModel
                                      .denda,
                                  idLoan: widget
                                      .pengembalianOngoingPenggunaPerpusModel
                                      .loanBookId,
                                )));
                  }
                },
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
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
                      "Lanjutkan",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          letterSpacing: 1),
                    )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

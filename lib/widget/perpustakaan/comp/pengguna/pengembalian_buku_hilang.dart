import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:siakad_app/widget/perpustakaan/comp/pengguna/denda/pembayaran_denda_kehilangan.dart';

import '../../../../models/perpustakaan/pengguna_perpus_model.dart';
import 'detail_pengembalian_pengguna.dart';

class PengembalianBukuHilangPengguna extends StatefulWidget {
  const PengembalianBukuHilangPengguna(
      {Key? key, required this.pengembalianOngoingPenggunaPerpusModel})
      : super(key: key);

  final PengembalianOngoingPenggunaPerpusModel
      pengembalianOngoingPenggunaPerpusModel;

  @override
  State<PengembalianBukuHilangPengguna> createState() =>
      _PengembalianBukuHilangPenggunaState();
}

class _PengembalianBukuHilangPenggunaState
    extends State<PengembalianBukuHilangPengguna> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Kehilangan Buku",
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
                    value:
                        widget.pengembalianOngoingPenggunaPerpusModel.bookYear,
                  ),
                  ListDetailBuku(
                      title: 'Waktu Pinjam',
                      value: widget.pengembalianOngoingPenggunaPerpusModel
                              .fromDate.day
                              .toString() +
                          '-' +
                          widget.pengembalianOngoingPenggunaPerpusModel.fromDate
                              .month
                              .toString() +
                          '-' +
                          widget.pengembalianOngoingPenggunaPerpusModel.fromDate
                              .year
                              .toString()),
                  ListDetailBuku(
                      title: 'Denda',
                      value: widget
                          .pengembalianOngoingPenggunaPerpusModel.bookPrice),
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PembayaranDendaKehilangan(
                                valueDenda: int.parse(
                                  widget.pengembalianOngoingPenggunaPerpusModel
                                      .bookPrice,
                                ),
                                idLoan: widget
                                    .pengembalianOngoingPenggunaPerpusModel
                                    .loanBookId,
                              )));
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

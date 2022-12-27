import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:siakad_app/widget/perpustakaan/comp/pengguna/pengembalian_buku_hilang.dart';
import '../../../../models/perpustakaan/pengguna_perpus_model.dart';

import 'pengembalian_buku.dart';

class DetailPengembalianPengguna extends StatefulWidget {
  const DetailPengembalianPengguna(
      {Key? key, required this.pengembalianOngoingPenggunaPerpusModel})
      : super(key: key);

  final PengembalianOngoingPenggunaPerpusModel
      pengembalianOngoingPenggunaPerpusModel;

  @override
  State<DetailPengembalianPengguna> createState() =>
      _DetailPengembalianPenggunaState();
}

class _DetailPengembalianPenggunaState
    extends State<DetailPengembalianPengguna> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PengembalianBukuHilangPengguna(
                                  pengembalianOngoingPenggunaPerpusModel: widget
                                      .pengembalianOngoingPenggunaPerpusModel,
                                )));
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
                      "Hilang",
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
                  onTap: () async {
                    // fungsiAprrovePeminjamanBuku();
                    String refresh = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PengembalianBukuLast(
                                  pengembalianOngoingPenggunaPerpusModel: widget
                                      .pengembalianOngoingPenggunaPerpusModel,
                                )));

                    if (refresh == 'refresh') {
                      print('jalan');
                      Navigator.pop(context, 'refresh');
                    }
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
                      "Pengembalian",
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

class ListDetailBuku extends StatelessWidget {
  const ListDetailBuku({Key? key, required this.title, required this.value})
      : super(key: key);

  final String title, value;

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
                  color: Color(0xff2E447C),
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
                  color: Color(0xff2E447C),
                ),
              ),
            ),
            Expanded(
              child: Text(
                // widget.kodeFas,
                value,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                  color: Color(0xff2E447C),
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

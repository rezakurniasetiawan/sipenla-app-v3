import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../models/perpustakaan/pengguna_perpus_model.dart';
import '../../pengguna/detail_pengembalian_pengguna.dart';

class DetailRiwayatSumbanganSiswaPerpus extends StatefulWidget {
  const DetailRiwayatSumbanganSiswaPerpus(
      {Key? key, required this.historySumbangBukuSiswaModel})
      : super(key: key);

  final HistorySumbangBukuSiswaModel historySumbangBukuSiswaModel;

  @override
  State<DetailRiwayatSumbanganSiswaPerpus> createState() =>
      _DetailRiwayatSumbanganSiswaPerpusState();
}

class _DetailRiwayatSumbanganSiswaPerpusState
    extends State<DetailRiwayatSumbanganSiswaPerpus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Riwayat Perpustakaan ",
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
            Center(
              child: Container(
                height: 116,
                width: 83,
                child: CachedNetworkImage(
                  imageUrl: widget.historySumbangBukuSiswaModel.image,
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
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ListDetailBuku(
                title: 'Nama',
                value: widget.historySumbangBukuSiswaModel.firstName +
                    ' ' +
                    widget.historySumbangBukuSiswaModel.lastName),
            ListDetailBuku(
                title: 'NISN', value: widget.historySumbangBukuSiswaModel.nisn),
            ListDetailBuku(
                title: 'Kode Buku',
                value: widget.historySumbangBukuSiswaModel.bookCode),
            ListDetailBuku(
                title: 'Nama Buku',
                value: widget.historySumbangBukuSiswaModel.bookName),
            ListDetailBuku(
                title: 'Pengarang',
                value: widget.historySumbangBukuSiswaModel.bookCreator),
            ListDetailBuku(
                title: 'Tahun Buku',
                value: widget.historySumbangBukuSiswaModel.bookYear),
            ListDetailBuku(
                title: 'Tanggal',
                value: widget.historySumbangBukuSiswaModel.date),
            ListDetailBuku(
                title: 'Keterangan',
                value: widget.historySumbangBukuSiswaModel.status),
            ListDetailBuku(
                title: 'Status',
                value: widget.historySumbangBukuSiswaModel.status),
          ],
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../models/perpustakaan/pegawai_perpus_model.dart';
import '../../text_paragraf.dart';

class DetailBukuPerpus extends StatefulWidget {
  const DetailBukuPerpus({Key? key, required this.dataBukuPerpusModel})
      : super(key: key);

  final DataBukuPerpusModel dataBukuPerpusModel;

  @override
  State<DetailBukuPerpus> createState() => _DetailBukuPerpusState();
}

class _DetailBukuPerpusState extends State<DetailBukuPerpus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Data Buku",
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
            Center(
              child: Container(
                height: 116,
                width: 83,
                child: CachedNetworkImage(
                  imageUrl: widget.dataBukuPerpusModel.image,
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
              height: 20,
            ),
            TextParagraf(
              title: 'Kode Buku',
              value: widget.dataBukuPerpusModel.bookCode,
            ),
            TextParagraf(
              title: 'Nama Buku',
              value: widget.dataBukuPerpusModel.bookName,
            ),
            TextParagraf(
              title: 'Harga Buku',
              value: widget.dataBukuPerpusModel.bookPrice,
            ),
            TextParagraf(
              title: 'Pengarang',
              value: widget.dataBukuPerpusModel.bookCreator,
            ),
            TextParagraf(
              title: 'Tahun Buku',
              value: widget.dataBukuPerpusModel.bookYear,
            ),
            TextParagraf(
              title: 'Jumlah Buku',
              value: widget.dataBukuPerpusModel.numberOfBook,
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:siakad_app/models/news_school_model.dart';

class DetailBerita extends StatefulWidget {
  const DetailBerita({Key? key, required this.newsModel}) : super(key: key);

  final NewsModel newsModel;

  @override
  State<DetailBerita> createState() => _DetailBeritaState();
}

class _DetailBeritaState extends State<DetailBerita> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Berita Sekolah",
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
          children: [
            Center(
              child: Text(
                widget.newsModel.newsTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  color: Color(0xff4B556B),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 185,
              width: MediaQuery.of(context).size.width,
              // decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(16),
              //     image: DecorationImage(
              //         image:
              //             AssetImage("assets/image/berita1.png"),
              //         fit: BoxFit.cover)),
              child: widget.newsModel.newsImage != null
                  ? CachedNetworkImage(
                      imageUrl: widget.newsModel.newsImage,
                      fit: BoxFit.cover,
                      imageBuilder: (context, imageProvider) => Container(
                        width: 75.0,
                        height: 75.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      placeholder: (context, url) => Shimmer(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(16),
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
                    )
                  : Container(
                      height: 185,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: const DecorationImage(
                              image: AssetImage(
                                  "assets/image/image-not-available.jpg"),
                              fit: BoxFit.cover)),
                    ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '\t \t \t \t${widget.newsModel.newsContent}',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff4B556B),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      )),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:siakad_app/models/fasilitas_model.dart';

class DetailFasilitas extends StatefulWidget {
  const DetailFasilitas({Key? key, required this.fasilitasModel})
      : super(key: key);

  final FasilitasModel fasilitasModel;

  @override
  State<DetailFasilitas> createState() => _DetailFasilitasState();
}

class _DetailFasilitasState extends State<DetailFasilitas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Data Fasilitas",
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
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          widget.fasilitasModel.image == null
              ? Center(
                  child: Container(
                    height: 116,
                    width: 83,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.red),
                  ),
                )
              : Center(
                  child: Container(
                    height: 116,
                    width: 83,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: widget.fasilitasModel.image,
                      fit: BoxFit.cover,
                      imageBuilder: (context, imageProvider) => Container(
                        width: 70.0,
                        height: 70.0,
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
                              borderRadius: BorderRadius.circular(15),
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
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 130,
                      child: Text(
                        "Kode Fasilitas",
                        style: TextStyle(
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
                    Expanded(
                      child: Text(
                        widget.fasilitasModel.facilityCode,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          color: Color(0xff4B556B),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 130,
                      child: Text(
                        "Nama Fasilitas",
                        style: TextStyle(
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
                    Expanded(
                      child: Text(
                        widget.fasilitasModel.facilityName,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          color: Color(0xff4B556B),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 130,
                      child: Text(
                        "Jumlah Fasilitas",
                        style: TextStyle(
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
                    Expanded(
                      child: Text(
                        widget.fasilitasModel.numberOfFacility,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          color: Color(0xff4B556B),
                        ),
                      ),
                    ),
                  ],
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     const SizedBox(
                //       width: 130,
                //       child: Text(
                //         "Milik",
                //         style: TextStyle(
                //           fontSize: 12,
                //           fontWeight: FontWeight.w600,
                //           fontFamily: 'Poppins',
                //           color: Color(0xff4B556B),
                //         ),
                //       ),
                //     ),
                //     const SizedBox(
                //       width: 10,
                //       child: Text(
                //         ": ",
                //         style: TextStyle(
                //           fontSize: 12,
                //           fontWeight: FontWeight.w400,
                //           fontFamily: 'Poppins',
                //           color: Color(0xff4B556B),
                //         ),
                //       ),
                //     ),
                //     // Expanded(
                //     //   child: Text(
                //     //     widget.fasilitasModel.ownedBy,
                //     //     style: const TextStyle(
                //     //       fontSize: 12,
                //     //       fontWeight: FontWeight.w400,
                //     //       fontFamily: 'Poppins',
                //     //       color: Color(0xff4B556B),
                //     //     ),
                //     //   ),
                //     // ),
                //   ],
                // ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 130,
                      child: Text(
                        "Keterangan",
                        style: TextStyle(
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
                        widget.fasilitasModel.status,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

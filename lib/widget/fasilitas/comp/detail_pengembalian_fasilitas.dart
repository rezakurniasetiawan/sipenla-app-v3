import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/fasilitas_model.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:siakad_app/services/fasilitas_service.dart';

class DetailPengembalianFasilitas extends StatefulWidget {
  const DetailPengembalianFasilitas(
      {Key? key,
      required this.idLoad,
      required this.kodeFas,
      required this.tanggalakhir,
      required this.nameFas,
      required this.imageFas,
      required this.jumlahFas,
      required this.tanggalawal})
      : super(key: key);

  final String tanggalawal, tanggalakhir, kodeFas, nameFas, jumlahFas, imageFas;
  final int idLoad;

  @override
  State<DetailPengembalianFasilitas> createState() =>
      _DetailPengembalianFasilitasState();
}

class _DetailPengembalianFasilitasState
    extends State<DetailPengembalianFasilitas> {
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

  void fungsiAjukanPengFas(int loadId) async {
    showAlertDialog(context);
    ApiResponse response = await ajukanPengmebalianFasilitas(idLoan: loadId);
    if (response.error == null) {
      print("Pengajuan Suskses");
      Navigator.pop(context);
      Navigator.pop(context, 'refresh');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Berhasil Mengajukan Pengembalian Fasilitas')));
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
          "Pengembalian Fasilitas",
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Container(
                      height: 116,
                      width: 83,
                      child: CachedNetworkImage(
                        imageUrl: widget.imageFas,
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
                          widget.kodeFas,
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
                          widget.nameFas,
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
                          widget.jumlahFas,
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 130,
                        child: Text(
                          "Tanggal  Peminjaman",
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
                          widget.tanggalawal,
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 130,
                        child: Text(
                          "Tanggal Pengembalian",
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
                          widget.tanggalakhir,
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
            GestureDetector(
              onTap: () {
                fungsiAjukanPengFas(
                    widget.idLoad);
              },
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
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
                    "Ajukan Pengembalian",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      color: Colors.white,
                    ),
                  )),
                ),
              ),
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}

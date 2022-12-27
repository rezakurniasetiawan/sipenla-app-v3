import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../constan.dart';
import '../../../../../models/api_response_model.dart';
import '../../../../../models/perpustakaan/pegawai_perpus_model.dart';
import '../../../../../screens/started_screen.dart';
import '../../../../../services/auth_service.dart';
import '../../../../../services/perpustakaan/pegawai_perpus_services.dart';
import '../../pengguna/detail_pengembalian_pengguna.dart';

class DetailPeminjamanbukuSiswa extends StatefulWidget {
  const DetailPeminjamanbukuSiswa(
      {Key? key, required this.pengajuanBukuSiswaPerpusModel2})
      : super(key: key);

  final PengajuanBukuSiswaPerpusModel2 pengajuanBukuSiswaPerpusModel2;

  @override
  State<DetailPeminjamanbukuSiswa> createState() =>
      _DetailPeminjamanbukuSiswaState();
}

class _DetailPeminjamanbukuSiswaState extends State<DetailPeminjamanbukuSiswa> {
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

  void fungsiAprrovePeminjamanBuku(int loadId) async {
    showAlertDialog(context);
    ApiResponse response =
        await approvePeminjamanBukuPerpus(idLoan: loadId.toString());
    if (response.error == null) {
      print("Pengajuan Suskses");
      Navigator.pop(context);
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Berhasil Konfirmasi Peminjaman Buku')));

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

  void fungsiReejectPeminjamanBuku(int loadId) async {
    showAlertDialog(context);
    ApiResponse response =
        await reejectPeminjamanBukuPerpus(idLoan: loadId.toString());
    if (response.error == null) {
      print("Pengajuan Suskses");
      Navigator.pop(context);
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Berhasil Tidak Konfirmasi Peminjaman Buku')));

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
          "Peminjaman Buku",
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
                        imageUrl: widget.pengajuanBukuSiswaPerpusModel2.image,
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
                      title: 'Nama',
                      value: widget.pengajuanBukuSiswaPerpusModel2.firstName +
                          ' ' +
                          widget.pengajuanBukuSiswaPerpusModel2.lastName),
                  ListDetailBuku(
                      title: 'NISN',
                      value: widget.pengajuanBukuSiswaPerpusModel2.nisn),
                  ListDetailBuku(
                      title: 'Kode Buku',
                      value: widget.pengajuanBukuSiswaPerpusModel2.bookCode),
                  ListDetailBuku(
                      title: 'Nama Buku',
                      value: widget.pengajuanBukuSiswaPerpusModel2.bookName),
                  ListDetailBuku(
                      title: 'Pengarang',
                      value: widget.pengajuanBukuSiswaPerpusModel2.bookCreator),
                  ListDetailBuku(
                      title: 'Tahun Buku',
                      value: widget.pengajuanBukuSiswaPerpusModel2.bookYear),
                  ListDetailBuku(
                      title: 'Jumlah Buku',
                      value: widget.pengajuanBukuSiswaPerpusModel2.totalBook),
                  ListDetailBuku(
                      title: 'Tanggal Pengembalian',
                      value: widget.pengajuanBukuSiswaPerpusModel2.toDate
                          .toIso8601String()),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                                      'Apakah Anda Yakin Ingin Tidak Mengkonfirmasi?',
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
                                            fungsiReejectPeminjamanBuku(widget
                                                .pengajuanBukuSiswaPerpusModel2
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
                                            fungsiAprrovePeminjamanBuku(widget
                                                .pengajuanBukuSiswaPerpusModel2
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

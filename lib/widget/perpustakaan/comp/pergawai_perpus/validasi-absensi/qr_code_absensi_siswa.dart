import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:siakad_app/widget/text_paragraf.dart';

import '../../../../../constan.dart';
import '../../../../../models/api_response_model.dart';
import '../../../../../models/perpustakaan/pegawai_perpus_model.dart';
import '../../../../../screens/started_screen.dart';
import '../../../../../services/auth_service.dart';
import '../../../../../services/perpustakaan/pegawai_perpus_services.dart';

class QrCodeAbsensiSiswa extends StatefulWidget {
  const QrCodeAbsensiSiswa({Key? key, required this.codeku}) : super(key: key);

  final String codeku;

  @override
  State<QrCodeAbsensiSiswa> createState() => _QrCodeAbsensiSiswaState();
}

class _QrCodeAbsensiSiswaState extends State<QrCodeAbsensiSiswa> {
  QrCodeSiswaModel? qrCodeSiswaModel;
  bool loading = true;

  void getUserData() async {
    ApiResponse response = await getDataSiswaQrCode(code: widget.codeku);
    if (response.error == null) {
      setState(() {
        qrCodeSiswaModel = response.data as QrCodeSiswaModel;
        loading = false;
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
          .showSnackBar(SnackBar(content: Text('${response.error}')));
      if (response.error == 'Siswa Tidak Ditemukan!') {
        Navigator.pop(context);
      }
    }
  }

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

  void fungsipostabsenstudent(int studentId) async {
    showAlertDialog(context);
    ApiResponse response =
        await postabsenstudentService(studentId: studentId.toString());
    if (response.error == null) {
      Navigator.pop(context);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Berhasil Validasi Siswa')));
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const GetStartedScreen()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Hasil Validasi",
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
          loading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blueAccent,
                  ),
                )
              : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 130,
                          height: 180,
                          child: qrCodeSiswaModel!.image != null
                              ? CachedNetworkImage(
                                  imageUrl: qrCodeSiswaModel!.image,
                                  fit: BoxFit.cover,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    height: 100.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  placeholder: (context, url) => Shimmer(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                              : Shimmer(
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                  gradient: const LinearGradient(
                                    stops: [0.2, 0.5, 0.6],
                                    colors: [
                                      Colors.grey,
                                      Colors.white12,
                                      Colors.grey,
                                    ],
                                  ),
                                ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextParagraf(
                            title: 'Nama',
                            value: qrCodeSiswaModel!.firstName +
                                ' ' +
                                qrCodeSiswaModel!.lastName),
                        TextParagraf(
                            title: 'NISN', value: qrCodeSiswaModel!.nisn),
                        TextParagraf(
                            title: 'Jabatan',
                            value: qrCodeSiswaModel!.jabatan == 'student'
                                ? 'Siswa'
                                : qrCodeSiswaModel!.jabatan),
                      ],
                    ),
                  ),
                ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
              onTap: () {
                fungsipostabsenstudent(qrCodeSiswaModel!.studentId);
              },
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
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
                    "Simpan",
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
    );
  }
}

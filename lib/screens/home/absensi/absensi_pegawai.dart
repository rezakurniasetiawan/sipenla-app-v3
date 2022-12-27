import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/screens/home/absensi/izin_cuti_pegawai.dart';
import 'package:siakad_app/screens/home/absensi/izin_tugas_dinas.dart';
import 'package:siakad_app/screens/home/absensi/list_absensi_pegawai.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/services/absensi_service.dart';
import 'package:siakad_app/services/auth_service.dart';

class AbsensiPegawai extends StatefulWidget {
  const AbsensiPegawai({Key? key}) : super(key: key);

  @override
  State<AbsensiPegawai> createState() => _AbsensiPegawaiState();
}

class _AbsensiPegawaiState extends State<AbsensiPegawai> {
  final String datenow = DateFormat('dd/M/yyyy').format(DateTime.now());
  final String waktu = DateFormat('KK:mm:ss a').format(DateTime.now());

  File? _imageFile;
  final _picker = ImagePicker();

  Future getImage() async {
    // ignore: deprecated_member_use
    final pickedFile = await _picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  bool loading = true;
  String handle = '';

  getPref() async {
    String cekHandle = await getabsensi();
    setState(() {
      handle = cekHandle;
    });
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

  void fungsiCheckin() async {
    showAlertDialog(context);
    String? image = _imageFile == null ? null : getStringImage(_imageFile);
    await Future.delayed(const Duration(milliseconds: 500));
    ApiResponse response = await checkInEmployee(attendanceimage: image);
    if (response.error == null) {
      setState(() {
        loading = false;
        setPrefCekIn();
        getPref();
        _imageFile = null;
      });
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Absen Masuk Berhasil')));
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const GetStartedScreen()),
                (route) => false)
          });
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  void fungsiCheckOut() async {
    showAlertDialog(context);
    String? image = _imageFile == null ? null : getStringImage(_imageFile);
    await Future.delayed(const Duration(milliseconds: 500));
    ApiResponse response = await checkOutEmployee(attendanceimageOut: image);
    if (response.error == null) {
      setState(() {
        loading = false;
        setPrefCekOut();
        getPref();
        _imageFile = null;
      });
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Absen Keluar Berhasil')));
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const GetStartedScreen()),
                (route) => false)
          });
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  setPrefCekIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('absensi', 'cekin');
  }

  setPrefCekOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('absensi', '');
  }

  @override
  void initState() {
    getPref();
    // fungsiGetStatistik();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Absensi',
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
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: _imageFile == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     SizedBox(
                  //       height: 150,
                  //       width: MediaQuery.of(context).size.width * 0.3,
                  //       child: Image.asset('assets/icons/icon-absensi.png'),
                  //     ),
                  //     const SizedBox(
                  //       width: 20,
                  //     ),
                  //     Container(
                  //       height: 80,
                  //       width: MediaQuery.of(context).size.width * 0.35,
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(8),
                  //         color: Colors.white,
                  //         boxShadow: [
                  //           BoxShadow(
                  //             color: Colors.grey.withOpacity(0.2),
                  //             spreadRadius: 3,
                  //             blurRadius: 5,
                  //             offset: const Offset(
                  //                 0, 5), // changes position of shadow
                  //           ),
                  //         ],
                  //       ),
                  //       child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Text(
                  //             datenow,
                  //             style: const TextStyle(
                  //               fontSize: 14,
                  //               fontWeight: FontWeight.w600,
                  //               letterSpacing: 1,
                  //               fontFamily: 'Poppins',
                  //               color: Color(0xff4B556B),
                  //             ),
                  //           ),
                  //           Text(
                  //             waktu,
                  //             style: const TextStyle(
                  //               fontSize: 14,
                  //               fontWeight: FontWeight.w600,
                  //               letterSpacing: 1,
                  //               fontFamily: 'Poppins',
                  //               color: Color(0xff4B556B),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     )
                  //   ],
                  // ),
                  const SizedBox(
                    height: 15,
                  ),
                  MenuItem(
                    ontapps: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const PreviewFotoAbsen()));
                      getImage();
                    },
                    leftIcon: 'assets/icons/bar-chart.png',
                    rightIcon: 'assets/icons/icon-next.png',
                    title: 'Absensi',
                  ),
                  MenuItem(
                    ontapps: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const IzinCutiPegawai()));
                    },
                    leftIcon: 'assets/icons/bar-chart.png',
                    rightIcon: 'assets/icons/icon-next.png',
                    title: 'Izin/Cuti',
                  ),
                  MenuItem(
                    ontapps: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const IzinTugasDinas()));
                    },
                    leftIcon: 'assets/icons/bar-chart.png',
                    rightIcon: 'assets/icons/icon-next.png',
                    title: 'Tugas Dinas',
                  ),
                  MenuItem(
                    ontapps: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ListAbsensiPegawai()));
                    },
                    leftIcon: 'assets/icons/bar-chart.png',
                    rightIcon: 'assets/icons/icon-next.png',
                    title: 'Riwayat Absensi',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              )
            : Column(
                children: [
                  Center(
                    child: Text(
                      handle == '' ? "Absensi Masuk" : "Absensi Keluar",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xff4B556B),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 320,
                    width: 320,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: FileImage(_imageFile ?? File('')),
                          fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 100,
                        child: Text(
                          'Tanggal',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xff4B556B),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        ': $datenow',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xff4B556B),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 100,
                        child: Text(
                          'Waktu',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xff4B556B),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        ': $waktu',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xff4B556B),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  handle == ''
                      ? GestureDetector(
                          onTap: () {
                            fungsiCheckin();
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
                                "Masuk",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    letterSpacing: 1),
                              )),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            fungsiCheckOut();
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
                                "Keluar",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    letterSpacing: 1),
                              )),
                            ),
                          ),
                        )
                ],
              ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem(
      {Key? key,
      required this.ontapps,
      required this.leftIcon,
      required this.rightIcon,
      required this.title})
      : super(key: key);

  final VoidCallback ontapps;
  final String leftIcon, rightIcon, title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: ontapps,
          child: SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 40,
                  width: 40,
                  child: Image.asset(leftIcon),
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xff4B556B),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(
                  height: 24,
                  width: 40,
                  child: Image.asset(rightIcon),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }
}

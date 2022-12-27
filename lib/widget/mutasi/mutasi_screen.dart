import 'package:flutter/material.dart';
import 'package:siakad_app/widget/mutasi/comp/riwayat_mutasi_kepsek.dart';
import 'package:siakad_app/widget/mutasi/comp/tata_cara.dart';

import 'comp/data_pengajuan_kepsek.dart';
import 'comp/pengajuan_mutasi_siswa.dart';
import 'comp/riwayat_mutasi_siswa.dart';

class MutasiScreen extends StatefulWidget {
  const MutasiScreen({Key? key, required this.role}) : super(key: key);

  final String role;

  @override
  State<MutasiScreen> createState() => _MutasiScreenState();
}

class _MutasiScreenState extends State<MutasiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Mutasi",
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
            child: widget.role == 'student'
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MenuItem(
                        ontapps: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PengajuanMutasiSiswa()));
                        },
                        leftIcon: 'assets/icons/bar-chart.png',
                        rightIcon: 'assets/icons/icon-next.png',
                        title: 'Pengajuan Mutasi',
                      ),
                      MenuItem(
                        ontapps: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RiwayatMutasiSiswa(
                                        role: widget.role,
                                      )));
                        },
                        leftIcon: 'assets/icons/bar-chart.png',
                        rightIcon: 'assets/icons/icon-next.png',
                        title: 'Riwayat Mutasi',
                      ),
                      MenuItem(
                        ontapps: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const TataCara()));
                        },
                        leftIcon: 'assets/icons/bar-chart.png',
                        rightIcon: 'assets/icons/icon-next.png',
                        title: 'Tata Cara Dan Persyaratan Mutasi',
                      ),
                    ],
                  )
                : widget.role == 'walimurid'
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MenuItem(
                            ontapps: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RiwayatMutasiSiswa(
                                            role: widget.role,
                                          )));
                            },
                            leftIcon: 'assets/icons/bar-chart.png',
                            rightIcon: 'assets/icons/icon-next.png',
                            title: 'Riwayat Mutasi',
                          ),
                        ],
                      )
                    : widget.role == 'kepsek'
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MenuItem(
                                ontapps: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const DataPengajuanKepsek()));
                                },
                                leftIcon: 'assets/icons/bar-chart.png',
                                rightIcon: 'assets/icons/icon-next.png',
                                title: 'Data Pengajuan Mutasi',
                              ),
                              MenuItem(
                                ontapps: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RiwayatMutasiKepsek()));
                                },
                                leftIcon: 'assets/icons/bar-chart.png',
                                rightIcon: 'assets/icons/icon-next.png',
                                title: 'Riwayat Mutasi',
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MenuItem(
                                ontapps: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RiwayatMutasiKepsek()));
                                },
                                leftIcon: 'assets/icons/bar-chart.png',
                                rightIcon: 'assets/icons/icon-next.png',
                                title: 'Riwayat Mutasi',
                              ),
                            ],
                          )));
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
          child: Container(
            height: 35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  child: Image.asset(leftIcon),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff4B556B),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
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
          height: 40,
        )
      ],
    );
  }
}

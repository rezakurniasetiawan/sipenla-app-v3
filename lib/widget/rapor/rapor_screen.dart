import 'package:flutter/material.dart';
import 'package:siakad_app/widget/rapor/comp/data_absensi_siswa.dart';

import 'comp/filter_absensi_siswa.dart';
import 'comp/filter_data_nilai_siswa.dart';
import 'comp/filter_data_nilai_siswa_kepsek.dart';
import 'comp/filter_data_nilai_siswa_walkel.dart';
import 'comp/riwayat_kepsek.dart';

class RaporScreen extends StatefulWidget {
  const RaporScreen(
      {Key? key,
      required this.role,
      required this.nameSiswa,
      required this.nisnSIswa})
      : super(key: key);

  final String role, nameSiswa, nisnSIswa;

  @override
  State<RaporScreen> createState() => _RaporScreenState();
}

class _RaporScreenState extends State<RaporScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Rapor",
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
                                builder: (context) => FilterDataNilaiSiswa(
                                      nameSiswa: widget.nameSiswa,
                                      nisnSIswa: widget.nisnSIswa,
                                    )));
                      },
                      leftIcon: 'assets/icons/bar-chart.png',
                      rightIcon: 'assets/icons/icon-next.png',
                      title: 'Data Pembelajaran Siswa',
                    ),
                    MenuItem(
                      ontapps: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FilterAbsensiSiswa(
                                      nameSiswa: widget.nameSiswa,
                                      nisnSIswa: widget.nisnSIswa,
                                    )));
                      },
                      leftIcon: 'assets/icons/bar-chart.png',
                      rightIcon: 'assets/icons/icon-next.png',
                      title: 'Data Absensi Siswa',
                    ),
                  ],
                )
              : widget.role == 'guru'
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MenuItem(
                          ontapps: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const FilterDataNilaiSiswaWalkel(
                                          status: 'data',
                                        )));
                          },
                          leftIcon: 'assets/icons/bar-chart.png',
                          rightIcon: 'assets/icons/icon-next.png',
                          title: 'Data Pembelajaran Siswa',
                        ),
                        MenuItem(
                          ontapps: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const FilterDataNilaiSiswaWalkel(
                                          status: 'riwayat',
                                        )));
                          },
                          leftIcon: 'assets/icons/bar-chart.png',
                          rightIcon: 'assets/icons/icon-next.png',
                          title: 'Riwayat Rapor',
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
                                            const FilterDataNilaiSiswaKepsek()));
                              },
                              leftIcon: 'assets/icons/bar-chart.png',
                              rightIcon: 'assets/icons/icon-next.png',
                              title: 'Data Pembelajaran Siswa',
                            ),
                            MenuItem(
                              ontapps: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RiwayatKepsek()));
                              },
                              leftIcon: 'assets/icons/bar-chart.png',
                              rightIcon: 'assets/icons/icon-next.png',
                              title: 'Riwayat Rapor',
                            ),
                          ],
                        )
                      : const SizedBox()),
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
          child: Container(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 35,
                  width: 35,
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
          height: 40,
        )
      ],
    );
  }
}

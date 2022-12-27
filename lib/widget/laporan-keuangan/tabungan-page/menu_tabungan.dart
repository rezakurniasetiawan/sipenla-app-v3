import 'package:flutter/material.dart';
import 'package:siakad_app/widget/laporan-keuangan/tabungan-page/konfirmasi-pencairan-tab/konfirmasi_pencairan_tabungan.dart';
import 'package:siakad_app/widget/laporan-keuangan/tabungan-page/rekap-riwayat-tabungan/rekap_riwayat_tabungan.dart';
import 'package:siakad_app/widget/laporan-keuangan/tabungan-page/riwayat-konfirmasi-tabungan/riwayat_konfirmasi_tabungan.dart';
import 'package:siakad_app/widget/laporan-keuangan/tabungan-page/riwayat-tabungan/pilih_riwayat_tabungan.dart';
import 'package:siakad_app/widget/laporan-keuangan/tabungan-page/riwayat-tabungan/riwayat_tabungan.dart';

import 'pencairan-tabungan/pencairan_tabungan.dart';
import 'tagihan-tabungan/input_tabungan.dart';
import 'tagihan-tabungan/tagihan_tabungan.dart';

class MenuTabungan extends StatefulWidget {
  const MenuTabungan({Key? key, required this.role}) : super(key: key);

  final String role;

  @override
  State<MenuTabungan> createState() => _MenuTabunganState();
}

class _MenuTabunganState extends State<MenuTabungan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tabungan',
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
        child: widget.role == 'tu'
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MenuItem(
                    ontapps: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InputTabungan()));
                    },
                    leftIcon: 'assets/icons/bar-chart.png',
                    rightIcon: 'assets/icons/icon-next.png',
                    title: 'Tabungan',
                  ),
                  MenuItem(
                    ontapps: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PencairanTabungan()));
                    },
                    leftIcon: 'assets/icons/bar-chart.png',
                    rightIcon: 'assets/icons/icon-next.png',
                    title: 'Pencairan Tabungan',
                  ),
                  MenuItem(
                    ontapps: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PilihRiwayatRabungan()));
                    },
                    leftIcon: 'assets/icons/bar-chart.png',
                    rightIcon: 'assets/icons/icon-next.png',
                    title: 'Riwayat Tabungan',
                  ),
                  MenuItem(
                    ontapps: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  KonfirmasiPencairanTabungan()));
                    },
                    leftIcon: 'assets/icons/bar-chart.png',
                    rightIcon: 'assets/icons/icon-next.png',
                    title: 'Konfirmasi Pencairan',
                  ),
                  MenuItem(
                    ontapps: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  RiwayatKonfirmasiTabungan()));
                    },
                    leftIcon: 'assets/icons/bar-chart.png',
                    rightIcon: 'assets/icons/icon-next.png',
                    title: 'Riwayat Konfirmasi Pencairan',
                  ),
                  // MenuItem(
                  //   ontapps: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => RekapRiwayatTabungan()));
                  //   },
                  //   leftIcon: 'assets/icons/bar-chart.png',
                  //   rightIcon: 'assets/icons/icon-next.png',
                  //   title: 'Rekap Riwayat Tabungan',
                  // ),
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
                                  builder: (context) => InputTabungan()));
                        },
                        leftIcon: 'assets/icons/bar-chart.png',
                        rightIcon: 'assets/icons/icon-next.png',
                        title: 'Tabungan',
                      ),
                      MenuItem(
                        ontapps: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PencairanTabungan()));
                        },
                        leftIcon: 'assets/icons/bar-chart.png',
                        rightIcon: 'assets/icons/icon-next.png',
                        title: 'Pencairan Tabungan',
                      ),
                      MenuItem(
                        ontapps: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PilihRiwayatRabungan()));
                        },
                        leftIcon: 'assets/icons/bar-chart.png',
                        rightIcon: 'assets/icons/icon-next.png',
                        title: 'Riwayat Tabungan',
                      ),
                      // MenuItem(
                      //   ontapps: () {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) =>
                      //                 RekapRiwayatTabungan()));
                      //   },
                      //   leftIcon: 'assets/icons/bar-chart.png',
                      //   rightIcon: 'assets/icons/icon-next.png',
                      //   title: 'Rekap Riwayat Tabungan',
                      // ),
                    ],
                  )
                : widget.role == 'admin'
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MenuItem(
                            ontapps: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InputTabungan()));
                            },
                            leftIcon: 'assets/icons/bar-chart.png',
                            rightIcon: 'assets/icons/icon-next.png',
                            title: 'Tabungan',
                          ),
                          MenuItem(
                            ontapps: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PencairanTabungan()));
                            },
                            leftIcon: 'assets/icons/bar-chart.png',
                            rightIcon: 'assets/icons/icon-next.png',
                            title: 'Pencairan Tabungan',
                          ),
                          MenuItem(
                            ontapps: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PilihRiwayatRabungan()));
                            },
                            leftIcon: 'assets/icons/bar-chart.png',
                            rightIcon: 'assets/icons/icon-next.png',
                            title: 'Riwayat Tabungan',
                          ),
                          // MenuItem(
                          //   ontapps: () {
                          //     Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) =>
                          //                 RekapRiwayatTabungan()));
                          //   },
                          //   leftIcon: 'assets/icons/bar-chart.png',
                          //   rightIcon: 'assets/icons/icon-next.png',
                          //   title: 'Rekap Riwayat Tabungan',
                          // ),
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
                                          builder: (context) =>
                                              PilihRiwayatRabungan()));
                                },
                                leftIcon: 'assets/icons/bar-chart.png',
                                rightIcon: 'assets/icons/icon-next.png',
                                title: 'Riwayat Tabungan',
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
                                              InputTabungan()));
                                },
                                leftIcon: 'assets/icons/bar-chart.png',
                                rightIcon: 'assets/icons/icon-next.png',
                                title: 'Tabungan',
                              ),
                              MenuItem(
                                ontapps: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PencairanTabungan()));
                                },
                                leftIcon: 'assets/icons/bar-chart.png',
                                rightIcon: 'assets/icons/icon-next.png',
                                title: 'Pencairan Tabungan',
                              ),
                              MenuItem(
                                ontapps: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PilihRiwayatRabungan()));
                                },
                                leftIcon: 'assets/icons/bar-chart.png',
                                rightIcon: 'assets/icons/icon-next.png',
                                title: 'Riwayat Tabungan',
                              ),
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
          child: Container(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
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
          height: 40,
        )
      ],
    );
  }
}

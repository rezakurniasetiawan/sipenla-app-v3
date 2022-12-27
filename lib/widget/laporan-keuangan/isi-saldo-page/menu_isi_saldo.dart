import 'package:flutter/material.dart';
import 'package:siakad_app/widget/laporan-keuangan/isi-saldo-page/isi-saldo/isi_saldo.dart';
import 'package:siakad_app/widget/laporan-keuangan/isi-saldo-page/isi-saldo/isi_saldo_koperasi_mitrans.dart';
import 'package:siakad_app/widget/laporan-keuangan/isi-saldo-page/rekap-riwayat-isisaldo/rekap_riwayat_isi_saldo.dart';
import 'package:siakad_app/widget/laporan-keuangan/isi-saldo-page/riwayat-isi-saldo/riwayat_isi_saldo.dart';
import 'package:siakad_app/widget/laporan-keuangan/isi-saldo-page/riwayat-isi-saldo/riwayat_isisaldo_koperasi_mitrans.dart';
import 'package:siakad_app/widget/laporan-keuangan/isi-saldo-page/riwayat-konfirmasi-saldo/riwayat_konfirmasi_saldo_koperasi.dart';

import 'konfirmasi-isi-saldo/konfirmasi_isi_saldo.dart';

class MenuIsiSaldo extends StatefulWidget {
  const MenuIsiSaldo({Key? key, required this.role}) : super(key: key);

  final String role;

  @override
  State<MenuIsiSaldo> createState() => _MenuIsiSaldoState();
}

class _MenuIsiSaldoState extends State<MenuIsiSaldo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Isi Saldo',
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
            child: widget.role == 'tu'
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MenuItem(
                        ontapps: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => IsiSaldo()));
                        },
                        leftIcon: 'assets/icons/bar-chart.png',
                        rightIcon: 'assets/icons/icon-next.png',
                        title: 'Isi Saldo',
                      ),
                      MenuItem(
                        ontapps: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RiwayatIsiSaldo()));
                        },
                        leftIcon: 'assets/icons/bar-chart.png',
                        rightIcon: 'assets/icons/icon-next.png',
                        title: 'Riwayat Isi Saldo',
                      ),
                      // MenuItem(
                      //   ontapps: () {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) =>
                      //                 RekapRiwayatIsiSaldo()));
                      //   },
                      //   leftIcon: 'assets/icons/bar-chart.png',
                      //   rightIcon: 'assets/icons/icon-next.png',
                      //   title: 'Rekap Riwayat Isi Saldo',
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
                                      builder: (context) => IsiSaldo()));
                            },
                            leftIcon: 'assets/icons/bar-chart.png',
                            rightIcon: 'assets/icons/icon-next.png',
                            title: 'Isi Saldo',
                          ),
                          MenuItem(
                            ontapps: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RiwayatIsiSaldo()));
                            },
                            leftIcon: 'assets/icons/bar-chart.png',
                            rightIcon: 'assets/icons/icon-next.png',
                            title: 'Riwayat Isi Saldo',
                          ),
                          // MenuItem(
                          //   ontapps: () {
                          //     Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) =>
                          //                 RekapRiwayatIsiSaldo()));
                          //   },
                          //   leftIcon: 'assets/icons/bar-chart.png',
                          //   rightIcon: 'assets/icons/icon-next.png',
                          //   title: 'Rekap Riwayat Isi Saldo',
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
                                          builder: (context) => IsiSaldo()));
                                },
                                leftIcon: 'assets/icons/bar-chart.png',
                                rightIcon: 'assets/icons/icon-next.png',
                                title: 'Isi Saldo',
                              ),
                              MenuItem(
                                ontapps: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RiwayatIsiSaldo()));
                                },
                                leftIcon: 'assets/icons/bar-chart.png',
                                rightIcon: 'assets/icons/icon-next.png',
                                title: 'Riwayat Isi Saldo',
                              ),
                              // MenuItem(
                              //   ontapps: () {
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) =>
                              //                 RekapRiwayatIsiSaldo()));
                              //   },
                              //   leftIcon: 'assets/icons/bar-chart.png',
                              //   rightIcon: 'assets/icons/icon-next.png',
                              //   title: 'Rekap Riwayat Isi Saldo',
                              // ),
                            ],
                          )
                        : widget.role == 'pegawaikoperasi'
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MenuItem(
                                    ontapps: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  IsiSaldoKoperasiMitrans()));
                                    },
                                    leftIcon: 'assets/icons/bar-chart.png',
                                    rightIcon: 'assets/icons/icon-next.png',
                                    title: 'Isi Saldo',
                                  ),
                                  MenuItem(
                                    ontapps: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RiwayatIsiSaldoKoperasiMitrans()));
                                    },
                                    leftIcon: 'assets/icons/bar-chart.png',
                                    rightIcon: 'assets/icons/icon-next.png',
                                    title: 'Riwayat Isi Saldo',
                                  ),
                                  MenuItem(
                                    ontapps: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  KonfirmasiIsiSaldoKoperasi()));
                                    },
                                    leftIcon: 'assets/icons/bar-chart.png',
                                    rightIcon: 'assets/icons/icon-next.png',
                                    title: 'Konfirmasi Isi Saldo',
                                  ),
                                  MenuItem(
                                    ontapps: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RiwayatKonfrimasiSaldo()));
                                    },
                                    leftIcon: 'assets/icons/bar-chart.png',
                                    rightIcon: 'assets/icons/icon-next.png',
                                    title: 'Riwayat Konfirmasi Isi Saldo',
                                  ),
                                  // MenuItem(
                                  //   ontapps: () {
                                  //     Navigator.push(
                                  //         context,
                                  //         MaterialPageRoute(
                                  //             builder: (context) =>
                                  //                 RekapRiwayatIsiSaldo()));
                                  //   },
                                  //   leftIcon: 'assets/icons/bar-chart.png',
                                  //   rightIcon: 'assets/icons/icon-next.png',
                                  //   title: 'Rekap Riwayat Isi Saldo ',
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
                                                      RiwayatIsiSaldo()));
                                        },
                                        leftIcon: 'assets/icons/bar-chart.png',
                                        rightIcon: 'assets/icons/icon-next.png',
                                        title: 'Riwayat Isi Saldo',
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
                                                      IsiSaldo()));
                                        },
                                        leftIcon: 'assets/icons/bar-chart.png',
                                        rightIcon: 'assets/icons/icon-next.png',
                                        title: 'Isi Saldo',
                                      ),
                                      MenuItem(
                                        ontapps: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RiwayatIsiSaldo()));
                                        },
                                        leftIcon: 'assets/icons/bar-chart.png',
                                        rightIcon: 'assets/icons/icon-next.png',
                                        title: 'Riwayat Isi Saldo',
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

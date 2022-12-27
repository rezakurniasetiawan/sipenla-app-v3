import 'package:flutter/material.dart';
import 'package:siakad_app/widget/laporan-keuangan/tarik-saldo_page/riwayat-konfirmasi-tarik-saldo/riwayat_konfirmasi_tariksaldo.dart';
import 'package:siakad_app/widget/laporan-keuangan/tarik-saldo_page/riwayat-tarik-saldo/riwayat-tarik-saldo.dart';
import 'package:siakad_app/widget/laporan-keuangan/tarik-saldo_page/tarik-saldo/tarik_saldo.dart';

import 'konfirmasi-tarik-saldo/konfirmasi_tarik_saldo.dart';
import 'rekap-riwayat-tariksaldo/rekap_riwayat_tariksaldo.dart';

class MenuTarikSaldo extends StatefulWidget {
  const MenuTarikSaldo({Key? key, required this.role}) : super(key: key);

  final String role;

  @override
  State<MenuTarikSaldo> createState() => _MenuTarikSaldoState();
}

class _MenuTarikSaldoState extends State<MenuTarikSaldo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tarik Saldo',
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
                                builder: (context) => TarikSaldo()));
                      },
                      leftIcon: 'assets/icons/bar-chart.png',
                      rightIcon: 'assets/icons/icon-next.png',
                      title: 'Tarik Saldo',
                    ),
                    MenuItem(
                      ontapps: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RiwayatTarikSaldo()));
                      },
                      leftIcon: 'assets/icons/bar-chart.png',
                      rightIcon: 'assets/icons/icon-next.png',
                      title: 'Riwayat Tarik Saldo',
                    ),
                    MenuItem(
                      ontapps: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => KonfirmasiTarikSaldo()));
                      },
                      leftIcon: 'assets/icons/bar-chart.png',
                      rightIcon: 'assets/icons/icon-next.png',
                      title: 'Konfirmasi Tarik Saldo',
                    ),
                    MenuItem(
                      ontapps: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RiwayatKonfirmasiTarikSaldo()));
                      },
                      leftIcon: 'assets/icons/bar-chart.png',
                      rightIcon: 'assets/icons/icon-next.png',
                      title: 'Riwayat Konfirmasi Tarik Saldo',
                    ),
                    // MenuItem(
                    //   ontapps: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) =>
                    //                 RekapRiwayatTarikSaldo()));
                    //   },
                    //   leftIcon: 'assets/icons/bar-chart.png',
                    //   rightIcon: 'assets/icons/icon-next.png',
                    //   title: 'Rekap Konfirmasi Tarik Saldo',
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
                                    builder: (context) => TarikSaldo()));
                          },
                          leftIcon: 'assets/icons/bar-chart.png',
                          rightIcon: 'assets/icons/icon-next.png',
                          title: 'Tarik Saldo',
                        ),
                        MenuItem(
                          ontapps: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RiwayatTarikSaldo()));
                          },
                          leftIcon: 'assets/icons/bar-chart.png',
                          rightIcon: 'assets/icons/icon-next.png',
                          title: 'Riwayat Tarik Saldo',
                        ),
                        // MenuItem(
                        //   ontapps: () {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) =>
                        //                 RekapRiwayatTarikSaldo()));
                        //   },
                        //   leftIcon: 'assets/icons/bar-chart.png',
                        //   rightIcon: 'assets/icons/icon-next.png',
                        //   title: 'Rekap Konfirmasi Tarik Saldo',
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
                                        builder: (context) => TarikSaldo()));
                              },
                              leftIcon: 'assets/icons/bar-chart.png',
                              rightIcon: 'assets/icons/icon-next.png',
                              title: 'Tarik Saldo',
                            ),
                            MenuItem(
                              ontapps: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RiwayatTarikSaldo()));
                              },
                              leftIcon: 'assets/icons/bar-chart.png',
                              rightIcon: 'assets/icons/icon-next.png',
                              title: 'Riwayat Tarik Saldo',
                            ),
                            // MenuItem(
                            //   ontapps: () {
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) =>
                            //                 RekapRiwayatTarikSaldo()));
                            //   },
                            //   leftIcon: 'assets/icons/bar-chart.png',
                            //   rightIcon: 'assets/icons/icon-next.png',
                            //   title: 'Rekap Konfirmasi Tarik Saldo',
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
                                                RiwayatTarikSaldo()));
                                  },
                                  leftIcon: 'assets/icons/bar-chart.png',
                                  rightIcon: 'assets/icons/icon-next.png',
                                  title: 'Riwayat Tarik Saldo',
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
                                                TarikSaldo()));
                                  },
                                  leftIcon: 'assets/icons/bar-chart.png',
                                  rightIcon: 'assets/icons/icon-next.png',
                                  title: 'Tarik Saldo',
                                ),
                                MenuItem(
                                  ontapps: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RiwayatTarikSaldo()));
                                  },
                                  leftIcon: 'assets/icons/bar-chart.png',
                                  rightIcon: 'assets/icons/icon-next.png',
                                  title: 'Riwayat Tarik Saldo',
                                ),
                              ],
                            )),
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

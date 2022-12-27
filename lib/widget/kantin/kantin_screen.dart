import 'package:flutter/material.dart';
import 'package:siakad_app/widget/kantin/manajemen-kantin/manajemen_kantin.dart';
import 'package:siakad_app/widget/kantin/rekap-riwayat-bayar-kantin/rekap_riwayat_bayar_kantin.dart';

import 'riwayat-bayar-kantin/riwayat_bayar_kantin.dart';

class KantinScreen extends StatefulWidget {
  const KantinScreen({Key? key, required this.role}) : super(key: key);

  final String role;

  @override
  State<KantinScreen> createState() => _KantinScreenState();
}

class _KantinScreenState extends State<KantinScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kantin',
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
        child: widget.role == 'admin'
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MenuItem(
                    ontapps: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ManajemenKantin()));
                    },
                    leftIcon: 'assets/icons/bar-chart.png',
                    rightIcon: 'assets/icons/icon-next.png',
                    title: 'Manajemen Kantin',
                  ),
                  MenuItem(
                    ontapps: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RiwayatBayarKantin()));
                    },
                    leftIcon: 'assets/icons/bar-chart.png',
                    rightIcon: 'assets/icons/icon-next.png',
                    title: 'Riwayat Bayar',
                  ),
                  // MenuItem(
                  //   ontapps: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => RekapRiwayatBayarKantin()));
                  //   },
                  //   leftIcon: 'assets/icons/bar-chart.png',
                  //   rightIcon: 'assets/icons/icon-next.png',
                  //   title: 'Rekap Riwayat Bayar',
                  // ),
                ],
              )
            : widget.role == 'tu'
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MenuItem(
                        ontapps: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RiwayatBayarKantin()));
                        },
                        leftIcon: 'assets/icons/bar-chart.png',
                        rightIcon: 'assets/icons/icon-next.png',
                        title: 'Riwayat Bayar',
                      ),
                      // MenuItem(
                      //   ontapps: () {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) =>
                      //                 RekapRiwayatBayarKantin()));
                      //   },
                      //   leftIcon: 'assets/icons/bar-chart.png',
                      //   rightIcon: 'assets/icons/icon-next.png',
                      //   title: 'Rekap Riwayat Bayar',
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
                                      builder: (context) =>
                                          RiwayatBayarKantin()));
                            },
                            leftIcon: 'assets/icons/bar-chart.png',
                            rightIcon: 'assets/icons/icon-next.png',
                            title: 'Riwayat Bayar',
                          ),
                          // MenuItem(
                          //   ontapps: () {
                          //     Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) =>
                          //                 RekapRiwayatBayarKantin()));
                          //   },
                          //   leftIcon: 'assets/icons/bar-chart.png',
                          //   rightIcon: 'assets/icons/icon-next.png',
                          //   title: 'Rekap Riwayat Bayar',
                          // ),
                        ],
                      )
                    : widget.role == 'pegawaikantin'
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // MenuItem(
                              //   ontapps: () {
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) =>
                              //                 RekapRiwayatBayarKantin()));
                              //   },
                              //   leftIcon: 'assets/icons/bar-chart.png',
                              //   rightIcon: 'assets/icons/icon-next.png',
                              //   title: 'Rekap Riwayat Bayar',
                              // )
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
                                              RiwayatBayarKantin()));
                                },
                                leftIcon: 'assets/icons/bar-chart.png',
                                rightIcon: 'assets/icons/icon-next.png',
                                title: 'Riwayat Bayar',
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

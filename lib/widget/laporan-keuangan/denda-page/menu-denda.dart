import 'package:flutter/material.dart';
import 'package:siakad_app/widget/laporan-keuangan/denda-page/rekap-riwayat-denda/rekap_riwayat_denda.dart';

import 'riwayat-denda/riwayat_denda.dart';

class MenuDenda extends StatefulWidget {
  const MenuDenda({Key? key, required this.role}) : super(key: key);

  final String role;

  @override
  State<MenuDenda> createState() => _MenuDendaState();
}

class _MenuDendaState extends State<MenuDenda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Denda',
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
                              builder: (context) => RiwayatDenda()));
                    },
                    leftIcon: 'assets/icons/bar-chart.png',
                    rightIcon: 'assets/icons/icon-next.png',
                    title: 'Riwayat Denda',
                  ),
                  // MenuItem(
                  //   ontapps: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => RekapRiwayatDenda()));
                  //   },
                  //   leftIcon: 'assets/icons/bar-chart.png',
                  //   rightIcon: 'assets/icons/icon-next.png',
                  //   title: 'Rekap Riwayat Denda',
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
                                  builder: (context) => RiwayatDenda()));
                        },
                        leftIcon: 'assets/icons/bar-chart.png',
                        rightIcon: 'assets/icons/icon-next.png',
                        title: 'Riwayat Denda',
                      ),
                      // MenuItem(
                      //   ontapps: () {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => RekapRiwayatDenda()));
                      //   },
                      //   leftIcon: 'assets/icons/bar-chart.png',
                      //   rightIcon: 'assets/icons/icon-next.png',
                      //   title: 'Rekap Riwayat Denda',
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
                                      builder: (context) => RiwayatDenda()));
                            },
                            leftIcon: 'assets/icons/bar-chart.png',
                            rightIcon: 'assets/icons/icon-next.png',
                            title: 'Riwayat Denda',
                          ),
                          // MenuItem(
                          //   ontapps: () {
                          //     Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) =>
                          //                 RekapRiwayatDenda()));
                          //   },
                          //   leftIcon: 'assets/icons/bar-chart.png',
                          //   rightIcon: 'assets/icons/icon-next.png',
                          //   title: 'Rekap Riwayat Denda',
                          // ),
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
                                      builder: (context) => RiwayatDenda()));
                            },
                            leftIcon: 'assets/icons/bar-chart.png',
                            rightIcon: 'assets/icons/icon-next.png',
                            title: 'Riwayat Denda',
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

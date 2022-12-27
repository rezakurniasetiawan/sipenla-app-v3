import 'package:flutter/material.dart';
import 'package:siakad_app/widget/laporan-keuangan/spp-page/manajemen_spp/manajemen_spp.dart';
import 'package:siakad_app/widget/laporan-keuangan/spp-page/rekap-riwayat-spp/rekap_riwayat_spp.dart';
import 'package:siakad_app/widget/laporan-keuangan/spp-page/riwayat-spp/riwayat_spp.dart';
import 'package:siakad_app/widget/laporan-keuangan/spp-page/tagihan-spp/tagihan_spp.dart';

class MenuSpp extends StatefulWidget {
  const MenuSpp({Key? key, required this.role}) : super(key: key);

  final String role;

  @override
  State<MenuSpp> createState() => _MenuSppState();
}

class _MenuSppState extends State<MenuSpp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SPP',
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
                              builder: (context) => TagihanSpp()));
                    },
                    leftIcon: 'assets/icons/bar-chart.png',
                    rightIcon: 'assets/icons/icon-next.png',
                    title: 'Tagihan SPP',
                  ),
                  MenuItem(
                    ontapps: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RiwayatSpp()));
                    },
                    leftIcon: 'assets/icons/bar-chart.png',
                    rightIcon: 'assets/icons/icon-next.png',
                    title: 'Riwayat SPP',
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
                                  builder: (context) => RiwayatSpp()));
                        },
                        leftIcon: 'assets/icons/bar-chart.png',
                        rightIcon: 'assets/icons/icon-next.png',
                        title: 'Riwayat SPP',
                      ),
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
                                      builder: (context) => ManajemenSpp()));
                            },
                            leftIcon: 'assets/icons/bar-chart.png',
                            rightIcon: 'assets/icons/icon-next.png',
                            title: 'Manajemen SPP',
                          ),
                          // MenuItem(
                          //   ontapps: () {
                          //     Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) => RekapRiwayatSpp()));
                          //   },
                          //   leftIcon: 'assets/icons/bar-chart.png',
                          //   rightIcon: 'assets/icons/icon-next.png',
                          //   title: 'Rekap Riwayat SPP',
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
                                          builder: (context) =>
                                              ManajemenSpp()));
                                },
                                leftIcon: 'assets/icons/bar-chart.png',
                                rightIcon: 'assets/icons/icon-next.png',
                                title: 'Manajemen SPP',
                              ),
                              // MenuItem(
                              //   ontapps: () {
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) =>
                              //                 RekapRiwayatSpp()));
                              //   },
                              //   leftIcon: 'assets/icons/bar-chart.png',
                              //   rightIcon: 'assets/icons/icon-next.png',
                              //   title: 'Rekap Riwayat SPP',
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
                                                  ManajemenSpp()));
                                    },
                                    leftIcon: 'assets/icons/bar-chart.png',
                                    rightIcon: 'assets/icons/icon-next.png',
                                    title: 'Manajemen SPP',
                                  ),
                                  // MenuItem(
                                  //   ontapps: () {
                                  //     Navigator.push(
                                  //         context,
                                  //         MaterialPageRoute(
                                  //             builder: (context) =>
                                  //                 RekapRiwayatSpp()));
                                  //   },
                                  //   leftIcon: 'assets/icons/bar-chart.png',
                                  //   rightIcon: 'assets/icons/icon-next.png',
                                  //   title: 'Rekap Riwayat SPP',
                                  // ),
                                ],
                              )
                            : const SizedBox(),
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

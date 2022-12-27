import 'package:flutter/material.dart';

import '../laporan-keuangan/isi-saldo-page/riwayat-isi-saldo/riwayat_isi_saldo.dart';

class KoperasiScreen extends StatefulWidget {
  const KoperasiScreen({Key? key, required this.role}) : super(key: key);

  final String role;

  @override
  State<KoperasiScreen> createState() => _KoperasiScreenState();
}

class _KoperasiScreenState extends State<KoperasiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Koperasi',
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
      body: widget.role == 'pegawaikoperasi'
          ? Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                  //     // Navigator.push(
                  //     //     context,
                  //     //     MaterialPageRoute(
                  //     //         builder: (context) => RiwayatBayarKantin()));
                  //   },
                  //   leftIcon: 'assets/icons/bar-chart.png',
                  //   rightIcon: 'assets/icons/icon-next.png',
                  //   title: 'Riwayat Rekap Saldo Bayar',
                  // ),
                  // MenuItem(
                  //   ontapps: () {
                  //     // Navigator.push(
                  //     //     context,
                  //     //     MaterialPageRoute(
                  //     //         builder: (context) => RekapRiwayatBayarKantin()));
                  //   },
                  //   leftIcon: 'assets/icons/bar-chart.png',
                  //   rightIcon: 'assets/icons/icon-next.png',
                  //   title: 'Rekap Riwayat Isi Saldo',
                  // ),
                ],
              ),
            )
          : widget.role == 'tu'
              ? Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                      //     // Navigator.push(
                      //     //     context,
                      //     //     MaterialPageRoute(
                      //     //         builder: (context) => RiwayatBayarKantin()));
                      //   },
                      //   leftIcon: 'assets/icons/bar-chart.png',
                      //   rightIcon: 'assets/icons/icon-next.png',
                      //   title: 'Riwayat Bayar',
                      // ),
                      // MenuItem(
                      //   ontapps: () {
                      //     // Navigator.push(
                      //     //     context,
                      //     //     MaterialPageRoute(
                      //     //         builder: (context) => RekapRiwayatBayarKantin()));
                      //   },
                      //   leftIcon: 'assets/icons/bar-chart.png',
                      //   rightIcon: 'assets/icons/icon-next.png',
                      //   title: 'Rekap Saldo Bayar',
                      // ),
                      // MenuItem(
                      //   ontapps: () {
                      //     // Navigator.push(
                      //     //     context,
                      //     //     MaterialPageRoute(
                      //     //         builder: (context) => RekapRiwayatBayarKantin()));
                      //   },
                      //   leftIcon: 'assets/icons/bar-chart.png',
                      //   rightIcon: 'assets/icons/icon-next.png',
                      //   title: 'Rekap Riwayat Isi Saldo',
                      // ),
                    ],
                  ),
                )
              : widget.role == 'admin'
                  ? Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                          //     // Navigator.push(
                          //     //     context,
                          //     //     MaterialPageRoute(
                          //     //         builder: (context) => RiwayatBayarKantin()));
                          //   },
                          //   leftIcon: 'assets/icons/bar-chart.png',
                          //   rightIcon: 'assets/icons/icon-next.png',
                          //   title: 'Riwayat Bayar',
                          // ),
                          // MenuItem(
                          //   ontapps: () {
                          //     // Navigator.push(
                          //     //     context,
                          //     //     MaterialPageRoute(
                          //     //         builder: (context) => RekapRiwayatBayarKantin()));
                          //   },
                          //   leftIcon: 'assets/icons/bar-chart.png',
                          //   rightIcon: 'assets/icons/icon-next.png',
                          //   title: 'Rekap Saldo Bayar',
                          // ),
                          // MenuItem(
                          //   ontapps: () {
                          //     // Navigator.push(
                          //     //     context,
                          //     //     MaterialPageRoute(
                          //     //         builder: (context) => RekapRiwayatBayarKantin()));
                          //   },
                          //   leftIcon: 'assets/icons/bar-chart.png',
                          //   rightIcon: 'assets/icons/icon-next.png',
                          //   title: 'Rekap Riwayat Isi Saldo',
                          // ),
                        ],
                      ),
                    )
                  : widget.role == 'kepsek'
                      ? Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
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
                              // MenuItem(
                              //   ontapps: () {
                              //     // Navigator.push(
                              //     //     context,
                              //     //     MaterialPageRoute(
                              //     //         builder: (context) => RiwayatBayarKantin()));
                              //   },
                              //   leftIcon: 'assets/icons/bar-chart.png',
                              //   rightIcon: 'assets/icons/icon-next.png',
                              //   title: 'Riwayat Bayar',
                              // ),
                              // MenuItem(
                              //   ontapps: () {
                              //     // Navigator.push(
                              //     //     context,
                              //     //     MaterialPageRoute(
                              //     //         builder: (context) => RekapRiwayatBayarKantin()));
                              //   },
                              //   leftIcon: 'assets/icons/bar-chart.png',
                              //   rightIcon: 'assets/icons/icon-next.png',
                              //   title: 'Rekap Saldo Bayar',
                              // ),
                              // MenuItem(
                              //   ontapps: () {
                              //     // Navigator.push(
                              //     //     context,
                              //     //     MaterialPageRoute(
                              //     //         builder: (context) => RekapRiwayatBayarKantin()));
                              //   },
                              //   leftIcon: 'assets/icons/bar-chart.png',
                              //   rightIcon: 'assets/icons/icon-next.png',
                              //   title: 'Rekap Riwayat Isi Saldo',
                              // ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
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
                              // MenuItem(
                              //   ontapps: () {
                              //     // Navigator.push(
                              //     //     context,
                              //     //     MaterialPageRoute(
                              //     //         builder: (context) => RekapRiwayatBayarKantin()));
                              //   },
                              //   leftIcon: 'assets/icons/bar-chart.png',
                              //   rightIcon: 'assets/icons/icon-next.png',
                              //   title: 'Riwayat Bayar',
                              // ),
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

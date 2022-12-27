import 'package:flutter/material.dart';
import 'package:siakad_app/widget/laporan-keuangan/tabungan-page/riwayat-tabungan/riwayat_tabungan.dart';
import 'package:siakad_app/widget/laporan-keuangan/tabungan-page/riwayat-tabungan/riwayat_tarik_tabungan.dart';

class PilihRiwayatRabungan extends StatefulWidget {
  const PilihRiwayatRabungan({Key? key}) : super(key: key);

  @override
  State<PilihRiwayatRabungan> createState() => _PilihRiwayatRabunganState();
}

class _PilihRiwayatRabunganState extends State<PilihRiwayatRabungan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Riwayat Tabungan',
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MenuItem(
              ontapps: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            RiwayatTabungan()));
              },
              leftIcon: 'assets/icons/bar-chart.png',
              rightIcon: 'assets/icons/icon-next.png',
              title: 'Riwayat Isi Tabungan',
            ),
            MenuItem(
              ontapps: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            RiwayatTarikTabungan()));
              },
              leftIcon: 'assets/icons/bar-chart.png',
              rightIcon: 'assets/icons/icon-next.png',
              title: 'Riwayat Tarik Tabungan',
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

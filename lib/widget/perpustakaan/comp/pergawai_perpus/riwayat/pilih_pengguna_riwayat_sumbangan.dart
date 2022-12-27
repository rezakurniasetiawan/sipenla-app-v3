import 'package:flutter/material.dart';
import 'package:siakad_app/widget/perpustakaan/comp/pergawai_perpus/riwayat/riwayat_sumbangan.dart';

class PilihPenggunaRiwayatSumbangBuku extends StatefulWidget {
  const PilihPenggunaRiwayatSumbangBuku({Key? key}) : super(key: key);

  @override
  State<PilihPenggunaRiwayatSumbangBuku> createState() =>
      _PilihPenggunaRiwayatSumbangBukuState();
}

class _PilihPenggunaRiwayatSumbangBukuState
    extends State<PilihPenggunaRiwayatSumbangBuku> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Riwayat Perpustakaan",
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MenuItem(
              ontapps: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RiwayatSumbangan(
                              akses: 'pegawai',
                            )));
              },
              leftIcon: 'assets/icons/bar-chart.png',
              rightIcon: 'assets/icons/icon-next.png',
              title: 'Pegawai',
            ),
            MenuItem(
              ontapps: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RiwayatSumbangan(
                              akses: 'siswa',
                            )));
              },
              leftIcon: 'assets/icons/bar-chart.png',
              rightIcon: 'assets/icons/icon-next.png',
              title: 'Siswa',
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

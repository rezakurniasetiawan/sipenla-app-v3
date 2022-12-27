import 'package:flutter/material.dart';
import 'package:siakad_app/widget/perpustakaan/comp/pergawai_perpus/sumbang/sumbang_buku_pegawai.dart';
import 'package:siakad_app/widget/perpustakaan/comp/pergawai_perpus/sumbang/sumbang_buku_siswa.dart';

class PilihPenggunaSumbangan extends StatefulWidget {
  const PilihPenggunaSumbangan({Key? key}) : super(key: key);

  @override
  State<PilihPenggunaSumbangan> createState() => _PilihPenggunaSumbanganState();
}

class _PilihPenggunaSumbanganState extends State<PilihPenggunaSumbangan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pengembalian Buku",
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
                        builder: (context) => const SumbangBukuPegawai()));
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
                        builder: (context) => const SumbangBukuSiswa()));
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

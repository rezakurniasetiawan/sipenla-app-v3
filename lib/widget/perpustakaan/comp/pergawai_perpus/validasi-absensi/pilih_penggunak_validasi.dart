import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:siakad_app/widget/perpustakaan/comp/pergawai_perpus/validasi-absensi/qr_code_absensi_pegawai.dart';
import 'package:siakad_app/widget/perpustakaan/comp/pergawai_perpus/validasi-absensi/qr_code_absensi_siswa.dart';

class PilihPenggunaValidasi extends StatefulWidget {
  const PilihPenggunaValidasi({Key? key}) : super(key: key);

  @override
  State<PilihPenggunaValidasi> createState() => _PilihPenggunaValidasiState();
}

class _PilihPenggunaValidasiState extends State<PilihPenggunaValidasi> {
  Future scanbarcodeSiswa() async {
    await FlutterBarcodeScanner.scanBarcode(
            "#00BFFF", "KEMBALI", true, ScanMode.DEFAULT)
        .then((String code) {
      // ignore: unnecessary_null_comparison
      if (code == '-1') {
        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (context) => Tabsscreen()),
        //     (route) => false);
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => QrCodeAbsensiSiswa(
                      codeku: code,
                    )));
      }
    });
  }

  Future scanbarcodePegawai() async {
    await FlutterBarcodeScanner.scanBarcode(
            "#00BFFF", "KEMBALI", true, ScanMode.DEFAULT)
        .then((String code) {
      // ignore: unnecessary_null_comparison
      if (code == '-1') {
        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (context) => Tabsscreen()),
        //     (route) => false);
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => QrCodeAbsensiPegawai(
                      codeku: code,
                    )));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Validasi Absensi Perpustakaan",
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
                scanbarcodePegawai();
              },
              leftIcon: 'assets/icons/bar-chart.png',
              rightIcon: 'assets/icons/icon-next.png',
              title: 'Pegawai',
            ),
            MenuItem(
              ontapps: () {
                scanbarcodeSiswa();
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

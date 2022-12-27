import 'package:flutter/material.dart';
import 'package:siakad_app/widget/text_paragraf.dart';

import '../../../../models/laporan_keuangan_models.dart';

class DetailRiwayatIsiSaldo extends StatefulWidget {
  const DetailRiwayatIsiSaldo(
      {Key? key,
      required this.code,
      required this.tanggal,
      required this.waktu,
      required this.saldo,
      required this.status,
      required this.colors})
      : super(key: key);

  final String code, tanggal, waktu, saldo, status;
  final Color colors;

  @override
  State<DetailRiwayatIsiSaldo> createState() => _DetailRiwayatIsiSaldoState();
}

class _DetailRiwayatIsiSaldoState extends State<DetailRiwayatIsiSaldo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detail Riwayat Isi Saldo",
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: Image.asset('assets/icons/isi-saldo.png'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    "Isi Saldo",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff4B556B),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                widget.code,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xff4B556B),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextParagraf(title: 'Tanggal', value: widget.tanggal),
            TextParagraf(title: 'Waktu', value: widget.waktu),
            TextParagraf(title: 'Nominal Isi Saldo', value: widget.saldo),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 130,
                  child: Text(
                    'Status',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      color: Color(0xff4B556B),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                  child: Text(
                    ": ",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                      color: Color(0xff4B556B),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.status,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      color: widget.colors,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

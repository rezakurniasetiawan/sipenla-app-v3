import 'package:flutter/material.dart';

import '../../../../models/laporan_keuangan_models.dart';
import '../../../text_paragraf.dart';
import '../../isi-saldo-page/isi-saldo/isi_saldo.dart';

class DetailKonfirmasiTabungan extends StatefulWidget {
  const DetailKonfirmasiTabungan(
      {Key? key,
      required this.konfirmasiTarikSaldoSiswaModel,
      required this.tanggal})
      : super(key: key);

  final KonfirmasiTarikSaldoSiswaModel konfirmasiTarikSaldoSiswaModel;
  final String tanggal;

  @override
  State<DetailKonfirmasiTabungan> createState() =>
      _DetailKonfirmasiTabunganState();
}

class _DetailKonfirmasiTabunganState extends State<DetailKonfirmasiTabungan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Riwayat',
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
                    child: Image.asset('assets/icons/tabungan2.png'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    "Tabungan",
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
                widget.konfirmasiTarikSaldoSiswaModel.savingCode,
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
            TextParagraf(
                title: 'Nama',
                value: widget.konfirmasiTarikSaldoSiswaModel.firstName +
                    ' ' +
                    widget.konfirmasiTarikSaldoSiswaModel.lastName),
            TextParagraf(title: 'Tanggal', value: widget.tanggal),
            TextParagraf(
                title: 'Waktu',
                value: widget.konfirmasiTarikSaldoSiswaModel.waktu),
            TextParagraf(
              title: 'Nominal Tarik Saldo',
              value: FormatCurrency.convertToIdr(
                  widget.konfirmasiTarikSaldoSiswaModel.amount, 0),
            ),
          ],
        ),
      ),
    );
  }
}

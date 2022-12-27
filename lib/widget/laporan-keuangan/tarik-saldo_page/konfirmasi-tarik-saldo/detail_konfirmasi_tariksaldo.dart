import 'package:flutter/material.dart';

import '../../../../models/laporan_keuangan_models.dart';
import '../../../text_paragraf.dart';
import '../../isi-saldo-page/isi-saldo/isi_saldo.dart';

class DetailKonfirmasiTarikSaldo extends StatefulWidget {
  const DetailKonfirmasiTarikSaldo(
      {Key? key,
      required this.listAprroveTarikSaldoModel,
      required this.tanggal,
      required this.waktu})
      : super(key: key);

  final ListAprroveTarikSaldoModel listAprroveTarikSaldoModel;
  final String tanggal, waktu;

  @override
  State<DetailKonfirmasiTarikSaldo> createState() =>
      _DetailKonfirmasiTarikSaldoState();
}

class _DetailKonfirmasiTarikSaldoState
    extends State<DetailKonfirmasiTarikSaldo> {
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
                    child: Image.asset('assets/icons/tarik-saldo.png'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    "Tarik Saldo",
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
                widget.listAprroveTarikSaldoModel.payoutCode,
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
                value: widget.listAprroveTarikSaldoModel.firstName +
                    ' ' +
                    widget.listAprroveTarikSaldoModel.lastName),
            TextParagraf(title: 'Tanggal', value: widget.tanggal),
            TextParagraf(title: 'Waktu', value: widget.waktu),
            TextParagraf(
              title: 'Nominal Tarik Saldo',
              value: FormatCurrency.convertToIdr(
                  int.parse(
                      widget.listAprroveTarikSaldoModel.payout.toString()),
                  0),
            ),
          ],
        ),
      ),
    );
  }
}

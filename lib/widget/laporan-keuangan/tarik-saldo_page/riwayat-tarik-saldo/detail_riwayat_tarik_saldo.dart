import 'package:flutter/material.dart';

import '../../../../models/laporan_keuangan_models.dart';
import '../../../text_paragraf.dart';
import '../../isi-saldo-page/isi-saldo/isi_saldo.dart';

class DetailRiwayatTarikSaldo extends StatefulWidget {
  const DetailRiwayatTarikSaldo(
      {Key? key,
      required this.historyUserTarikSaldo,
      required this.tanggal,
      required this.waktu,
      required this.colors})
      : super(key: key);

  final HistoryUserTarikSaldo historyUserTarikSaldo;
  final String tanggal, waktu;
  final Color colors;

  @override
  State<DetailRiwayatTarikSaldo> createState() =>
      _DetailRiwayatTarikSaldoState();
}

class _DetailRiwayatTarikSaldoState extends State<DetailRiwayatTarikSaldo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detail Riwayat",
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
                widget.historyUserTarikSaldo.payoutCode,
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
            TextParagraf(
              title: 'Nominal Tarik Saldo',
              value: FormatCurrency.convertToIdr(
                  widget.historyUserTarikSaldo.payout, 0),
            ),
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
                    widget.historyUserTarikSaldo.status == 'pending'
                        ? 'Proses'
                        : widget.historyUserTarikSaldo.status == 'approve'
                            ? 'Terkonfirmasi'
                            : 'Dibatalkan',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                        color: widget.colors),
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

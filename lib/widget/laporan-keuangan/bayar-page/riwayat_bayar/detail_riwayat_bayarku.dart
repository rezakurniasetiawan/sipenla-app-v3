import 'package:flutter/material.dart';

class DetailRiwayatBayarku extends StatefulWidget {
  const DetailRiwayatBayarku({Key? key}) : super(key: key);

  @override
  State<DetailRiwayatBayarku> createState() => _DetailRiwayatBayarkuState();
}

class _DetailRiwayatBayarkuState extends State<DetailRiwayatBayarku> {
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
                    height: 70,
                    child: Image.asset('assets/icons/pembelian.png'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    "Bayar Kantin",
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
                // widget.riwayatDendaUser.fineTransactionCode,
                '146146616465',
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
            // TextParagraf(
            //   title: 'Tanggal',
            //   value: widget.riwayatDendaUser.createdAt.day.toString() +
            //       '-' +
            //       widget.riwayatDendaUser.createdAt.month.toString() +
            //       '-' +
            //       widget.riwayatDendaUser.createdAt.year.toString(),
            // ),
            // TextParagraf(
            //   title: 'Waktu',
            //   value: widget.riwayatDendaUser.waktu,
            // ),
            // TextParagraf(
            //   title: 'Nominal Pembayaran',
            //   value: FormatCurrency.convertToIdr(
            //       widget.riwayatDendaUser.fineTransaction, 0),
            // ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(
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
                SizedBox(
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
                    'Berhasil',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      color: Color(0xff83BC10),
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

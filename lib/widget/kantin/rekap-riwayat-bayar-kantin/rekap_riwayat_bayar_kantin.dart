import 'package:flutter/material.dart';

import '../../gradient_text.dart';
import 'detail_rekap_riwayat_bayar_kantin.dart';

class RekapRiwayatBayarKantin extends StatefulWidget {
  const RekapRiwayatBayarKantin({Key? key}) : super(key: key);

  @override
  State<RekapRiwayatBayarKantin> createState() =>
      _RekapRiwayatBayarKantinState();
}

class _RekapRiwayatBayarKantinState extends State<RekapRiwayatBayarKantin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rekap Saldo Bayar',
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
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/icons/pembelian.png'),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Kantin",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff4B556B),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: const [
                        Text(
                          "Saldo",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff4B556B),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Sipenla",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff3774C3),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 1,
                  color: const Color(0xff4B556B),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: Text(
                    "Total Isi Saldo",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff4B556B),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                const Center(
                  child: GradientText(
                    'Rp 10.000.000',
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                    gradient: LinearGradient(colors: [
                      Color(0xff2E447C),
                      Color(0xff3774C3),
                    ]),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 1,
                  color: const Color(0xff4B556B),
                ),
                const SizedBox(
                  height: 10,
                ),
                const ItemLisRekapRIwayatBayarKantin(),
                const ItemLisRekapRIwayatBayarKantin(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ItemLisRekapRIwayatBayarKantin extends StatelessWidget {
  const ItemLisRekapRIwayatBayarKantin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('assets/icons/isi-saldo.png'),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailRekapRiwayatBayarKantin()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Bulan Januari",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff4B556B),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                        Text(
                          "Saldo Bayar",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff4B556B),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                        Text(
                          "Periode Tanggal 5 Februari",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xff4B556B),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            "Rp 400.000",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff4B556B),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                            ),
                          ),
                          SizedBox(
                            height: 25,
                            child: Image.asset('assets/icons/arrow-right.png'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Container(
            height: 1,
            color: const Color(0xff4B556B),
          ),
        ),
      ],
    );
  }
}

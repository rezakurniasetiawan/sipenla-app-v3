import 'package:flutter/material.dart';
import 'package:siakad_app/widget/laporan-keuangan/tabungan-page/tagihan-tabungan/konfirmasi_pembayaran_tabungan.dart';

class TagihanTabungan extends StatefulWidget {
  const TagihanTabungan({Key? key}) : super(key: key);

  @override
  State<TagihanTabungan> createState() => _TagihanTabunganState();
}

class _TagihanTabunganState extends State<TagihanTabungan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tagihan Tabungan',
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              'Tagihan Saya',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xff4B556B),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: const [
                ItemListTagihanTabungan(),
                ItemListTagihanTabungan(),
                ItemListTagihanTabungan(),
                ItemListTagihanTabungan(),
                ItemListTagihanTabungan(),
                ItemListTagihanTabungan(),
                ItemListTagihanTabungan(),
                ItemListTagihanTabungan(),
                ItemListTagihanTabungan(),
                ItemListTagihanTabungan(),
                ItemListTagihanTabungan(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ItemListTagihanTabungan extends StatelessWidget {
  const ItemListTagihanTabungan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: const Color(0xff4B556B),
                ),
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                    child: Image.asset('assets/icons/tabungan2.png'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             KonfirmasiPembayaranTabungan()));
                    },
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 155,
                              child: Column(
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
                                    "Tabungan",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xff4B556B),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  Text(
                                    "Jatuh Tempo",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff4B556B),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    "5 Februari 2022",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff4B556B),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Row(
                              children: [
                                Column(
                                  children: const [
                                    Text(
                                      "Rp 400.000",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff4B556B),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                    Text(
                                      'Belum Lunas',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Color(0xffFF4238),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 25,
                                  child: Image.asset(
                                      'assets/icons/arrow-right.png'),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        )
      ],
    );
  }
}

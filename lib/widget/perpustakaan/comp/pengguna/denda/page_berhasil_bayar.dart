import 'package:flutter/material.dart';
import 'package:siakad_app/widget/perpustakaan/comp/pengguna/denda/pembayaran_sukses.dart';

import '../../../../../models/perpustakaan/pengguna_perpus_model.dart';
import '../../../../laporan-keuangan/isi-saldo-page/isi-saldo/isi_saldo.dart';

class PageBerhasilBayar extends StatefulWidget {
  const PageBerhasilBayar(
      {Key? key, required this.valueDenda, required this.pemabayaranDendaModel})
      : super(key: key);

  final int valueDenda;
  final PemabayaranDendaModel pemabayaranDendaModel;

  @override
  State<PageBerhasilBayar> createState() => _PageBerhasilBayarState();
}

class _PageBerhasilBayarState extends State<PageBerhasilBayar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Color(0xff4B556B),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 135,
                          child: Image.asset('assets/icons/success-icon.png'),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Pembayaran Sukses!",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff4B556B),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Pembayaran Sebesar",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff4B556B),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          FormatCurrency.convertToIdr(widget.valueDenda, 0),
                          style: const TextStyle(
                            fontSize: 20,
                            color: Color(0xff4B556B),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            const Text(
              "Merchan",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff4B556B),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/icons/denda2.png'),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Denda",
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
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PembayaranSuksesDenda(
                                  pemabayaranDendaModel:
                                      widget.pemabayaranDendaModel,
                                )));
                  },
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: const LinearGradient(
                          begin: FractionalOffset.centerLeft,
                          end: FractionalOffset.centerRight,
                          colors: [
                            Color(0xff2E447C),
                            Color(0xff3774C3),
                          ],
                        ),
                      ),
                      child: const Center(
                          child: Text(
                        "Lihat Detail",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            letterSpacing: 1),
                      )),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

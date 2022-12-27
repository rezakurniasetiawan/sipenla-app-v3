import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../constan.dart';
import '../../../../services/auth_service.dart';
import '../../../text_paragraf.dart';
import 'package:http/http.dart' as http;

import '../../isi-saldo-page/isi-saldo/isi_saldo.dart';

class PembayaranSuksesBayar extends StatefulWidget {
  const PembayaranSuksesBayar({Key? key}) : super(key: key);

  @override
  State<PembayaranSuksesBayar> createState() => _PembayaranSuksesBayarState();
}

class _PembayaranSuksesBayarState extends State<PembayaranSuksesBayar> {
  int balanceku = 0;
  Future getBalance() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(baseURL + '/api/topup/getsaldo'),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      int jsonData = json.decode(response.body)['data']['balance'];
      setState(() {
        balanceku = jsonData;
      });
    }
  }

  bool detail = false;

  @override
  void initState() {
    super.initState();
    getBalance();
  }

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
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
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
                          height: 50,
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
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 1,
                    color: const Color(0xff4B556B),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                              "Bayar",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff4B556B),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "SIPENLA",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff3774C3),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  detail
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              detail = false;
                            });
                          },
                          child: const Text(
                            "Lihat Detail",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff3774C3),
                              decoration: TextDecoration.underline,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            setState(() {
                              detail = true;
                            });
                          },
                          child: const Text(
                            "Lihat Detail",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff3774C3),
                              decoration: TextDecoration.underline,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 30,
                  ),
                  detail
                      ? Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Detail Transaksi",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xff4B556B),
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextParagraf(
                                          title: 'Kode Transaksi',
                                          // value: widget.pemabayaranDendaModel
                                          //     .fineTransactionCode),
                                          value: ''),
                                      const TextParagraf(
                                          title: 'Status', value: 'Berhasil'),
                                      TextParagraf(
                                          title: 'Waktu',
                                          // value: widget
                                          //     .pemabayaranDendaModel.waktu)
                                          value: ''),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Detail Pembayaran",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xff4B556B),
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 150,
                                                child: Row(
                                                  children: const [
                                                    Text(
                                                      "Saldo",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color:
                                                            Color(0xff4B556B),
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        letterSpacing: 1,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "SIPENLA",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color:
                                                            Color(0xff3774C3),
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        letterSpacing: 1,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Text(
                                                " :",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xff4B556B),
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 1,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            FormatCurrency.convertToIdr(
                                                balanceku, 0),
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Color(0xff4B556B),
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 150,
                                                child: Row(
                                                  children: const [
                                                    Text(
                                                      "Total Pembayaran",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color:
                                                            Color(0xff4B556B),
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        letterSpacing: 1,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Text(
                                                " :",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xff4B556B),
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 1,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Text(
                                            // FormatCurrency.convertToIdr(
                                            //     int.parse(widget
                                            //         .pemabayaranDendaModel
                                            //         .fineTransaction),
                                            //     0),
                                            '54151',
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Color(0xff4B556B),
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox()
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Container(
                          child: AlertDialog(
                            actions: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 85,
                                    width: 85,
                                    child: Image.asset(
                                        'assets/icons/warning-icon.png'),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: Text(
                                      'Pengajuan Pengembalian Buku Perpustakaan Sedang Diajukan, Tunggu  Hingga Konfirmasi Selama  30 menit.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Poppins',
                                        color: Color(0xff4B556B),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 130,
                                        height: 44,
                                        decoration: BoxDecoration(
                                            color: const Color(0xff83BC10),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            "Oke",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Poppins',
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    );
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
                        "Oke",
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
      )),
    );
  }
}

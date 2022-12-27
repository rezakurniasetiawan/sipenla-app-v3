import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:siakad_app/widget/laporan-keuangan/isi-saldo-page/isi-saldo/isi_saldo.dart';
import 'package:siakad_app/widget/laporan-keuangan/isi-saldo-page/isi-saldo/pembayaran_isi_saldo_mitrans.dart';

import '../../../../constan.dart';
import '../../../../services/auth_service.dart';
import '../../../gradient_text.dart';
import 'package:http/http.dart' as http;

class KonfirmasiIsiSaldoMitrans extends StatefulWidget {
  const KonfirmasiIsiSaldoMitrans({Key? key, required this.valueSaldo})
      : super(key: key);

  final int valueSaldo;

  @override
  State<KonfirmasiIsiSaldoMitrans> createState() =>
      _KonfirmasiIsiSaldoMitransState();
}

class _KonfirmasiIsiSaldoMitransState extends State<KonfirmasiIsiSaldoMitrans> {
  final List<String> items = [
    'Transfer Bank BCA',
  ];

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(
            color: Colors.blueAccent,
          ),
          Container(
              margin: const EdgeInsets.only(left: 5),
              child: const Text("Loading")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future payment() async {
    showAlertDialog(context);
    String token = await getToken();
    final response =
        await http.post(Uri.parse(baseURL + '/api/payment'), headers: {
      // 'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    }, body: {
      'item_name': 'TOPUP',
      'gross_amount': widget.valueSaldo.toString()
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      String va =
          json.decode(response.body)['data']['va_numbers'][0]['va_number'];
      String orderId = json.decode(response.body)['data']['order_id'];
      setState(() {
        print(va);
        print(orderId);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PembayaranIsiSaldoMitrans(
                      oderId: orderId,
                      vaNumber: va,
                      valuTopup: widget.valueSaldo.toString(),
                    )));
      });
    }
  }

  String? changeBank;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Konfirmasi Pembayaran',
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
            Expanded(
              child: Column(
                children: [
                  const Center(
                    child: Text(
                      'Tagihan Isi Saldo',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff4B556B),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: GradientText(
                      FormatCurrency.convertToIdr(
                          int.parse(widget.valueSaldo.toString()), 0),
                      style: const TextStyle(
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
                    height: 20,
                  ),
                  const Center(
                    child: Text(
                      'Metode Pembayaran',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff4B556B),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 48,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: const Color(0xffF0F1F2),
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          icon: const ImageIcon(
                            AssetImage('assets/icons/arrow-down.png'),
                          ),
                          dropdownColor: const Color(0xffF0F1F2),
                          borderRadius: BorderRadius.circular(15),
                          isExpanded: true,
                          items: items
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Poppins',
                                        color: Color(0xff4B556B),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList(),
                          hint: const Text(
                            'Pilih Metode',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                color: Color(0xff4B556B),
                                letterSpacing: 1),
                            overflow: TextOverflow.ellipsis,
                          ),
                          menuMaxHeight: 300,
                          value: changeBank,
                          onChanged: (value) {
                            setState(() {
                              changeBank = value as String;
                              print(changeBank);
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                if (changeBank == null) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Metode Pembayaran Harus Diisi')));
                } else {
                  payment();
                }
              },
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
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
                      "Bayar",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          letterSpacing: 1),
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

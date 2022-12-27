import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:siakad_app/widget/laporan-keuangan/spp-page/tagihan-spp/pembayaran_spp.dart';

import '../../../gradient_text.dart';
import '../../../../constan.dart';
import '../../../../services/auth_service.dart';
import '../../../gradient_text.dart';
import 'package:http/http.dart' as http;

import '../../isi-saldo-page/isi-saldo/isi_saldo.dart';

class KonfirmasiPembayaranSpp extends StatefulWidget {
  const KonfirmasiPembayaranSpp(
      {Key? key,
      required this.total,
      required this.toDate,
      required this.bulan})
      : super(key: key);

  final String total, toDate, bulan;

  @override
  State<KonfirmasiPembayaranSpp> createState() =>
      _KonfirmasiPembayaranSppState();
}

class _KonfirmasiPembayaranSppState extends State<KonfirmasiPembayaranSpp> {
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
      'item_name': 'SPP',
      'gross_amount': widget.total
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      String va =
          json.decode(response.body)['data']['va_numbers'][0]['va_number'];
      String orderId = json.decode(response.body)['data']['order_id'];
      setState(() {
        print(va);
        print(orderId);
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => PembayaranAdm(
        //             oderId: orderId,
        //             vaNumber: va,
        //             valueTagihan: widget.total)));
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PembayaranSpp(
                      oderId: orderId,
                      vaNumber: va,
                      valueTagihan: widget.total,
                    )));
      });
    }
  }

  String month = "";
  @override
  void initState() {
    super.initState();

    switch (widget.bulan) {
      case '01':
        {
          month = "Januari";
        }
        break;
      case '02':
        {
          month = "Februari";
        }
        break;
      case '03':
        {
          month = "Maret";
        }
        break;
      case '04':
        {
          month = "April";
        }
        break;
      case '05':
        {
          month = "Mei";
        }
        break;
      case '06':
        {
          month = "Juni";
        }
        break;
      case '07':
        {
          month = "Juli";
        }
        break;
      case '08':
        {
          month = "Agustus";
        }
        break;
      case '09':
        {
          month = "September";
        }
        break;
      case '10':
        {
          month = "Oktober";
        }
        break;
      case '11':
        {
          month = "November";
        }
        break;
      case '12':
        {
          month = "Desember";
        }
        break;
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
                      'Tagihan SPP',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff4B556B),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Bulan $month',
                      style: const TextStyle(
                        fontSize: 14,
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
                      FormatCurrency.convertToIdr(int.parse(widget.total), 0),
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
                  Center(
                    child: Text(
                      'Jatuh Tempo ${widget.toDate}',
                      style: const TextStyle(
                        fontSize: 10,
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

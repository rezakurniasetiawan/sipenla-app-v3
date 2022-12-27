import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:siakad_app/widget/perpustakaan/comp/pengguna/denda/page_berhasil_bayar.dart';
import 'package:siakad_app/widget/perpustakaan/comp/pengguna/denda/pembayaran_sukses.dart';
import '../../../../../constan.dart';
import '../../../../../models/api_response_model.dart';
import '../../../../../models/perpustakaan/pengguna_perpus_model.dart';
import '../../../../../screens/started_screen.dart';
import '../../../../../services/auth_service.dart';
import 'package:http/http.dart' as http;

import '../../../../../services/perpustakaan/pengguna_perpus_service.dart';
import '../../../../laporan-keuangan/isi-saldo-page/isi-saldo/isi_saldo.dart';

class PembayaranDendaKehilangan extends StatefulWidget {
  const PembayaranDendaKehilangan(
      {Key? key, required this.valueDenda, required this.idLoan})
      : super(key: key);

  final int valueDenda, idLoan;

  @override
  State<PembayaranDendaKehilangan> createState() =>
      _PembayaranDendaKehilanganState();
}

class _PembayaranDendaKehilanganState extends State<PembayaranDendaKehilangan> {
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

  PemabayaranDendaModel? pemabayaranDendaModel;

  void fungsiPembayaranDenda(String idLoadc) async {
    showAlertDialog(context);
    ApiResponse response = await pembayaranDendaDanKehillangan(
        idLoan: idLoadc,
        status: 'Hilang',
        valueDenda: widget.valueDenda.toString());
    if (response.error == null) {
      Navigator.pop(context);
      setState(() {
        pemabayaranDendaModel = response.data as PemabayaranDendaModel;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PageBerhasilBayar(
                    pemabayaranDendaModel: pemabayaranDendaModel!,
                    valueDenda: widget.valueDenda,
                  )));
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const GetStartedScreen()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
      setState(() {
        Navigator.pop(context);
        Navigator.pop(context);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getBalance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pembayaran Denda",
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
        children: [
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 60,
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          "Nominal Pembayaran",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xff4B556B),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          FormatCurrency.convertToIdr(widget.valueDenda, 0),
                          style: const TextStyle(
                            fontSize: 20,
                            color: Color(0xff4B556B),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
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
                        height: 10,
                      ),
                      const Center(
                        child: Text(
                          "Metode Pembayaran",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xff4B556B),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
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
                            width: 10,
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
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        FormatCurrency.convertToIdr(balanceku, 0),
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color(0xff4B556B),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12), topLeft: Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: const Offset(5, 0), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Total Bayar",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff4B556B),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                  Text(
                    FormatCurrency.convertToIdr(widget.valueDenda, 0),
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xff4B556B),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
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
                                        'Pastikan Saldo Yang Anda Miliki Mencukupi Untuk Melakukan Pembayaran',
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 130,
                                          height: 44,
                                          decoration: BoxDecoration(
                                              color: const Color(0xffFF4238),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                "Batal",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: 'Poppins',
                                                    color: Colors.white),
                                              )),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          width: 130,
                                          height: 44,
                                          decoration: BoxDecoration(
                                              color: const Color(0xff83BC10),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: TextButton(
                                            onPressed: () {
                                              fungsiPembayaranDenda(
                                                widget.idLoan.toString(),
                                              );
                                            },
                                            child: const Text(
                                              "Lanjut",
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
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
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
                        "Lanjutkan",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            letterSpacing: 1),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

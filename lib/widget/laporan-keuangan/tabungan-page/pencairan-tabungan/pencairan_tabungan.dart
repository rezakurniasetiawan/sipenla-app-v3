import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../constan.dart';
import '../../../../models/api_response_model.dart';
import '../../../../screens/started_screen.dart';
import '../../../../services/auth_service.dart';
import 'package:http/http.dart' as http;
import '../../../../services/laporan_keuangan_service.dart';
import '../../../gradient_text.dart';
import '../../isi-saldo-page/isi-saldo/isi_saldo.dart';

class PencairanTabungan extends StatefulWidget {
  const PencairanTabungan({Key? key}) : super(key: key);

  @override
  State<PencairanTabungan> createState() => _PencairanTabunganState();
}

class _PencairanTabunganState extends State<PencairanTabungan> {
  TextEditingController isisaldo = TextEditingController();
  static const _locale = 'en';
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));

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

  bool loading = true;

  void fungsiTarikTabungan({required String inputBalance}) async {
    showAlertDialog(context);
    ApiResponse response = await tarikTabungan(amount: inputBalance);
    if (response.error == null) {
      setState(() {
        loading = false;
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
                        child: Image.asset('assets/icons/warning-icon.png'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          'Pengajuan Tarik Saldo Sedang Diajukan, Tunggu  Hingga Konfirmasi Selama 2 x 24 Jam. Jika Berhasil Silahkan Ambil Saldo Di TU Setelah Proses 1 x 24 Jam',
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
                                borderRadius: BorderRadius.circular(8)),
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Setuju",
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
      });
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
    }
  }

  String balanceku = '';
  Future getBalance() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(baseURL + '/api/saving/getsaldosaving'),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      int jsonData = json.decode(response.body)['data']['total_amount'];
      setState(() {
        balanceku = jsonData.toString();
      });
    }
  }

  String statusTarik = '';
  Future getStatusTarik() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(baseURL + '/api/saving/getstatus'),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      String jsonData = json.decode(response.body)['data'][0]['status_saving'];
      setState(() {
        statusTarik = jsonData;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getBalance();
    getStatusTarik();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pencairan Tabungan",
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
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Center(
                        child: Text(
                          "Saldo Tabungan",
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
                        child: GradientText(
                          balanceku == ''
                              ? 'Rp 0'
                              : FormatCurrency.convertToIdr(
                                  int.parse(balanceku), 0),
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
                        height: 10,
                      ),
                      const Center(
                        child: Text(
                          "Nominal Pencairan Tabungan",
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
                        height: 10,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextField(
                            controller: isisaldo,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.go,
                            onChanged: (string) {
                              setState(() {
                                string =
                                    _formatNumber(string.replaceAll(',', ''));
                                isisaldo.value = TextEditingValue(
                                  text: string,
                                  selection: TextSelection.collapsed(
                                      offset: string.length),
                                );
                              });
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Masukkan Nominal',
                              prefixIcon: SizedBox(
                                width: 20,
                                child: ImageIcon(
                                  AssetImage("assets/icons/Rp.png"),
                                  color: Color(0xff3774C3),
                                ),
                              ),
                            ),
                          ),
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
                    "Total Pencairan Tabungan",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff4B556B),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                  GradientText(
                    isisaldo.text.isEmpty ? 'Rp 0' : 'Rp ${isisaldo.text}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                    gradient: const LinearGradient(colors: [
                      Color(0xff2E447C),
                      Color(0xff3774C3),
                    ]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (isisaldo.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Nominal Harus Di Isi')));
                      } else if (statusTarik == 'Belum Bisa Tarik') {
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Text(
                                          'Belum waktunya untuk tarik tabungan',
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
                                                color: const Color(0xff83BC10),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: TextButton(
                                              onPressed: () {
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
                      } else {
                        int dataku =
                            int.parse(isisaldo.text.replaceAll(',', ''));

                        fungsiTarikTabungan(inputBalance: dataku.toString());
                      }
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

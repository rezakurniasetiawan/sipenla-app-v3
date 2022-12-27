import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../constan.dart';
import '../../../../services/auth_service.dart';
import 'konfirmasi_bayar_pembayaran2.dart';
import 'package:http/http.dart' as http;

class KonfirmasiBayarPembayaran extends StatefulWidget {
  const KonfirmasiBayarPembayaran({Key? key, required this.code})
      : super(key: key);

  final String code;

  @override
  State<KonfirmasiBayarPembayaran> createState() =>
      _KonfirmasiBayarPembayaranState();
}

class _KonfirmasiBayarPembayaranState extends State<KonfirmasiBayarPembayaran> {
  String idEmployee = '';
  String dataku = '';
  bool loading = true;
  Future getQrcode() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(baseURL + '/api/kantin/${widget.code}'),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
    );

    print(response.body);
    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body)['data'];
      String jsonData = json.decode(response.body)['data']['employee_id'];
      print(data);
      setState(() {
        // dataku = data;
        if (data == null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Tidak ditemukan')));
        } else {
          idEmployee = jsonData;
          loading = false;
        }
        // print(jsonData);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getQrcode();
  }

  TextEditingController isisaldo = TextEditingController();
  static const _locale = 'en';
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Konfirmasi Pembayaran",
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
          loading
              ? const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.blueAccent,
                    ),
                  ),
                )
              : Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 60,
                              child: Image.asset('assets/icons/kantin.png'),
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
                                  "Kantin",
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
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            Container(
                              height: 1,
                              color: const Color(0xff4B556B),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Center(
                              child: Text(
                                "Nominal Bayar",
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
                                child: TextFormField(
                                  controller: isisaldo,
                                  textInputAction: TextInputAction.go,
                                  keyboardType: TextInputType.number,
                                  onChanged: (string) {
                                    setState(() {
                                      string = _formatNumber(
                                          string.replaceAll(',', ''));
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
                    ],
                  ),
                ),
          loading
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GestureDetector(
                    onTap: () {
                      if (isisaldo.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Nominal Harus Di Isi')));
                      } else {
                        int dataku =
                            int.parse(isisaldo.text.replaceAll(',', ''));

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    KonfirmasiBayarPembayaran2(
                                      valueBayar: dataku,
                                      employeeId: int.parse(idEmployee),
                                    )));
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
                ),
        ],
      ),
    );
  }
}

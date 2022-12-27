import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:siakad_app/widget/text_paragraf.dart';

import '../../../../constan.dart';
import '../../../../models/api_response_model.dart';
import '../../../../models/laporan_keuangan_models.dart';
import '../../../../screens/started_screen.dart';
import '../../../../services/auth_service.dart';
import '../../../../services/laporan_keuangan_service.dart';

class KonfrimasiisiSaldo2Koperasi extends StatefulWidget {
  const KonfrimasiisiSaldo2Koperasi({
    Key? key,
    required this.name,
    required this.code,
    required this.tanggal,
    required this.waktu,
    required this.balance,
  }) : super(key: key);

  final String name, code, tanggal, waktu, balance;

  @override
  State<KonfrimasiisiSaldo2Koperasi> createState() =>
      _KonfrimasiisiSaldo2KoperasiState();
}

class _KonfrimasiisiSaldo2KoperasiState
    extends State<KonfrimasiisiSaldo2Koperasi> {
  final formatter = NumberFormat.simpleCurrency(locale: 'id_ID');
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

  void fungsiAprroveBalance() async {
    showAlertDialog(context);
    ApiResponse response = await aprroveBalance(code: widget.code);
    if (response.error == null) {
      Navigator.pop(context, 'refresh');
      print(response.data);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Berhasil Konfirmasi Isi Saldo')));
      Navigator.pop(context);
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const GetStartedScreen()),
                (route) => false)
          });
    } else {
      setState(() {
        Navigator.pop(context);
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Konfirmasi Isi Saldo',
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
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: const Color(0xff4B556B),
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          TextParagraf(title: 'Nama', value: widget.name),
                          TextParagraf(
                              title: 'Kode Transaksi', value: widget.code),
                          TextParagraf(title: 'Tanggal', value: widget.tanggal),
                          TextParagraf(title: 'Waktu', value: widget.waktu),
                          TextParagraf(
                            title: 'Nominal Isi Saldo',
                            value: formatter.format(
                              int.parse(widget.balance),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                fungsiAprroveBalance();
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
                      "Konfirmasi",
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
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:siakad_app/widget/laporan-keuangan/isi-saldo-page/konfirmasi-isi-saldo/konfirmasi_isi_saldo2.dart';

import '../../../../constan.dart';
import '../../../../models/api_response_model.dart';
import '../../../../models/laporan_keuangan_models.dart';
import '../../../../screens/started_screen.dart';
import '../../../../services/auth_service.dart';
import '../../../../services/laporan_keuangan_service.dart';

class KonfirmasiIsiSaldoKoperasi extends StatefulWidget {
  const KonfirmasiIsiSaldoKoperasi({Key? key}) : super(key: key);

  @override
  State<KonfirmasiIsiSaldoKoperasi> createState() =>
      _KonfirmasiIsiSaldoKoperasiState();
}

class _KonfirmasiIsiSaldoKoperasiState
    extends State<KonfirmasiIsiSaldoKoperasi> {
  TextEditingController code = TextEditingController();
  CheckCodeForAprroveModel? checkCodeForAprroveModel;
  bool loading = true;

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

  void fungsicheckCode() async {
    showAlertDialog(context);
    ApiResponse response = await getCheckCodeForAprroveModel(code: code.text);
    print(response.data);
    if (response.error == null) {
      setState(() {
        checkCodeForAprroveModel = response.data as CheckCodeForAprroveModel;
        String waktu =
            DateFormat('KK:mm:ss').format(checkCodeForAprroveModel!.createdAt);
        String tanggal = DateFormat('dd-MM-yyyy')
            .format(checkCodeForAprroveModel!.createdAt);

        loading = false;
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => KonfrimasiisiSaldo2Koperasi(
                      balance: checkCodeForAprroveModel!.balance.toString(),
                      code: checkCodeForAprroveModel!.balanceCode,
                      name: checkCodeForAprroveModel!.firstName +
                          ' ' +
                          checkCodeForAprroveModel!.lastName,
                      tanggal: tanggal,
                      waktu: waktu,
                    )));
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const GetStartedScreen()),
                (route) => false)
          });
    } else {
      if (response.error == 'Invalid Token') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Kode Tidak Ditemukan')));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${response.error}')));
      }
    }
  }

  @override
  void initState() {
    super.initState();
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Masukkan Kode Pembayaran Isi Saldo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xff4B556B),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: const Color(0xff3774C3),
                  ),
                  borderRadius: BorderRadius.circular(12)),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 28,
                      color: Color(0xff3578C7),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                    controller: code,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Masukkan Kode',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Wajib Di isi';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              // const Center(
              //   child:
              //   Text(
              //     'J3ZH4RUN',
              //     style: TextStyle(
              //       fontSize: 28,
              //       color: Color(0xff3578C7),
              //       fontFamily: 'Poppins',
              //       fontWeight: FontWeight.w600,
              //       letterSpacing: 1,
              //     ),
              //   ),
              // ),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => KonfrimasiisiSaldo2Koperasi()));
                fungsicheckCode();
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
                      "Cari",
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

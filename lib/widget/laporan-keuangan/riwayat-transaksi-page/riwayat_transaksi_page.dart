import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constan.dart';
import '../../../models/api_response_model.dart';
import '../../../models/laporan_keuangan_models.dart';
import '../../../screens/started_screen.dart';
import '../../../services/auth_service.dart';
import '../../../services/laporan_keuangan_service.dart';
import '../../gradient_text.dart';
import '../isi-saldo-page/isi-saldo/isi_saldo.dart';

class RiwayatTransaksiPage extends StatefulWidget {
  const RiwayatTransaksiPage({Key? key}) : super(key: key);

  @override
  State<RiwayatTransaksiPage> createState() => _RiwayatTransaksiPageState();
}

class _RiwayatTransaksiPageState extends State<RiwayatTransaksiPage> {
  bool _loading = true;
  List<dynamic> riwyattransaksiList = [];
  Future<void> fungsigetRiwayatTransaksibyUser() async {
    ApiResponse response = await getRiwayatTransaksibyUser();
    if (response.error == null) {
      setState(() {
        riwyattransaksiList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const GetStartedScreen()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    fungsigetRiwayatTransaksibyUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Laporan Keuangan",
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
      body: ListView.builder(
        itemCount: riwyattransaksiList.length,
        itemBuilder: (BuildContext context, int index) {
          RiwayatTransaksibyUserModel riwayatTransaksibyUserModel =
              riwyattransaksiList[index];
          String tanggal = DateFormat('dd-MM-yyyy')
              .format(riwayatTransaksibyUserModel.createdAt);
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 40,
                      child: Image.asset(riwayatTransaksibyUserModel.itemName ==
                              'SPP'
                          ? 'assets/icons/spp2.png'
                          : riwayatTransaksibyUserModel.itemName == 'TABUNGAN'
                              ? 'assets/icons/tabungan2.png'
                              : 'assets/icons/adm-lain2.png'),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pembayaran ${riwayatTransaksibyUserModel.itemName}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xff4B556B),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ),
                          ),
                          Text(
                            tanggal,
                            style: const TextStyle(
                              fontSize: 14,
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
                      width: 30,
                    ),
                    Column(
                      children: [
                        GradientText(
                          FormatCurrency.convertToIdr(
                              riwayatTransaksibyUserModel.grossAmount, 0),
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                          ),
                          gradient: const LinearGradient(colors: [
                            Color(0xff2E447C),
                            Color(0xff3774C3),
                          ]),
                        ),
                        const Text(
                          "Berhasil",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff83BC10),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

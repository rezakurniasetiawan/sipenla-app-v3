import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:siakad_app/widget/laporan-keuangan/bayar-page/riwayat_bayar/detail_riwayat_bayarku.dart';

import '../../../../constan.dart';
import '../../../../models/api_response_model.dart';
import '../../../../models/kantin_model.dart';
import '../../../../screens/started_screen.dart';
import '../../../../services/auth_service.dart';
import '../../../../services/kantin_services.dart';
import '../../isi-saldo-page/isi-saldo/isi_saldo.dart';

class RiwayatBayarku extends StatefulWidget {
  const RiwayatBayarku({Key? key}) : super(key: key);

  @override
  State<RiwayatBayarku> createState() => _RiwayatBayarkuState();
}

class _RiwayatBayarkuState extends State<RiwayatBayarku> {
  TextEditingController tanggal = TextEditingController();
  final String datenow = DateFormat('yyyyMMdd').format(DateTime.now());
  bool _loading = true;
  List<dynamic> merchantList = [];

  Future<void> fungsiGetMerchant() async {
    ApiResponse response = await getHistoryBayarKantin();
    if (response.error == null) {
      setState(() {
        merchantList = response.data as List<dynamic>;
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
    tanggal.text = datenow;
    fungsiGetMerchant();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Riwayat',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            // Expanded(
            //   child: ListView.builder(
            //       itemCount: riwayatIsiSaldoList.length,
            //       itemBuilder: (BuildContext context, int index) {
            //         RiwayatDendaUser riwayatDendaUser =
            //             riwayatIsiSaldoList[index];

            //       }),
            // )
            Expanded(
              child: ListView.builder(
                  itemCount: merchantList.length,
                  itemBuilder: (BuildContext context, int index) {
                    RiwayatBayarKantinModel riwayatBayarKantinModel =
                        merchantList[index];
                    return ItemRiwayatBayarku(
                      code: riwayatBayarKantinModel.codeTransaction,
                      date: riwayatBayarKantinModel.date.toIso8601String(),
                      // ontaps: () {
                      //   // Navigator.push(
                      //   //     context,
                      //   //     MaterialPageRoute(
                      //   //         builder: (context) =>
                      //   //             DetailRiwayatBayarKantin()));
                      // },
                      valuedenda: FormatCurrency.convertToIdr(
                          riwayatBayarKantinModel.price, 0),
                    );
                  }),
            )
            // ItemRiwayatBayarku(
            //     code: '51651651',
            //     date: 's212121',
            //     ontaps: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => DetailRiwayatBayarku()));
            //     },
            //     valuedenda: '00000'
            //     // FormatCurrency.convertToIdr(
            //     //     riwayatDendaUser.fineTransaction, 0),
            //     )
          ],
        ),
      ),
    );
  }
}

class ItemRiwayatBayarku extends StatelessWidget {
  const ItemRiwayatBayarku({
    Key? key,
    // required this.ontaps,
    required this.code,
    required this.date,
    required this.valuedenda,
  }) : super(key: key);

  // final VoidCallback ontaps;
  final String code, date, valuedenda;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('assets/icons/kantin.png'),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 190,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Bayar Kantin",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff4B556B),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ),
                          ),
                          Text(
                            code,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xff4B556B),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ),
                          ),
                          Text(
                            date,
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
                    Column(
                      children: [
                        Text(
                          "- $valuedenda",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xffFF6E66),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                          ),
                        ),
                        const Text(
                          'Berhasil',
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
                  height: 10,
                ),
                // GestureDetector(
                //   onTap: ontaps,
                //   child: Container(
                //     width: 96,
                //     height: 27,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(12),
                //       gradient: const LinearGradient(
                //         begin: FractionalOffset.centerLeft,
                //         end: FractionalOffset.centerRight,
                //         colors: [
                //           Color(0xff2E447C),
                //           Color(0xff3774C3),
                //         ],
                //       ),
                //     ),
                //     child: const Center(
                //         child: Text(
                //       "Detail",
                //       style: TextStyle(
                //           fontSize: 10,
                //           fontWeight: FontWeight.bold,
                //           fontFamily: 'Poppins',
                //           color: Colors.white,
                //           letterSpacing: 1),
                //     )),
                //   ),
                // ),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Container(
            height: 1,
            color: const Color(0xff4B556B),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../constan.dart';
import '../../../../models/api_response_model.dart';
import '../../../../models/laporan_keuangan_models.dart';
import '../../../../screens/started_screen.dart';
import '../../../../services/auth_service.dart';
import '../../../../services/laporan_keuangan_service.dart';
import '../../isi-saldo-page/isi-saldo/isi_saldo.dart';
import 'detail_riwayat_tarik_saldo.dart';

class RiwayatTarikSaldo extends StatefulWidget {
  const RiwayatTarikSaldo({Key? key}) : super(key: key);

  @override
  State<RiwayatTarikSaldo> createState() => _RiwayatTarikSaldoState();
}

class _RiwayatTarikSaldoState extends State<RiwayatTarikSaldo> {
  TextEditingController tanggal = TextEditingController();
  final String datenow = DateFormat('yyyyMMdd').format(DateTime.now());

  bool _loading = true;
  List<dynamic> riwayatIsiSaldoList = [];

  Future<void> fungsigetHistoryTarikSaldoUser() async {
    ApiResponse response =
        await getHistoryTarikSaldoUser(tanggal: tanggal.text);
    if (response.error == null) {
      setState(() {
        riwayatIsiSaldoList = response.data as List<dynamic>;
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
    fungsigetHistoryTarikSaldoUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Riwayat Tarik Saldo",
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
            const Text(
              "Tanggal",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
                color: Color(0xff4B556B),
              ),
            ),
            InkWell(
              onTap: () async {
                DateTime? pickedDate2 = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101));

                if (pickedDate2 != null) {
                  String formattedDate2 =
                      DateFormat('yyyyMMdd').format(pickedDate2);
                  print(formattedDate2);

                  setState(() {
                    tanggal.text = formattedDate2;
                  });
                } else {
                  print("Date is not selected");
                }
              },
              child: Container(
                height: 48,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color(0xffF0F1F2),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tanggal.text == '' ? 'yyyy-mm-dd' : tanggal.text,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                        child: ImageIcon(
                          AssetImage('assets/icons/calendar_month.png'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                fungsigetHistoryTarikSaldoUser();
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
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: riwayatIsiSaldoList.length,
                itemBuilder: (BuildContext context, int index) {
                  HistoryUserTarikSaldo historyUserTarikSaldo =
                      riwayatIsiSaldoList[index];
                  String tanggal = DateFormat('dd-MM-yyyy')
                      .format(historyUserTarikSaldo.createdAt);
                  String waktu = DateFormat('hh:ss')
                      .format(historyUserTarikSaldo.createdAt);
                  return ItemListRiwayatSaldo(
                    colorStatus: historyUserTarikSaldo.status == 'pending'
                        ? const Color(0xffFFB711)
                        : historyUserTarikSaldo.status == 'approve'
                            ? const Color(0xff83BC10)
                            : const Color(0xffFF4238),
                    titleStatus: historyUserTarikSaldo.status == 'pending'
                        ? 'Proses'
                        : historyUserTarikSaldo.status == 'approve'
                            ? 'Berhasil'
                            : 'Dibatalkan',
                    code: historyUserTarikSaldo.payoutCode,
                    tanggal: tanggal,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailRiwayatTarikSaldo(
                            historyUserTarikSaldo: historyUserTarikSaldo,
                            tanggal: tanggal,
                            waktu: waktu,
                            colors: historyUserTarikSaldo.status == 'pending'
                                ? const Color(0xffFFB711)
                                : historyUserTarikSaldo.status == 'approve'
                                    ? const Color(0xff83BC10)
                                    : const Color(0xffFF4238),
                          ),
                        ),
                      );
                    },
                    balance: FormatCurrency.convertToIdr(
                        historyUserTarikSaldo.payout, 0),
                  );
                },
              ),
            )
            // const ItemListRiwayatSaldo(
            //   colorStatus: Color(0xffFFB711),
            //   titleStatus: 'Proses',
            // ),
            // const ItemListRiwayatSaldo(
            //   colorStatus: Color(0xffFF4238),
            //   titleStatus: 'Dibatalkan',
            // ),
            // const ItemListRiwayatSaldo(
            //   colorStatus: Color(0xff83BC10),
            //   titleStatus: 'Berhasil',
            // ),
          ],
        ),
      ),
    );
  }
}

class ItemListRiwayatSaldo extends StatelessWidget {
  const ItemListRiwayatSaldo({
    Key? key,
    required this.colorStatus,
    required this.titleStatus,
    required this.code,
    required this.tanggal,
    required this.press,
    required this.balance,
  }) : super(key: key);

  final Color colorStatus;
  final String titleStatus, code, tanggal, balance;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              child: Image.asset('assets/icons/tarik-saldo.png'),
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
                            "Tarik Saldo",
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
                    Column(
                      children: [
                        Text(
                          "- $balance",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xffFF4238),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                          ),
                        ),
                        Text(
                          titleStatus,
                          style: TextStyle(
                            fontSize: 14,
                            color: colorStatus,
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
                GestureDetector(
                  onTap: press,
                  child: Container(
                    width: 96,
                    height: 27,
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
                      "Detail",
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          letterSpacing: 1),
                    )),
                  ),
                ),
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

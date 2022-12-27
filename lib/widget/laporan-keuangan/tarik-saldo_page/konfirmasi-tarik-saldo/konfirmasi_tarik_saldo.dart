import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../constan.dart';
import '../../../../models/api_response_model.dart';
import '../../../../models/laporan_keuangan_models.dart';
import '../../../../screens/started_screen.dart';
import '../../../../services/auth_service.dart';
import '../../../../services/laporan_keuangan_service.dart';
import '../../isi-saldo-page/isi-saldo/isi_saldo.dart';
import 'detail_konfirmasi_tariksaldo.dart';

class KonfirmasiTarikSaldo extends StatefulWidget {
  const KonfirmasiTarikSaldo({Key? key}) : super(key: key);

  @override
  State<KonfirmasiTarikSaldo> createState() => KonfirmasiTarikSaldoState();
}

class KonfirmasiTarikSaldoState extends State<KonfirmasiTarikSaldo> {
  final List<String> items = [
    'Siswa',
    'Pegawai',
  ];

  String? pilihRole;

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

  bool _loading = true;
  List<dynamic> aprroveTarikSaldoList = [];

  Future<void> fungsigetHistoryMain() async {
    ApiResponse response = await getKonfirmasiTarikSaldoSiswa();
    if (response.error == null) {
      setState(() {
        aprroveTarikSaldoList = response.data as List<dynamic>;
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

  Future<void> fungsigetKonfirmasiTarikSaldoSiswa() async {
    ApiResponse response = await getKonfirmasiTarikSaldoSiswa();
    if (response.error == null) {
      setState(() {
        aprroveTarikSaldoList = response.data as List<dynamic>;
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

  Future<void> fungsigetKonfirmasiTarikSaldoPegawai() async {
    ApiResponse response = await getKonfirmasiTarikSaldoPegawai();
    if (response.error == null) {
      setState(() {
        aprroveTarikSaldoList = response.data as List<dynamic>;
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

  void fungsiAprroveBalance({required String codeku}) async {
    showAlertDialog(context);
    ApiResponse response = await aprroveTarikSaldo(code: codeku);
    if (response.error == null) {
      Navigator.pop(context, 'refresh');
      print(response.data);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Berhasil Konfirmasi Tarik Saldo Saldo')));
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
  void initState() {
    super.initState();
    pilihRole = 'Siswa';
    fungsigetHistoryMain();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Konfirmasi Tarik Saldo',
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
              "Hak Akses",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
                color: Color(0xff4B556B),
              ),
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
                                  color: Color(0xff4B556B),
                                  letterSpacing: 1,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    hint: const Text(
                      'Pilih Hak Akses',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    menuMaxHeight: 300,
                    value: pilihRole,
                    onChanged: (value) {
                      setState(() {
                        pilihRole = value as String;
                        if (pilihRole == 'Siswa') {
                          fungsigetKonfirmasiTarikSaldoSiswa();
                        } else {
                          fungsigetKonfirmasiTarikSaldoPegawai();
                        }
                        print(pilihRole);
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: aprroveTarikSaldoList.length,
                  itemBuilder: (BuildContext context, int index) {
                    ListAprroveTarikSaldoModel listAprroveTarikSaldoModel =
                        aprroveTarikSaldoList[index];
                    String tanggalku = DateFormat('dd-MM-yyyy')
                        .format(listAprroveTarikSaldoModel.createdAt);
                    String waktu = DateFormat('h:i')
                        .format(listAprroveTarikSaldoModel.createdAt);

                    return ItemListKonfirmasiTarikSaldo(
                      colorStatus: const Color(0xff83BC10),
                      balance: FormatCurrency.convertToIdr(
                          int.parse(
                              listAprroveTarikSaldoModel.payout.toString()),
                          0),
                      code: listAprroveTarikSaldoModel.payoutCode,
                      tanggal: tanggalku,
                      ontaps: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailKonfirmasiTarikSaldo(
                              listAprroveTarikSaldoModel:
                                  listAprroveTarikSaldoModel,
                              tanggal: tanggalku,
                              waktu: waktu,
                            ),
                          ),
                        );
                      },
                      konfir: () {
                        fungsiAprroveBalance(
                            codeku: listAprroveTarikSaldoModel.payoutCode);
                      },
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class ItemListKonfirmasiTarikSaldo extends StatelessWidget {
  const ItemListKonfirmasiTarikSaldo({
    Key? key,
    required this.colorStatus,
    required this.code,
    required this.tanggal,
    required this.balance,
    required this.ontaps,
    required this.konfir,
  }) : super(key: key);

  final Color colorStatus;
  final String code, tanggal, balance;
  final VoidCallback ontaps, konfir;

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
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: ontaps,
                      child: Container(
                        width: 96,
                        height: 27,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xff2E447C),
                          ),
                        ),
                        child: const Center(
                            child: Text(
                          "Detail",
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                              color: Color(0xff2E447C),
                              letterSpacing: 1),
                        )),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: konfir,
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
                          "Konfirmasi",
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
                )
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

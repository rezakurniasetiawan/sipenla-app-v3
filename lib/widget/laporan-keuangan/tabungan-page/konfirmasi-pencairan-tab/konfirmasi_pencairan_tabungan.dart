import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:siakad_app/widget/laporan-keuangan/tabungan-page/konfirmasi-pencairan-tab/detail_konfirmasi_tabungan.dart';

import '../../../../constan.dart';
import '../../../../models/api_response_model.dart';
import '../../../../models/laporan_keuangan_models.dart';
import '../../../../screens/started_screen.dart';
import '../../../../services/auth_service.dart';
import '../../../../services/laporan_keuangan_service.dart';
import '../../isi-saldo-page/isi-saldo/isi_saldo.dart';
import 'package:http/http.dart' as http;

class KonfirmasiPencairanTabungan extends StatefulWidget {
  const KonfirmasiPencairanTabungan({Key? key}) : super(key: key);

  @override
  State<KonfirmasiPencairanTabungan> createState() =>
      _KonfirmasiPencairanTabunganState();
}

class _KonfirmasiPencairanTabunganState
    extends State<KonfirmasiPencairanTabungan> {
  final List<String> items = [
    'Siswa',
    'Pegawai',
  ];
  final List<String> itemsPengaturan = [
    'Belum Bisa Tarik',
    'Bisa Tarik',
  ];

  String? pilihPengaturan;

  String? pilihRole;
  bool _loading = true;
  List<dynamic> aprroveTarikSaldoSiswaList = [];

  Future<void> fungsigetApproveTarikTabunganSiswa() async {
    ApiResponse response = await getApproveTarikTabunganSiswa();
    if (response.error == null) {
      setState(() {
        aprroveTarikSaldoSiswaList = response.data as List<dynamic>;
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

  Future<void> fungsigetApproveTarikTabunganPegawai() async {
    ApiResponse response = await getApproveTarikTabunganPegawai();
    if (response.error == null) {
      setState(() {
        aprroveTarikSaldoSiswaList = response.data as List<dynamic>;
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

  void fungsiApproveTarikTabungan(String code) async {
    showAlertDialog(context);
    ApiResponse response = await approveTarikSaldo(code: code);
    if (response.error == null) {
      Navigator.pop(context);
      setState(() {
        if (pilihRole == 'Siswa') {
          fungsigetApproveTarikTabunganSiswa();
        } else {
          fungsigetApproveTarikTabunganPegawai();
        }
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Berhasil Konfirmsi Pencairan')));
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const GetStartedScreen()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Ada Kesalahan')));
    }
  }

  int idstatusTarik = 0;
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
      int idStatus = json.decode(response.body)['data'][0]['id'];
      setState(() {
        idstatusTarik = idStatus;
        pilihPengaturan = jsonData;
      });
    }
  }

  void fungsiUpdateStatusTarik() async {
    showAlertDialog(context);
    ApiResponse response = await updateStatusTarikService(
        statusTarik: idstatusTarik, status: pilihPengaturan.toString());
    if (response.error == null) {
      Navigator.pop(context);
      setState(() {
        getStatusTarik();
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Berhasil Mengubah Status Tarik Tabungan')));
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const GetStartedScreen()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Ada Kesalahan')));
    }
  }

  @override
  void initState() {
    super.initState();
    pilihRole == 'Siswa';
    fungsigetApproveTarikTabunganSiswa();
    getStatusTarik();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Konfirmasi Pencairan',
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Pengaturan Pencairan",
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
                          items: itemsPengaturan
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
                          // hint: const Text(
                          //   'Pilih Hak Akses',
                          //   style: TextStyle(
                          //     fontSize: 14,
                          //     color: Colors.black87,
                          //   ),
                          //   overflow: TextOverflow.ellipsis,
                          // ),
                          menuMaxHeight: 300,
                          value: pilihPengaturan,
                          onChanged: (value) {
                            setState(() {
                              pilihPengaturan = value as String;
                              fungsiUpdateStatusTarik();
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
                            fungsigetApproveTarikTabunganSiswa();
                          } else {
                            fungsigetApproveTarikTabunganPegawai();
                          }
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
                    itemCount: aprroveTarikSaldoSiswaList.length,
                    itemBuilder: (BuildContext context, int index) {
                      KonfirmasiTarikSaldoSiswaModel
                          konfirmasiTarikSaldoSiswaModel =
                          aprroveTarikSaldoSiswaList[index];
                      String tanggal = DateFormat('dd-MM-yyyy')
                          .format(konfirmasiTarikSaldoSiswaModel.createdAt);
                      return ItemListKonfirmasiTabungan(
                        colorStatus: Color(0xff83BC10),
                        amount: FormatCurrency.convertToIdr(
                            konfirmasiTarikSaldoSiswaModel.amount, 0),
                        code: konfirmasiTarikSaldoSiswaModel.savingCode,
                        press: () {
                          fungsiApproveTarikTabungan(
                              konfirmasiTarikSaldoSiswaModel.savingCode);
                        },
                        tanggal: tanggal,
                        press2: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailKonfirmasiTabungan(
                                konfirmasiTarikSaldoSiswaModel:
                                    konfirmasiTarikSaldoSiswaModel,
                                tanggal: tanggal,
                              ),
                            ),
                          );
                        },
                      );
                    }),
              ),
            ],
          )),
    );
  }
}

class ItemListKonfirmasiTabungan extends StatelessWidget {
  const ItemListKonfirmasiTabungan({
    Key? key,
    required this.colorStatus,
    required this.amount,
    required this.code,
    required this.tanggal,
    required this.press,
    required this.press2,
  }) : super(key: key);

  final Color colorStatus;
  final String amount, code, tanggal;
  final VoidCallback press, press2;

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
                            "Tabungan",
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
                      "- $amount",
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
                      onTap: press2,
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

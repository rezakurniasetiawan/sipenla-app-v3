import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../constan.dart';
import '../../../../models/api_response_model.dart';
import '../../../../models/laporan_keuangan_models.dart';
import '../../../../screens/started_screen.dart';
import '../../../../services/auth_service.dart';
import '../../../../services/laporan_keuangan_service.dart';
import '../../../text_paragraf.dart';
import '../../isi-saldo-page/isi-saldo/isi_saldo.dart';

class RiwayatKonfirmasiTarikSaldo extends StatefulWidget {
  const RiwayatKonfirmasiTarikSaldo({Key? key}) : super(key: key);

  @override
  State<RiwayatKonfirmasiTarikSaldo> createState() =>
      _RiwayatKonfirmasiTarikSaldoState();
}

class _RiwayatKonfirmasiTarikSaldoState
    extends State<RiwayatKonfirmasiTarikSaldo> {
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
    ApiResponse response =
        await getRiwayatKonfirmasiTarikSaldoSiswa(tanggal: tanggal.text);
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
    ApiResponse response =
        await getRiwayatKonfirmasiTarikSaldoSiswa(tanggal: tanggal.text);
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
    ApiResponse response =
        await getRiwayatKonfirmasiTarikSaldoPegawai(tanggal: tanggal.text);
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

  TextEditingController tanggal = TextEditingController();
  final String datenow = DateFormat('yyyyMMdd').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    tanggal.text = datenow;
    pilihRole = 'Siswa';
    fungsigetHistoryMain();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Riwayat Konfirmasi',
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
                if (pilihRole == 'Siswa') {
                  fungsigetKonfirmasiTarikSaldoSiswa();
                } else {
                  fungsigetKonfirmasiTarikSaldoPegawai();
                }
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
                  itemCount: aprroveTarikSaldoList.length,
                  itemBuilder: (BuildContext context, int index) {
                    ListAprroveTarikSaldoModel listAprroveTarikSaldoModel =
                        aprroveTarikSaldoList[index];
                    String tanggalku = DateFormat('dd-MM-yyyy')
                        .format(listAprroveTarikSaldoModel.createdAt);
                    String waktu = DateFormat('h:i')
                        .format(listAprroveTarikSaldoModel.createdAt);

                    return Column(
                      children: [
                        TextParagraf(
                            title: 'Nama',
                            value: listAprroveTarikSaldoModel.firstName +
                                ' ' +
                                listAprroveTarikSaldoModel.lastName),
                        TextParagraf(
                            title: 'Kode Transaksi',
                            value: listAprroveTarikSaldoModel.payoutCode),
                        TextParagraf(title: 'Tanggal', value: tanggalku),
                        TextParagraf(title: 'Waktu', value: waktu),
                        TextParagraf(
                          title: 'Nominal Tarik Saldo',
                          value: FormatCurrency.convertToIdr(
                              int.parse(
                                  listAprroveTarikSaldoModel.payout.toString()),
                              0),
                        ),
                        Container(
                          height: 1,
                          color: const Color(0xff4B556B),
                        ),
                      ],
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

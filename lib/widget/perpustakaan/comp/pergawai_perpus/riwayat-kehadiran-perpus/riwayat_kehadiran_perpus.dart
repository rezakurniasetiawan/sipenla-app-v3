import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:siakad_app/widget/text_paragraf.dart';

import '../../../../../constan.dart';
import '../../../../../models/api_response_model.dart';
import '../../../../../models/perpustakaan/pegawai_perpus_model.dart';
import '../../../../../screens/started_screen.dart';
import '../../../../../services/auth_service.dart';
import '../../../../../services/perpustakaan/pegawai_perpus_services.dart';

class RiwayatKehadiranPerpus extends StatefulWidget {
  const RiwayatKehadiranPerpus({Key? key}) : super(key: key);

  @override
  State<RiwayatKehadiranPerpus> createState() => _RiwayatKehadiranPerpusState();
}

class _RiwayatKehadiranPerpusState extends State<RiwayatKehadiranPerpus> {
  TextEditingController tanggal = TextEditingController();
  final String datenow = DateFormat('yyyyMMdd').format(DateTime.now());

  final List<String> items = [
    'Siswa',
    'Pegawai',
  ];

  String? pilihRole;

  bool _loading = true;
  List<dynamic> riwayatApproveIsiSaldoList = [];

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

  Future<void> fungsigetHistoryMain() async {
    ApiResponse response =
        await getHistoryAbsensiPerpusSiswa(tanggal: tanggal.text);
    if (response.error == null) {
      setState(() {
        riwayatApproveIsiSaldoList = response.data as List<dynamic>;
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

  String? data;

  Future<void> fungsigetHistorySiswa() async {
    setState(() {
      data = 'Siswa';
      riwayatApproveIsiSaldoList.clear();
    });
    ApiResponse response =
        await getHistoryAbsensiPerpusSiswa(tanggal: tanggal.text);
    if (response.error == null) {
      setState(() {
        riwayatApproveIsiSaldoList = response.data as List<dynamic>;
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

  Future<void> fungsigetHistoryPegawai() async {
    setState(() {
      data = 'Pegawai';
      riwayatApproveIsiSaldoList.clear();
    });
    ApiResponse response =
        await getHistoryAbsensiPerpusPegawai(tanggal: tanggal.text);
    if (response.error == null) {
      setState(() {
        riwayatApproveIsiSaldoList = response.data as List<dynamic>;
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
    pilihRole = 'Siswa';
    data = 'Siswa';
    fungsigetHistoryMain();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Riwayat Absensi',
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
                  fungsigetHistorySiswa();
                } else {
                  fungsigetHistoryPegawai();
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
            const Text(
              "Riwayat",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
                color: Color(0xff4B556B),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            data == 'Siswa'
                ? Expanded(
                    child: ListView.builder(
                      itemCount: riwayatApproveIsiSaldoList.length,
                      itemBuilder: (BuildContext context, int index) {
                        RiwayatAbsensiPerpusSiswaModel
                            riwayatAbsensiPerpusSiswaModel =
                            riwayatApproveIsiSaldoList[index];
                        return Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        riwayatAbsensiPerpusSiswaModel.image,
                                    fit: BoxFit.cover,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      width: 70.0,
                                      height: 70116.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(35),
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    placeholder: (context, url) => Shimmer(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(35),
                                          ),
                                        ),
                                        gradient: const LinearGradient(stops: [
                                          0.2,
                                          0.5,
                                          0.6
                                        ], colors: [
                                          Colors.grey,
                                          Colors.white12,
                                          Colors.grey,
                                        ])),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      TextParagraf(
                                          title: 'Nama',
                                          value: riwayatAbsensiPerpusSiswaModel
                                                  .firstName +
                                              ' ' +
                                              riwayatAbsensiPerpusSiswaModel
                                                  .lastName),
                                      TextParagraf(
                                          title: 'NISN',
                                          value: riwayatAbsensiPerpusSiswaModel
                                              .nisn),
                                      const TextParagraf(
                                          title: 'Jabatan', value: 'Siswa'),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        );
                      },
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: riwayatApproveIsiSaldoList.length,
                      itemBuilder: (BuildContext context, int index) {
                        RiwayatAbsensiPerpusPegawaiModel
                            riwayatAbsensiPerpusPegawaiModel =
                            riwayatApproveIsiSaldoList[index];
                        return Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        riwayatAbsensiPerpusPegawaiModel.image,
                                    fit: BoxFit.cover,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      width: 70.0,
                                      height: 70116.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(35),
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    placeholder: (context, url) => Shimmer(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(35),
                                          ),
                                        ),
                                        gradient: const LinearGradient(stops: [
                                          0.2,
                                          0.5,
                                          0.6
                                        ], colors: [
                                          Colors.grey,
                                          Colors.white12,
                                          Colors.grey,
                                        ])),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      TextParagraf(
                                          title: 'Nama',
                                          value: riwayatAbsensiPerpusPegawaiModel
                                                  .firstName +
                                              ' ' +
                                              riwayatAbsensiPerpusPegawaiModel
                                                  .lastName),
                                      TextParagraf(
                                          title: 'NISN',
                                          value:
                                              riwayatAbsensiPerpusPegawaiModel
                                                  .nuptk),
                                      const TextParagraf(
                                          title: 'Jabatan', value: 'Pegawai'),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/penilaian_model.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:siakad_app/services/penilaian_service.dart';

import '../../../constan.dart';

class RiwayatPenilaianSiswa extends StatefulWidget {
  const RiwayatPenilaianSiswa(
      {Key? key,
      required this.idAkademik,
      required this.idKelas,
      required this.idSemester})
      : super(key: key);

  final String idAkademik, idSemester, idKelas;

  @override
  State<RiwayatPenilaianSiswa> createState() => _RiwayatPenilaianSiswaState();
}

class _RiwayatPenilaianSiswaState extends State<RiwayatPenilaianSiswa> {
  RiwayatNilaiSiswaModel? riwayatNilaiSiswaModel;
  var valueMapel;
  List mapelList = [];

  bool loading = true;

  Future getMapel() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(baseURL + '/api/assessment/getsubject'),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body)['data'];
      setState(() {
        mapelList = jsonData;
      });
    }
  }

  fungsiGetRiwayatNilaiSiswa() async {
    ApiResponse response = await getRiwayatNilaiSiswa(
        idAkademik: int.parse(widget.idAkademik),
        idKelas: int.parse(widget.idKelas),
        idMapel: int.parse(valueMapel),
        idSemester: int.parse(widget.idSemester));
    if (response.error == null) {
      setState(() {
        riwayatNilaiSiswaModel = response.data as RiwayatNilaiSiswaModel;
        loading = false;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const GetStartedScreen()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  @override
  void initState() {
    super.initState();
    getMapel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Riwayat Pembelajaran",
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const Center(
              child: Text(
                "Kelas 7A",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff4B556B),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
            ),
            const Center(
              child: Text(
                "Semester Ganjil",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xff4B556B),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 48,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color(0xffF0F1F2),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    icon: const ImageIcon(
                      AssetImage('assets/icons/arrow-down.png'),
                    ),
                    dropdownColor: const Color(0xffF0F1F2),
                    borderRadius: BorderRadius.circular(15),
                    hint: const Text('Mata Pelajaran'),
                    items: mapelList.map((item) {
                      return DropdownMenuItem(
                        value: item['subject_id'].toString(),
                        child: Text(item['subject_name'].toString()),
                      );
                    }).toList(),
                    onChanged: (newVal) {
                      setState(() {
                        valueMapel = newVal;
                        fungsiGetRiwayatNilaiSiswa();
                      });
                    },
                    value: valueMapel,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            loading
                ? const SizedBox(
                    height: 200,
                    child: Center(
                      child: Text('Pilih Mata Pelajaran'),
                    ),
                  )
                : riwayatNilaiSiswaModel!.nilaiUas == 0
                    ? const SizedBox(
                        height: 200,
                        child: Center(
                          child: Text('Nilai belum keluar'),
                        ),
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xff4B556B),
                            ),
                            borderRadius: BorderRadius.circular(14)),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              ItemRiwayatPenilaian(
                                  title: 'Mata Pelajaran',
                                  value: riwayatNilaiSiswaModel!.mapel),
                              ItemRiwayatPenilaian(
                                  title: 'Tugas 1',
                                  value: riwayatNilaiSiswaModel!.nilaiTugas1
                                      .toString()),
                              ItemRiwayatPenilaian(
                                  title: 'Tugas 2',
                                  value: riwayatNilaiSiswaModel!.nilaiTugas2
                                      .toString()),
                              ItemRiwayatPenilaian(
                                  title: 'Tugas 3',
                                  value: riwayatNilaiSiswaModel!.nilaiTugas3
                                      .toString()),
                              ItemRiwayatPenilaian(
                                  title: 'Tugas 4',
                                  value: riwayatNilaiSiswaModel!.nilaiTugas4
                                      .toString()),
                              ItemRiwayatPenilaian(
                                  title: 'UH 1',
                                  value: riwayatNilaiSiswaModel!.nilaiUh1
                                      .toString()),
                              ItemRiwayatPenilaian(
                                  title: 'UH 2',
                                  value: riwayatNilaiSiswaModel!.nilaiUh2
                                      .toString()),
                              ItemRiwayatPenilaian(
                                  title: 'UH 3',
                                  value: riwayatNilaiSiswaModel!.nilaiUh3
                                      .toString()),
                              ItemRiwayatPenilaian(
                                  title: 'UH 4',
                                  value: riwayatNilaiSiswaModel!.nilaiUh4
                                      .toString()),
                              ItemRiwayatPenilaian(
                                  title: 'UTS',
                                  value: riwayatNilaiSiswaModel!.nilaiUts
                                      .toString()),
                              ItemRiwayatPenilaian(
                                  title: 'UAS',
                                  value: riwayatNilaiSiswaModel!.nilaiUas
                                      .toString()),
                              ItemRiwayatPenilaian(
                                  title: 'Guru Mata Pelajaran',
                                  value: riwayatNilaiSiswaModel!.firstName +
                                      ' ' +
                                      riwayatNilaiSiswaModel!.lastName),
                            ],
                          ),
                        ),
                      )
          ],
        ),
      ),
    );
  }
}

class ItemRiwayatPenilaian extends StatefulWidget {
  const ItemRiwayatPenilaian(
      {Key? key, required this.title, required this.value})
      : super(key: key);

  final String title, value;

  @override
  State<ItemRiwayatPenilaian> createState() => _ItemRiwayatPenilaianState();
}

class _ItemRiwayatPenilaianState extends State<ItemRiwayatPenilaian> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 130,
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  color: Color(0xff2E447C),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
              child: Text(
                ": ",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                  color: Color(0xff2E447C),
                ),
              ),
            ),
            Expanded(
              child: Text(
                widget.value,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                  color: Color(0xff2E447C),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}

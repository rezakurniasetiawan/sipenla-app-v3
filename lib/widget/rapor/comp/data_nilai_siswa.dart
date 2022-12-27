import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:siakad_app/models/rapor_model.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:siakad_app/services/fasilitas_service.dart';
import 'package:siakad_app/services/rapor_service.dart';

import '../../../constan.dart';
import '../../text_paragraf.dart';

class DataNilaiSiswa extends StatefulWidget {
  const DataNilaiSiswa(
      {Key? key,
      required this.idAkademik,
      required this.idKelas,
      required this.idSemester,
      required this.nameSiswa,
      required this.nisnSIswa})
      : super(key: key);

  final String idAkademik, idSemester, idKelas, nameSiswa, nisnSIswa;

  @override
  State<DataNilaiSiswa> createState() => _DataNilaiSiswaState();
}

class _DataNilaiSiswaState extends State<DataNilaiSiswa> {
  bool _loading = true;
  List<dynamic> _NilaiRaporSiswa = [];
  List<dynamic> _NilaiEkstraSiswa = [];

  String semester = '';
  String kelas = '';
  String akademik = '';

  Future<void> fungsiGetNilaiRaporSiswa() async {
    ApiResponse response = await getNilaiRaporSiswa(
        idAkademik: int.parse(widget.idAkademik),
        idGrade: int.parse(widget.idKelas),
        idSemester: int.parse(widget.idSemester));
    if (response.error == null) {
      setState(() {
        _NilaiRaporSiswa = response.data as List<dynamic>;
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

  Future<void> fungsiGetNilaiEkstraSiswa() async {
    ApiResponse response = await getNilaiEkstraSiswa(
        idAkademik: int.parse(widget.idAkademik),
        idGrade: int.parse(widget.idKelas),
        idSemester: int.parse(widget.idSemester));
    if (response.error == null) {
      setState(() {
        _NilaiEkstraSiswa = response.data as List<dynamic>;
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

  Future getSemester() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(baseURL + '/api/assessment/getsemester/' + widget.idSemester),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body)['data']['semester_name'];
      setState(() {
        semester = jsonData;
      });
    }
  }

  Future getKelas() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(baseURL + '/api/monitoring/getday/' + widget.idKelas),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body)['data']['grade_name'];
      setState(() {
        kelas = jsonData;
      });
    }
  }

  Future getRahunAkademik() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(baseURL + '/api/rapor/getacademic/' + widget.idAkademik),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body)['data']['academic_year'];
      setState(() {
        akademik = jsonData;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fungsiGetNilaiRaporSiswa();
    fungsiGetNilaiEkstraSiswa();
    getKelas();
    getSemester();
    getRahunAkademik();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Data Pembelajaran Siswa",
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
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 25,
                    child: Image.asset('assets/image/logo-sipenla.png'),
                  ),
                  SizedBox(
                    height: 25,
                    child: Image.asset('assets/image/kemendikbud.png'),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const TextParagraf(
                title: 'Nama Sekolah',
                value: 'SIPENLA',
              ),
              TextParagraf(
                title: 'Nama Siswa',
                value: widget.nameSiswa,
              ),
              TextParagraf(
                title: 'NISN',
                value: widget.nisnSIswa,
              ),
              TextParagraf(title: 'Kelas', value: kelas),
              TextParagraf(title: 'Semester', value: semester),
              TextParagraf(title: 'Tahun Pelajaran', value: akademik),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  "Capaian Hasil Belajar",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff4B556B),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "A. Pengetahuan dan keterampilan",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff4B556B),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xff4B556B),
                          ),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20))),
                      height: 60,
                      child: const Center(
                        child: Text(
                          'Mataa Pelajaran',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins',
                            color: Color(0xff4B556B),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          border: Border(
                        top: BorderSide(
                          width: 1.0,
                          color: Color(0xff4B556B),
                        ),
                        bottom: BorderSide(
                          width: 1.0,
                          color: Color(0xff4B556B),
                        ),
                      )),
                      height: 60,
                      child: const Center(
                        child: Text(
                          'Nilai',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins',
                            color: Color(0xff4B556B),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xff4B556B),
                          ),
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(20))),
                      height: 60,
                      child: const Center(
                        child: Text(
                          'Predikat',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins',
                            color: Color(0xff4B556B),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _NilaiRaporSiswa.length,
                itemBuilder: (BuildContext context, int index) {
                  NilaiRaporSiswa nilaiRaporSiswa = _NilaiRaporSiswa[index];
                  int footer = _NilaiRaporSiswa.length - 1;
                  int footer2 = _NilaiRaporSiswa.length - 2;
                  int fixNilaku = nilaiRaporSiswa.nilaiFix.ceil();
                  return Row(
                    children: [
                      footer == index
                          ? Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: (index % 2 == 1)
                                      ? Colors.white
                                      : const Color(0xffF0F1F2),
                                  border: Border.all(
                                    color: const Color(0xff4B556B),
                                  ),
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(20)),
                                ),
                                height: 60,
                                child: Center(
                                  child: Text(
                                    nilaiRaporSiswa.subjectName,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Poppins',
                                      color: Color(0xff4B556B),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : footer2 == index
                              ? Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: (index % 2 == 1)
                                          ? Colors.white
                                          : const Color(0xffF0F1F2),
                                      border: const Border(
                                        right: BorderSide(
                                          width: 1.0,
                                          color: Color(0xff4B556B),
                                        ),
                                        left: BorderSide(
                                          width: 1.0,
                                          color: Color(0xff4B556B),
                                        ),
                                      ),
                                    ),
                                    height: 60,
                                    child: Center(
                                      child: Text(
                                        nilaiRaporSiswa.subjectName,
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins',
                                          color: Color(0xff4B556B),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: (index % 2 == 1)
                                          ? Colors.white
                                          : const Color(0xffF0F1F2),
                                      border: const Border(
                                        right: BorderSide(
                                          width: 1.0,
                                          color: Color(0xff4B556B),
                                        ),
                                        left: BorderSide(
                                          width: 1.0,
                                          color: Color(0xff4B556B),
                                        ),
                                        bottom: BorderSide(
                                          width: 1.0,
                                          color: Color(0xff4B556B),
                                        ),
                                      ),
                                    ),
                                    height: 60,
                                    child: Center(
                                      child: Text(
                                        nilaiRaporSiswa.subjectName,
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins',
                                          color: Color(0xff4B556B),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                      //Nilai
                      footer2 == index
                          ? Expanded(
                              child: Container(
                                color: (index % 2 == 1)
                                    ? Colors.white
                                    : const Color(0xffF0F1F2),
                                height: 60,
                                child: Center(
                                  child: Text(
                                    fixNilaku.toString(),
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Poppins',
                                      color: Color(0xff4B556B),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : footer == index
                              ? Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: (index % 2 == 1)
                                          ? Colors.white
                                          : const Color(0xffF0F1F2),
                                      border: const Border(
                                        bottom: BorderSide(
                                          width: 1.0,
                                          color: Color(0xff4B556B),
                                        ),
                                        top: BorderSide(
                                          width: 1.0,
                                          color: Color(0xff4B556B),
                                        ),
                                      ),
                                    ),
                                    height: 60,
                                    child: Center(
                                      child: Text(
                                        fixNilaku.toString(),
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins',
                                          color: Color(0xff4B556B),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: (index % 2 == 1)
                                          ? Colors.white
                                          : const Color(0xffF0F1F2),
                                      border: const Border(
                                        bottom: BorderSide(
                                          width: 1.0,
                                          color: Color(0xff4B556B),
                                        ),
                                      ),
                                    ),
                                    height: 60,
                                    child: Center(
                                      child: Text(
                                        fixNilaku.toString(),
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins',
                                          color: Color(0xff4B556B),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                      //Predikat
                      footer == index
                          ? Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: (index % 2 == 1)
                                      ? Colors.white
                                      : const Color(0xffF0F1F2),
                                  border: Border.all(
                                    color: const Color(0xff4B556B),
                                  ),
                                  borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(20)),
                                ),
                                height: 60,
                                //Footer
                                child: Center(
                                  child: Text(
                                    fixNilaku > 90
                                        ? 'A'
                                        : fixNilaku > 83
                                            ? 'B'
                                            : fixNilaku > 75
                                                ? 'C'
                                                : fixNilaku > 68
                                                    ? 'D'
                                                    : 'E',
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Poppins',
                                      color: Color(0xff4B556B),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : footer2 == index
                              ? Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: (index % 2 == 1)
                                          ? Colors.white
                                          : const Color(0xffF0F1F2),
                                      border: const Border(
                                        right: BorderSide(
                                          width: 1.0,
                                          color: Color(0xff4B556B),
                                        ),
                                        left: BorderSide(
                                          width: 1.0,
                                          color: Color(0xff4B556B),
                                        ),
                                      ),
                                    ),
                                    height: 60,
                                    //Sebelum Footer
                                    child: Center(
                                      child: Text(
                                        fixNilaku > 90
                                            ? 'A'
                                            : fixNilaku > 83
                                                ? 'B'
                                                : fixNilaku > 75
                                                    ? 'C'
                                                    : fixNilaku > 68
                                                        ? 'D'
                                                        : 'E',
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins',
                                          color: Color(0xff4B556B),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: (index % 2 == 1)
                                          ? Colors.white
                                          : const Color(0xffF0F1F2),
                                      border: const Border(
                                        right: BorderSide(
                                          width: 1.0,
                                          color: Color(0xff4B556B),
                                        ),
                                        left: BorderSide(
                                          width: 1.0,
                                          color: Color(0xff4B556B),
                                        ),
                                        bottom: BorderSide(
                                          width: 1.0,
                                          color: Color(0xff4B556B),
                                        ),
                                      ),
                                    ),
                                    height: 60,
                                    //Normaly
                                    child: Center(
                                      child: Text(
                                        fixNilaku > 90
                                            ? 'A'
                                            : fixNilaku > 83
                                                ? 'B'
                                                : fixNilaku > 75
                                                    ? 'C'
                                                    : fixNilaku > 68
                                                        ? 'D'
                                                        : 'E',
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins',
                                          color: Color(0xff4B556B),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "B. Ekstrakurikuler",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff4B556B),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xff4B556B),
                          ),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20))),
                      height: 60,
                      child: const Center(
                        child: Text(
                          'Ekstrakurikuler',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins',
                            color: Color(0xff4B556B),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          border: Border(
                        top: BorderSide(
                          width: 1.0,
                          color: Color(0xff4B556B),
                        ),
                        bottom: BorderSide(
                          width: 1.0,
                          color: Color(0xff4B556B),
                        ),
                      )),
                      height: 60,
                      child: const Center(
                        child: Text(
                          'Nilai',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins',
                            color: Color(0xff4B556B),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xff4B556B),
                          ),
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(20))),
                      height: 60,
                      child: const Center(
                        child: Text(
                          'Predikat',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins',
                            color: Color(0xff4B556B),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _NilaiEkstraSiswa.length,
                itemBuilder: (BuildContext context, int index) {
                  NilaiEkstraSiswa nilaiEkstraSiswa = _NilaiEkstraSiswa[index];
                  int footer = _NilaiEkstraSiswa.length - 1;
                  int footer2 = _NilaiEkstraSiswa.length - 2;
                  return Row(
                    children: [
                      footer == index
                          ? Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: (index % 2 == 1)
                                      ? Colors.white
                                      : const Color(0xffF0F1F2),
                                  border: Border.all(
                                    color: const Color(0xff4B556B),
                                  ),
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(20)),
                                ),
                                height: 60,
                                child: Center(
                                  child: Text(
                                    nilaiEkstraSiswa.extracurricularName,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Poppins',
                                      color: Color(0xff4B556B),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : footer2 == index
                              ? Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: (index % 2 == 1)
                                          ? Colors.white
                                          : const Color(0xffF0F1F2),
                                      border: const Border(
                                        right: BorderSide(
                                          width: 1.0,
                                          color: Color(0xff4B556B),
                                        ),
                                        left: BorderSide(
                                          width: 1.0,
                                          color: Color(0xff4B556B),
                                        ),
                                      ),
                                    ),
                                    height: 60,
                                    child: Center(
                                      child: Text(
                                        nilaiEkstraSiswa.extracurricularName,
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins',
                                          color: Color(0xff4B556B),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: (index % 2 == 1)
                                          ? Colors.white
                                          : const Color(0xffF0F1F2),
                                      border: const Border(
                                        right: BorderSide(
                                          width: 1.0,
                                          color: Color(0xff4B556B),
                                        ),
                                        left: BorderSide(
                                          width: 1.0,
                                          color: Color(0xff4B556B),
                                        ),
                                        bottom: BorderSide(
                                          width: 1.0,
                                          color: Color(0xff4B556B),
                                        ),
                                      ),
                                    ),
                                    height: 60,
                                    child: Center(
                                      child: Text(
                                        nilaiEkstraSiswa.extracurricularName,
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins',
                                          color: Color(0xff4B556B),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                      //Nilai
                      footer2 == index
                          ? Expanded(
                              child: Container(
                                color: (index % 2 == 1)
                                    ? Colors.white
                                    : const Color(0xffF0F1F2),
                                height: 60,
                                child: Center(
                                  child: Text(
                                    nilaiEkstraSiswa.nilai.toString(),
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Poppins',
                                      color: Color(0xff4B556B),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : footer == index
                              ? Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: (index % 2 == 1)
                                          ? Colors.white
                                          : const Color(0xffF0F1F2),
                                      border: const Border(
                                        bottom: BorderSide(
                                          width: 1.0,
                                          color: Color(0xff4B556B),
                                        ),
                                        top: BorderSide(
                                          width: 1.0,
                                          color: Color(0xff4B556B),
                                        ),
                                      ),
                                    ),
                                    height: 60,
                                    child: Center(
                                      child: Text(
                                        nilaiEkstraSiswa.nilai.toString(),
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins',
                                          color: Color(0xff4B556B),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: (index % 2 == 1)
                                          ? Colors.white
                                          : const Color(0xffF0F1F2),
                                      border: const Border(
                                        bottom: BorderSide(
                                          width: 1.0,
                                          color: Color(0xff4B556B),
                                        ),
                                      ),
                                    ),
                                    height: 60,
                                    child: Center(
                                      child: Text(
                                        nilaiEkstraSiswa.nilai.toString(),
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins',
                                          color: Color(0xff4B556B),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                      //Nila
                      //Predikat
                      footer == index
                          ? Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: (index % 2 == 1)
                                      ? Colors.white
                                      : const Color(0xffF0F1F2),
                                  border: Border.all(
                                    color: const Color(0xff4B556B),
                                  ),
                                  borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(20)),
                                ),
                                height: 60,
                                //Footer
                                child: Center(
                                  child: Text(
                                    nilaiEkstraSiswa.nilai > 90
                                        ? 'A'
                                        : nilaiEkstraSiswa.nilai > 83
                                            ? 'B'
                                            : nilaiEkstraSiswa.nilai > 75
                                                ? 'C'
                                                : nilaiEkstraSiswa.nilai > 68
                                                    ? 'D'
                                                    : 'E',
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Poppins',
                                      color: Color(0xff4B556B),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : footer2 == index
                              ? Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: (index % 2 == 1)
                                          ? Colors.white
                                          : const Color(0xffF0F1F2),
                                      border: const Border(
                                        right: BorderSide(
                                          width: 1.0,
                                          color: Color(0xff4B556B),
                                        ),
                                        left: BorderSide(
                                          width: 1.0,
                                          color: Color(0xff4B556B),
                                        ),
                                      ),
                                    ),
                                    height: 60,
                                    //Sebelum Footer
                                    child: Center(
                                      child: Text(
                                        nilaiEkstraSiswa.nilai > 90
                                            ? 'A'
                                            : nilaiEkstraSiswa.nilai > 83
                                                ? 'B'
                                                : nilaiEkstraSiswa.nilai > 75
                                                    ? 'C'
                                                    : nilaiEkstraSiswa.nilai >
                                                            68
                                                        ? 'D'
                                                        : 'E',
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins',
                                          color: Color(0xff4B556B),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: (index % 2 == 1)
                                          ? Colors.white
                                          : const Color(0xffF0F1F2),
                                      border: const Border(
                                        right: BorderSide(
                                          width: 1.0,
                                          color: Color(0xff4B556B),
                                        ),
                                        left: BorderSide(
                                          width: 1.0,
                                          color: Color(0xff4B556B),
                                        ),
                                        bottom: BorderSide(
                                          width: 1.0,
                                          color: Color(0xff4B556B),
                                        ),
                                      ),
                                    ),
                                    height: 60,
                                    //Normaly
                                    child: Center(
                                      child: Text(
                                        nilaiEkstraSiswa.nilai > 90
                                            ? 'A'
                                            : nilaiEkstraSiswa.nilai > 83
                                                ? 'B'
                                                : nilaiEkstraSiswa.nilai > 75
                                                    ? 'C'
                                                    : nilaiEkstraSiswa.nilai >
                                                            68
                                                        ? 'D'
                                                        : 'E',
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins',
                                          color: Color(0xff4B556B),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              semester == 'Genap'
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "C. Keterangan",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff4B556B),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 178,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xff4B556B),
                              ),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Keterangan Kenaikan Kelas :",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff4B556B),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1,
                                  ),
                                ),
                                Expanded(
                                    child: Center(
                                  child: Text(
                                    "Naik Kelas VIII",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xff4B556B),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Keterangan",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff4B556B),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: const [
                  SizedBox(
                    width: 40,
                    child: Text(
                      "A",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff4B556B),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  Text(
                    ":  ",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff4B556B),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                  Text(
                    "Sangat Baik",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff4B556B),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: const [
                  SizedBox(
                    width: 40,
                    child: Text(
                      "B",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff4B556B),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  Text(
                    ":  ",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff4B556B),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                  Text(
                    "Baik",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff4B556B),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: const [
                  SizedBox(
                    width: 40,
                    child: Text(
                      "C",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff4B556B),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  Text(
                    ":  ",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff4B556B),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                  Text(
                    "Cukup",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff4B556B),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Mengetahui,",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff4B556B),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: const [
                        Text(
                          "Orang Tua",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff4B556B),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          "Nama Orang Tua",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff4B556B),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          "Kepala Sekolah",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff4B556B),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                          "Nama Kepala Sekolah",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff4B556B),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1,
                          ),
                        ),
                        Container(
                          height: 2,
                          color: const Color(0xff4B556B),
                        ),
                        const Text(
                          "5152115212051",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff4B556B),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      const Center(
                        child: Text(
                          "Wali Kelas",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff4B556B),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        "Nama Wali Kelas",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff4B556B),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                        ),
                      ),
                      Container(
                        height: 2,
                        color: const Color(0xff4B556B),
                      ),
                      const Text(
                        "5152115212051",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff4B556B),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

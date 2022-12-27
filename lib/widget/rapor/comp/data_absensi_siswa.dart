import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:siakad_app/widget/text_paragraf.dart';
import 'package:http/http.dart' as http;

import '../../../constan.dart';

class DataAbsensiSiswa extends StatefulWidget {
  const DataAbsensiSiswa(
      {Key? key,
      required this.idAkademik,
      required this.idSemester,
      required this.idKelas,
      required this.nameSiswa,
      required this.nisnSIswa})
      : super(key: key);

  final String idAkademik, idSemester, idKelas, nameSiswa, nisnSIswa;

  @override
  State<DataAbsensiSiswa> createState() => _DataAbsensiSiswaState();
}

class _DataAbsensiSiswaState extends State<DataAbsensiSiswa> {
  String? pemattend,
      pemabsence,
      pemsick,
      pemizin,
      eksattend,
      eksabsence,
      ekssick,
      eksizin;
  bool pemloading = true;
  bool eksloading = true;

  String semester = '';
  String kelas = '';
  String akademik = '';

  void fungsigetStatistikSiswa() async {
    String token = await getToken();
    final response = await http
        .get(Uri.parse(baseURL + '/api/monitoring/statisticmapel'), headers: {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    });

    final data = jsonDecode(response.body)['data'];
    setState(() {
      pemloading = false;
      pemattend = data['attend'];
      pemabsence = data['absence'];
      pemsick = data['sick'];
      pemizin = data['izin'];
    });
    print(data);
  }

  void fungsigetStatistikEkstraSiswa() async {
    String token = await getToken();
    final response = await http
        .get(Uri.parse(baseURL + '/api/monitoring/statisticextra'), headers: {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    });

    final data = jsonDecode(response.body)['data'];
    setState(() {
      eksloading = false;
      eksattend = data['attend'];
      eksabsence = data['absence'];
      ekssick = data['sick'];
      eksizin = data['izin'];
    });
    print(data);
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
    fungsigetStatistikSiswa();
    fungsigetStatistikEkstraSiswa();
    getKelas();
    getSemester();
    getRahunAkademik();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Data Absensi Siswa",
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
                  "Kehadiran Pembelajaran",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xff4B556B),
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        pemattend == null ? 'Loading' : 'Hadir $pemattend %',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xff4B556B),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 23,
                  ),
                  Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xff3774C3),
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        pemizin == null ? 'Loading' : 'Izin $pemizin %',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xff3774C3),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xffFFB711),
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        pemsick == null ? 'Loading' : 'Sakit $pemsick %',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xffFFB711),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 23,
                  ),
                  Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xffFF4238),
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        pemabsence == null ? 'Loading' : 'Alpa $pemabsence %',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xffFF4238),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Text(
                  "Kehadiran Ekstrakurikuler",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xff4B556B),
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        eksattend == null ? 'Loading' : 'Hadir $eksattend %',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xff4B556B),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 23,
                  ),
                  Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xff3774C3),
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        eksizin == null ? 'Loading' : 'Izin $eksizin %',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xff3774C3),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xffFFB711),
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        ekssick == null ? 'Loading' : 'Sakit $ekssick %',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xffFFB711),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 23,
                  ),
                  Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xffFF4238),
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        eksabsence == null ? 'Loading' : 'Alpa $eksabsence %',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xffFF4238),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

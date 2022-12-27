import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:siakad_app/widget/rapor/comp/riwayat_rapor_walkel.dart';

import 'konfirmasi_nilai_siswa_walkel.dart';

class FilterDataNilaiSiswaWalkel extends StatefulWidget {
  const FilterDataNilaiSiswaWalkel({Key? key, required this.status})
      : super(key: key);

  final String status;

  @override
  State<FilterDataNilaiSiswaWalkel> createState() =>
      _FilterDataNilaiSiswaWalkelState();
}

class _FilterDataNilaiSiswaWalkelState
    extends State<FilterDataNilaiSiswaWalkel> {
  var valueTahunAkademikk;
  var valueSemester;
  var valueKelas;
  List tahunAkademikList = [];
  List semesterlist = [];
  List kelaslist = [];

  Future getTahunAkademik() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(baseURL + '/api/assessment/getacademic'),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body)['data'];
      setState(() {
        tahunAkademikList = jsonData;
      });
    }
  }

  Future getSemester() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(baseURL + '/api/assessment/getsemester'),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body)['data'];
      setState(() {
        semesterlist = jsonData;
      });
    }
  }

  Future getKelas() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(baseURL + '/api/assessment/getgrade'),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body)['data'];
      setState(() {
        kelaslist = jsonData;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getTahunAkademik();
    getSemester();
    getKelas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.status == 'data' ? 'Data Nilai Siswa' : 'Riwayat Rapor',
          style: const TextStyle(
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
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
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
                    hint: const Text('Tahun ajaran'),
                    items: tahunAkademikList.map((item) {
                      return DropdownMenuItem(
                        value: item['academic_year_id'].toString(),
                        child: Text(item['academic_year'].toString()),
                      );
                    }).toList(),
                    onChanged: (newVal) {
                      setState(() {
                        valueTahunAkademikk = newVal;
                        print(valueTahunAkademikk);
                      });
                    },
                    value: valueTahunAkademikk,
                  ),
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
                    hint: const Text('Semester'),
                    items: semesterlist.map((item) {
                      return DropdownMenuItem(
                        value: item['semester_id'].toString(),
                        child: Text(item['semester_name'].toString()),
                      );
                    }).toList(),
                    onChanged: (newVal) {
                      setState(() {
                        valueSemester = newVal;
                        print(valueSemester);
                      });
                    },
                    value: valueSemester,
                  ),
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
                    hint: const Text('Kelas'),
                    items: kelaslist.map((item) {
                      return DropdownMenuItem(
                        value: item['grade_id'].toString(),
                        child: Text(item['grade_name'].toString()),
                      );
                    }).toList(),
                    onChanged: (newVal) {
                      setState(() {
                        valueKelas = newVal;
                        print(valueKelas);
                      });
                    },
                    value: valueKelas,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                if (valueSemester == null) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Semester tidak boleh kosong')));
                } else if (valueKelas == null) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Kelas tidak boleh kosong')));
                } else if (valueTahunAkademikk == null) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Tahun ajaran tidak boleh kosong')));
                } else {
                  widget.status == 'data'
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => KonfirmasiNilaiSiswaWalkel(
                                    idAkademik: valueTahunAkademikk,
                                    idKelas: valueKelas,
                                    idSemester: valueSemester,
                                  )))
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RiwayatRaporWalkel(
                                    idAkademik: valueTahunAkademikk,
                                    idKelas: valueKelas,
                                    idSemester: valueSemester,
                                  )));
                }
              },
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
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
                    "Lanjutkan",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        letterSpacing: 1),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

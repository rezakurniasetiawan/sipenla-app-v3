import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/rapor_model.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:siakad_app/services/rapor_service.dart';

import '../../../constan.dart';
import '../../text_paragraf.dart';
import 'detail_konfirmasi_nilai_siswa_kepsek.dart';

class KonfirmasiNilaiSiswaKepsek extends StatefulWidget {
  const KonfirmasiNilaiSiswaKepsek(
      {Key? key, required this.idAkademik, required this.idSemester})
      : super(key: key);

  final String idAkademik, idSemester;

  @override
  State<KonfirmasiNilaiSiswaKepsek> createState() =>
      _KonfirmasiNilaiSiswaKepsekState();
}

class _KonfirmasiNilaiSiswaKepsekState
    extends State<KonfirmasiNilaiSiswaKepsek> {
  String semester = '';
  String akademik = '';
  List<dynamic> _listStudent = [];
  bool _loading = true;

  Future<void> fungsiGetSiswaKonfirmasiNilai() async {
    ApiResponse response = await getKelasKonfirmasiNilai();
    if (response.error == null) {
      setState(() {
        _listStudent = response.data as List<dynamic>;
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

  Future getTahunAkademik() async {
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

  void fungsiUpdateKonfirmasiNilai(int idClass, String className) async {
    showAlertDialog(context);
    ApiResponse response = await konfirmasiNilaibyKelasKepsek(
      idKelas: idClass,
    );
    if (response.error == null) {
      print("Update Suskses");
      Navigator.pop(context);
      setState(() {
        fungsiGetSiswaKonfirmasiNilai();
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Berhasil Konfirmasi Nilai Siswa Kelas $className')));
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
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    getSemester();
    getTahunAkademik();
    fungsiGetSiswaKonfirmasiNilai();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Data Nilai Siswa",
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
                "Nilai Rapor",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff4B556B),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
            ),
            Center(
              child: Text(
                'Semester $semester $akademik',
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xff4B556B),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: _loading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.blueAccent,
                        ),
                      )
                    : ListView.builder(
                        itemCount: _listStudent.length,
                        itemBuilder: (BuildContext context, int index) {
                          DataKelasKepsekModel dataKelasKepsekModel =
                              _listStudent[index];
                          return Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xff4B556B),
                                    ),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      TextParagraf(
                                        title: 'Kelas',
                                        value: dataKelasKepsekModel.gradeName,
                                      ),
                                      TextParagraf(
                                        title: 'Semester',
                                        value: semester,
                                      ),
                                      TextParagraf(
                                        title: 'Tahun Ajaran',
                                        value: akademik,
                                      ),
                                      // TextParagraf(
                                      //   title: 'Wali Kelas',
                                      //   value: 'Lorem Ipsum',
                                      // ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const DetailKonfirmasiNilaiSiswaKepsek()));
                                            },
                                            child: const SizedBox(
                                              width: 100,
                                              height: 42,
                                              child: Center(
                                                child: Text(
                                                  "Detail",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'Poppins',
                                                      color: Color(0xff2E447C),
                                                      letterSpacing: 1),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              fungsiUpdateKonfirmasiNilai(
                                                  dataKelasKepsekModel.gradeId,
                                                  dataKelasKepsekModel
                                                      .gradeName);
                                            },
                                            child: Container(
                                              width: 100,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                gradient: const LinearGradient(
                                                  begin: FractionalOffset
                                                      .centerLeft,
                                                  end: FractionalOffset
                                                      .centerRight,
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
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
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
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          );
                        }))
          ],
        ),
      ),
    );
  }
}

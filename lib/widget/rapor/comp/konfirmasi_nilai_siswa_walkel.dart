import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/absensi_siswa_model.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:siakad_app/services/rapor_service.dart';

import '../../text_paragraf.dart';
import 'detail_nilai_siswa_walkel.dart';
import 'detail_v2_nilai_siswa_walkel.dart';

class KonfirmasiNilaiSiswaWalkel extends StatefulWidget {
  const KonfirmasiNilaiSiswaWalkel(
      {Key? key,
      required this.idAkademik,
      required this.idKelas,
      required this.idSemester})
      : super(key: key);

  final String idAkademik, idSemester, idKelas;

  @override
  State<KonfirmasiNilaiSiswaWalkel> createState() =>
      _KonfirmasiNilaiSiswaWalkelState();
}

class _KonfirmasiNilaiSiswaWalkelState
    extends State<KonfirmasiNilaiSiswaWalkel> {
  String semester = '';
  String kelas = '';
  String akademik = '';
  List mapellist = [];
  var valueMapel;
  bool _loading = true;
  List<dynamic> _listStudent = [];

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

  void fungsiUpdateKonfirmasiNilai(int idStudent) async {
    showAlertDialog(context);
    ApiResponse response = await konfirmasiNilaiSiswa(
        idKelas: int.parse(widget.idKelas),
        idStudent: idStudent,
        idSemester: int.parse(widget.idSemester),
        idAkademik: int.parse(widget.idAkademik),
        idMapel: int.parse(valueMapel));
    if (response.error == null) {
      print("Update Suskses");
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Berhasil Konfirmasi Nilai Siswa')));
      fungsiGetSiswaKonfirmasiNilai();
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

  Future<void> fungsiGetSiswaKonfirmasiNilai() async {
    ApiResponse response =
        await getSiswaKonfirmasiNilai(idKelas: widget.idKelas);
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
        mapellist = jsonData;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getSemester();
    getRahunAkademik();
    getKelas();
    getMapel();
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
            Center(
              child: Text(
                kelas,
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
                    items: mapellist.map((item) {
                      return DropdownMenuItem(
                        value: item['subject_id'].toString(),
                        child: Text(item['subject_name'].toString()),
                      );
                    }).toList(),
                    onChanged: (newVal) {
                      setState(() {
                        valueMapel = newVal;
                        fungsiGetSiswaKonfirmasiNilai();
                        print(valueMapel);
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
                        SiswaKonfirmasiPenilaianModel
                            siswaKonfirmasiPenilaianModel = _listStudent[index];

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
                                      title: 'Nama Siswa',
                                      value: siswaKonfirmasiPenilaianModel
                                              .firstName +
                                          ' ' +
                                          siswaKonfirmasiPenilaianModel
                                              .lastName,
                                    ),
                                    TextParagraf(
                                        title: 'NISN',
                                        value:
                                            siswaKonfirmasiPenilaianModel.nisn),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (valueMapel == null) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'Mata Pelajaran wajib diisi')));
                                            } else {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailV2NilaiSiswaWalkel(
                                                    idAkademik:
                                                        widget.idAkademik,
                                                    idGrade: widget.idKelas,
                                                    idMapel: valueMapel,
                                                    idSemester:
                                                        widget.idSemester,
                                                    idStudent:
                                                        siswaKonfirmasiPenilaianModel
                                                            .studentId
                                                            .toString(),
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          child: const SizedBox(
                                            width: 100,
                                            height: 42,
                                            child: Center(
                                              child: Text(
                                                "Detail",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
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
                                            if (valueMapel == null) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'Mata Pelajaran wajib diisi')));
                                            } else {
                                              fungsiUpdateKonfirmasiNilai(
                                                  siswaKonfirmasiPenilaianModel
                                                      .studentId);
                                            }
                                          },
                                          child: Container(
                                            width: 100,
                                            height: 42,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              gradient: const LinearGradient(
                                                begin:
                                                    FractionalOffset.centerLeft,
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
                            )
                          ],
                        );
                      }),
            ),
          ],
        ),
      ),
    );
  }
}

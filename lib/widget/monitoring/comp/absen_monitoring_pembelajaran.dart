import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/absensi_siswa_model.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/multiple_models.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/services/absensi_service.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:http/http.dart' as http;

class AbsenMonitoringPembelajaran extends StatefulWidget {
  const AbsenMonitoringPembelajaran(
      {Key? key, required this.mapelId, required this.kelasId})
      : super(key: key);

  final int mapelId, kelasId;

  @override
  State<AbsenMonitoringPembelajaran> createState() =>
      _AbsenMonitoringPembelajaranState();
}

class _AbsenMonitoringPembelajaranState
    extends State<AbsenMonitoringPembelajaran> {
  bool _loading = true;
  // ignore: non_constant_identifier_names
  List<dynamic> _SiswaList = [];

  int lenghtStudent = 0;
  // ignore: prefer_final_fields
  static int _len = 50;
  List<bool> isChecked1 = List.generate(_len, (index) => false);
  List<bool> isChecked2 = List.generate(_len, (index) => false);
  List<bool> isChecked3 = List.generate(_len, (index) => false);
  List<bool> isChecked4 = List.generate(_len, (index) => false);

  MultipleModels multipleModels = MultipleModels(books: []);

  Future<void> fungsiGetSiswa() async {
    ApiResponse response = await getSiswaForAbsen(id: widget.kelasId);
    if (response.error == null) {
      setState(() {
        _SiswaList = response.data as List<dynamic>;
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

  void send(int idClass, int idMapel) async {
    showAlertDialog(context);
    String token = await getToken();
    var response = await http.post(
      Uri.parse(baseURL + '/api/monitoring/postattendance/$idClass/$idMapel'),
      headers: {
        "Content-type": "application/json",
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
      body: json.encode(multipleModels.toJson()),
    );
    if (response.statusCode == 200) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Berhasil Absensi Siswa')));
      Navigator.pop(context);
    } else if (response.statusCode == 400) {
      String respon = json.decode(response.body)['meta']['message'];
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(respon)));
    }
  }

  String mapel = '';
  String kelas = '';

  Future getMapel() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(
          baseURL + '/api/monitoring/getsubject/' + widget.mapelId.toString()),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body)['data']['subject_name'];
      setState(() {
        mapel = jsonData;
      });
    }
  }

  Future getKelas() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(
          baseURL + '/api/monitoring/getday/' + widget.kelasId.toString()),
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

  @override
  void initState() {
    super.initState();
    fungsiGetSiswa();
    getMapel();
    getKelas();
    multipleModels.books = <Book>[];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Monitoring Pembelajaran',
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
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              'Mata Pelajaran $mapel',
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xff4B556B),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Center(
            child: Text(
              'Kelas $kelas',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xff4B556B),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          // Expanded(
          //   child: ListView.builder(
          //       itemCount: multipleModels.books.length,
          //       itemBuilder: (BuildContext context, int index) => Column(
          //             children: <Widget>[
          //               Text(multipleModels.books[index].status),
          //               Text(multipleModels.books[index].studentId.toString()),
          //               SizedBox(
          //                 height: 30,
          //               )
          //             ],
          //           )),
          // ),
          _loading
              ? const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.blueAccent,
                    ),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: _SiswaList.length,
                    itemBuilder: (BuildContext context, int index) {
                      AbsensiSiswaModel absensiSiswaModel = _SiswaList[index];

                      lenghtStudent = _SiswaList.length;

                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          height: 130,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xff4B556B),
                              ),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 100,
                                      child: Text(
                                        'Nama',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Color(0xff4B556B),
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      ': ${absensiSiswaModel.firstName + ' ' + absensiSiswaModel.lastName}',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Color(0xff4B556B),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 100,
                                      child: Text(
                                        'NISN',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Color(0xff4B556B),
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      ': ${absensiSiswaModel.nisn}',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Color(0xff4B556B),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        // print(absensiSiswaModel.firstName);
                                      },
                                      child: Container(
                                          height: 35,
                                          width: 75,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: const Color(0xff4B556B),
                                              ),
                                              // color: const Color(0xff4B556B),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 30,
                                                child: Checkbox(
                                                  onChanged: (checked) {
                                                    setState(
                                                      () {
                                                        isChecked1[index] =
                                                            checked!;
                                                        if (isChecked1[index] ==
                                                            true) {
                                                          multipleModels.books.add(Book(
                                                              gradeId: widget
                                                                  .kelasId,
                                                              studentId:
                                                                  absensiSiswaModel
                                                                      .studentId,
                                                              subjectId: widget
                                                                  .mapelId,
                                                              status: 'mas'));
                                                        } else {
                                                          isChecked2[index] =
                                                              false;
                                                          isChecked3[index] =
                                                              false;
                                                          isChecked4[index] =
                                                              false;
                                                          if (multipleModels
                                                              .books
                                                              .any((element) =>
                                                                  element
                                                                      .status ==
                                                                  'mas')) {
                                                            multipleModels.books
                                                                .removeWhere((element) =>
                                                                    element
                                                                        .studentId ==
                                                                    absensiSiswaModel
                                                                        .studentId);
                                                          } else if (absensiSiswaModel
                                                                  .studentId ==
                                                              absensiSiswaModel
                                                                  .studentId) {}

                                                          // if (absensiSiswaModel
                                                          //         .studentId ==
                                                          //     absensiSiswaModel
                                                          //         .studentId) {
                                                          //   multipleModels.books
                                                          //       .removeWhere(
                                                          //           (element) =>
                                                          //               element
                                                          //                   .status ==
                                                          //               'hadir');
                                                          // }
                                                        }
                                                      },
                                                    );
                                                  },
                                                  value: isChecked1[index],
                                                ),
                                              ),
                                              const Text(
                                                'Hadir',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: Color(0xff4B556B),
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                    Container(
                                      height: 35,
                                      width: 75,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: const Color(0xff4B556B),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 30,
                                            child: Checkbox(
                                              onChanged: (checked) {
                                                setState(
                                                  () {
                                                    isChecked2[index] =
                                                        checked!;
                                                    if (isChecked2[index] ==
                                                        true) {
                                                      multipleModels.books.add(Book(
                                                          gradeId:
                                                              widget.kelasId,
                                                          studentId:
                                                              absensiSiswaModel
                                                                  .studentId,
                                                          subjectId:
                                                              widget.mapelId,
                                                          status: 'mls'));
                                                    } else {
                                                      isChecked1[index] = false;
                                                      isChecked3[index] = false;
                                                      isChecked4[index] = false;
                                                      if (multipleModels.books
                                                          .any((element) =>
                                                              element.status ==
                                                              'mls')) {
                                                        multipleModels.books
                                                            .removeWhere((element) =>
                                                                element
                                                                    .studentId ==
                                                                absensiSiswaModel
                                                                    .studentId);
                                                      } else if (absensiSiswaModel
                                                              .studentId ==
                                                          absensiSiswaModel
                                                              .studentId) {}
                                                    }
                                                  },
                                                );
                                              },
                                              value: isChecked2[index],
                                            ),
                                          ),
                                          const Text(
                                            'Izin',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Color(0xff3774C3),
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 35,
                                      width: 75,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: const Color(0xff4B556B),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 30,
                                            child: Checkbox(
                                              onChanged: (checked) {
                                                setState(
                                                  () {
                                                    isChecked3[index] =
                                                        checked!;
                                                    if (isChecked3[index] ==
                                                        true) {
                                                      multipleModels.books.add(Book(
                                                          gradeId:
                                                              widget.kelasId,
                                                          studentId:
                                                              absensiSiswaModel
                                                                  .studentId,
                                                          subjectId:
                                                              widget.mapelId,
                                                          status: 'mss'));
                                                    } else {
                                                      isChecked1[index] = false;
                                                      isChecked2[index] = false;
                                                      isChecked4[index] = false;
                                                      if (multipleModels.books
                                                          .any((element) =>
                                                              element.status ==
                                                              'mss')) {
                                                        multipleModels.books
                                                            .removeWhere((element) =>
                                                                element
                                                                    .studentId ==
                                                                absensiSiswaModel
                                                                    .studentId);
                                                      } else if (absensiSiswaModel
                                                              .studentId ==
                                                          absensiSiswaModel
                                                              .studentId) {}
                                                    }
                                                  },
                                                );
                                              },
                                              value: isChecked3[index],
                                            ),
                                          ),
                                          const Text(
                                            'Sakit',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Color(0xffFFB711),
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        height: 35,
                                        width: 75,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: const Color(0xff4B556B),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 30,
                                              child: Checkbox(
                                                onChanged: (checked) {
                                                  setState(
                                                    () {
                                                      isChecked4[index] =
                                                          checked!;
                                                      if (isChecked4[index] ==
                                                          true) {
                                                        multipleModels.books.add(Book(
                                                            gradeId:
                                                                widget.kelasId,
                                                            studentId:
                                                                absensiSiswaModel
                                                                    .studentId,
                                                            subjectId:
                                                                widget.mapelId,
                                                            status: 'mes'));
                                                      } else {
                                                        isChecked1[index] =
                                                            false;
                                                        isChecked2[index] =
                                                            false;
                                                        isChecked3[index] =
                                                            false;
                                                        if (multipleModels.books
                                                            .any((element) =>
                                                                element
                                                                    .status ==
                                                                'mes')) {
                                                          multipleModels.books
                                                              .removeWhere((element) =>
                                                                  element
                                                                      .studentId ==
                                                                  absensiSiswaModel
                                                                      .studentId);
                                                        } else if (absensiSiswaModel
                                                                .studentId ==
                                                            absensiSiswaModel
                                                                .studentId) {}
                                                      }
                                                    },
                                                  );
                                                },
                                                value: isChecked4[index],
                                              ),
                                            ),
                                            const Text(
                                              'Alpa',
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Color(0xffFF4238),
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: GestureDetector(
              onTap: () {
                if (lenghtStudent == multipleModels.books.length) {
                  send(widget.kelasId, widget.mapelId);
                } else if (multipleModels.books.length > lenghtStudent) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Ada kelebihan siswa yang diabsenkan')));
                } else if (multipleModels.books.length < lenghtStudent) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Ada siswa yang belum diabsenkan')));
                }
              },
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 55,
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
                    "Simpan",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        letterSpacing: 1),
                  )),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

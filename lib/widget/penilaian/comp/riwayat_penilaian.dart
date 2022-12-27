import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:siakad_app/models/penilaian_model.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:siakad_app/services/penilaian_service.dart';
import 'package:siakad_app/widget/penilaian/comp/edit_penilaian.dart';

class RiwayatPenilaian extends StatefulWidget {
  const RiwayatPenilaian(
      {Key? key,
      required this.idClass,
      required this.idJenpen,
      required this.idMapel,
      required this.idSemester})
      : super(key: key);

  final String idClass, idJenpen, idMapel, idSemester;

  @override
  State<RiwayatPenilaian> createState() => _RiwayatPenilaianState();
}

class _RiwayatPenilaianState extends State<RiwayatPenilaian> {
  bool _loading = true;
  List<dynamic> _NilaiList = [];

  String semester = '';
  String kelas = '';
  String mapel = '';
  String penilaian = '';

  Future<void> fungsiGeNilaiStudent() async {
    ApiResponse response = await getNilaiStudent(
        idClass: widget.idClass,
        idJenPen: widget.idJenpen,
        idMapel: widget.idMapel,
        idSemester: widget.idSemester);
    if (response.error == null) {
      setState(() {
        _NilaiList = response.data as List<dynamic>;
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

  Future getMapel() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(baseURL + '/api/monitoring/getsubject/' + widget.idMapel),
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
      Uri.parse(baseURL + '/api/monitoring/getday/' + widget.idClass),
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

  Future getPenilaian() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(baseURL + '/api/assessment/getassessment/' + widget.idJenpen),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body)['data']['assessment_name'];
      setState(() {
        penilaian = jsonData;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getMapel();
    getKelas();
    getSemester();
    getPenilaian();
    fungsiGeNilaiStudent();
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
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 130,
                  child: Text(
                    "Kelas",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      color: Color(0xff4B556B),
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
                      color: Color(0xff4B556B),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    kelas == '' ? 'Loading' : kelas,
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
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 130,
                  child: Text(
                    "Mata Pelajaran",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      color: Color(0xff4B556B),
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
                      color: Color(0xff4B556B),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    mapel == '' ? 'Loading' : mapel,
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
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 130,
                  child: Text(
                    "Semester",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      color: Color(0xff4B556B),
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
                      color: Color(0xff4B556B),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    semester == '' ? 'Loading' : semester,
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
              height: 20,
            ),
            Center(
              child: Text(
                penilaian == '' ? 'Loading' : penilaian,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins',
                  color: Color(0xff4B556B),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
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
                        'NISN',
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
                      right: BorderSide(
                        width: 1.0,
                        color: Color(0xff4B556B),
                      ),
                    )),
                    height: 60,
                    child: const Center(
                      child: Text(
                        'Nama',
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
                    child: Center(
                      child: Text(
                        penilaian == '' ? 'Loading' : penilaian,
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
                        'Keterangan',
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
            Expanded(
              child: ListView.builder(
                itemCount: _NilaiList.length,
                itemBuilder: (BuildContext context, int index) {
                  NilaiStudentModel nilaiStudentModel = _NilaiList[index];
                  int footer = _NilaiList.length - 1;
                  int footer2 = _NilaiList.length - 2;
                  return Row(
                    children: [
                      //NISN
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
                                    nilaiStudentModel.nisn,
                                    textAlign: TextAlign.center,
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
                                        nilaiStudentModel.nisn,
                                        textAlign: TextAlign.center,
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
                                        nilaiStudentModel.nisn,
                                        textAlign: TextAlign.center,
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
                      //Nama
                      footer2 == index
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
                                    )),
                                height: 60,
                                child: Center(
                                  child: Text(
                                    nilaiStudentModel.firstName +
                                        ' ' +
                                        nilaiStudentModel.lastName,
                                    textAlign: TextAlign.center,
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
                                        right: BorderSide(
                                          width: 1.0,
                                          color: Color(0xff4B556B),
                                        ),
                                      ),
                                    ),
                                    height: 60,
                                    child: Center(
                                      child: Text(
                                        nilaiStudentModel.firstName +
                                            ' ' +
                                            nilaiStudentModel.lastName,
                                        textAlign: TextAlign.center,
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
                                        right: BorderSide(
                                          width: 1.0,
                                          color: Color(0xff4B556B),
                                        ),
                                      ),
                                    ),
                                    height: 60,
                                    child: Center(
                                      child: Text(
                                        nilaiStudentModel.firstName +
                                            ' ' +
                                            nilaiStudentModel.lastName,
                                        textAlign: TextAlign.center,
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
                                    nilaiStudentModel.nilai.toString(),
                                    textAlign: TextAlign.center,
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
                                        nilaiStudentModel.nilai.toString(),
                                        textAlign: TextAlign.center,
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
                                        nilaiStudentModel.nilai.toString(),
                                        textAlign: TextAlign.center,
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
                      //Keterangan
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
                                    child: GestureDetector(
                                  onTap: () async {
                                    String refresh = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditPenilaian(
                                                  idClass: widget.idClass,
                                                  idJenpen: widget.idJenpen,
                                                  idMapel: widget.idMapel,
                                                  idSemester: widget.idSemester,
                                                  nilai: nilaiStudentModel.nilai
                                                      .toString(),
                                                  nisn: nilaiStudentModel.nisn,
                                                  idPenilaian: nilaiStudentModel
                                                      .penilaianId
                                                      .toString(),
                                                )));
                                    if (refresh == 'refresh') {
                                      fungsiGeNilaiStudent();
                                    }
                                  },
                                  child: Center(
                                    child: Container(
                                      width: 54,
                                      height: 34,
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
                                        "Edit",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                            letterSpacing: 1),
                                      )),
                                    ),
                                  ),
                                )),
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
                                        child: GestureDetector(
                                      onTap: () async {
                                        String refresh = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditPenilaian(
                                                      idClass: widget.idClass,
                                                      idJenpen: widget.idJenpen,
                                                      idMapel: widget.idMapel,
                                                      idSemester:
                                                          widget.idSemester,
                                                      nilai: nilaiStudentModel
                                                          .nilai
                                                          .toString(),
                                                      nisn: nilaiStudentModel
                                                          .nisn,
                                                      idPenilaian:
                                                          nilaiStudentModel
                                                              .penilaianId
                                                              .toString(),
                                                    )));
                                        if (refresh == 'refresh') {
                                          fungsiGeNilaiStudent();
                                        }
                                      },
                                      child: Center(
                                        child: Container(
                                          width: 54,
                                          height: 34,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            gradient: const LinearGradient(
                                              begin:
                                                  FractionalOffset.centerLeft,
                                              end: FractionalOffset.centerRight,
                                              colors: [
                                                Color(0xff2E447C),
                                                Color(0xff3774C3),
                                              ],
                                            ),
                                          ),
                                          child: const Center(
                                              child: Text(
                                            "Edit",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Poppins',
                                                color: Colors.white,
                                                letterSpacing: 1),
                                          )),
                                        ),
                                      ),
                                    )),
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
                                        child: GestureDetector(
                                      onTap: () async {
                                        String refresh = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditPenilaian(
                                                      idClass: widget.idClass,
                                                      idJenpen: widget.idJenpen,
                                                      idMapel: widget.idMapel,
                                                      idSemester:
                                                          widget.idSemester,
                                                      nilai: nilaiStudentModel
                                                          .nilai
                                                          .toString(),
                                                      nisn: nilaiStudentModel
                                                          .nisn,
                                                      idPenilaian:
                                                          nilaiStudentModel
                                                              .penilaianId
                                                              .toString(),
                                                    )));
                                        if (refresh == 'refresh') {
                                          fungsiGeNilaiStudent();
                                        }
                                      },
                                      child: Center(
                                        child: Container(
                                          width: 54,
                                          height: 34,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            gradient: const LinearGradient(
                                              begin:
                                                  FractionalOffset.centerLeft,
                                              end: FractionalOffset.centerRight,
                                              colors: [
                                                Color(0xff2E447C),
                                                Color(0xff3774C3),
                                              ],
                                            ),
                                          ),
                                          child: const Center(
                                              child: Text(
                                            "Edit",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Poppins',
                                                color: Colors.white,
                                                letterSpacing: 1),
                                          )),
                                        ),
                                      ),
                                    )),
                                  ),
                                )
                    ],
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

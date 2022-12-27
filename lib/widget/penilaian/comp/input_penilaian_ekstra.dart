import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:siakad_app/widget/text_paragraf.dart';
// import 'dart:convert';
import '../../../constan.dart';
import '../../../models/api_response_model.dart';
import '../../../models/penilaian_model.dart';
import '../../../screens/started_screen.dart';
import '../../../services/auth_service.dart';
import '../../../services/penilaian_service.dart';
import 'package:http/http.dart' as http;

class InputPenilaianEkstra extends StatefulWidget {
  const InputPenilaianEkstra(
      {Key? key,
      required this.idAkademik,
      required this.idSemester,
      required this.idEkstraPembina,
      required this.nameekstraPembina})
      : super(key: key);

  final String idAkademik, idSemester, nameekstraPembina;
  final int idEkstraPembina;

  @override
  State<InputPenilaianEkstra> createState() => _InputPenilaianEkstraState();
}

class _InputPenilaianEkstraState extends State<InputPenilaianEkstra> {
  bool _loading = true;
  List<dynamic> _StudentList = [];
  String nilai = '';
  int lenghtStudent = 0;
  String semester = '';
  String akademik = '';

  MappingPenilaianEkstraModel mappingPenilaianEkstraModel =
      MappingPenilaianEkstraModel(books: []);

  get json => null;
  Future<void> fungsigetStudentForNilaiEkstra() async {
    ApiResponse response = await getStudentForNilaiEkstra();
    if (response.error == null) {
      setState(() {
        _StudentList = response.data as List<dynamic>;
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
      // var jsonData = json.decode(response.body)['data']['semester_name'];
      var jsonData = jsonDecode(response.body)['data']['semester_name'];
      setState(() {
        semester = jsonData;
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
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body)['data']['academic_year'];
      setState(() {
        akademik = jsonData;
        print(akademik);
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

  void send() async {
    showAlertDialog(context);
    String token = await getToken();
    var response = await http.post(
      Uri.parse(baseURL + '/api/assessmentextra/addpenilaian'),
      headers: {
        "Content-type": "application/json",
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(mappingPenilaianEkstraModel.toJson()),
    );
    // ignore: avoid_print
    print(response.body);
    if (response.statusCode == 200) {
      Navigator.pop(context);

      // ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('Berhasil Penilaian Siswa Kelas' + kelas)));
      Navigator.pop(context);
      setState(() {
        showDialog(
          context: context,
          builder: (context) {
            return Container(
              child: AlertDialog(
                actions: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 20,
                                width: 20,
                                child:
                                    Image.asset('assets/icons/icon-close.png'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 85,
                        width: 85,
                        child: Image.asset('assets/icons/success-icon.png'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          'Berhasil Menyimpan Data',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins',
                            color: Color(0xff4B556B),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      });
    } else if (response.statusCode == 400) {
      String respon = json.decode(response.body)['meta']['message'];
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(respon)));
    }
  }

  @override
  void initState() {
    super.initState();
    fungsigetStudentForNilaiEkstra();
    getRahunAkademik();
    getSemester();
    mappingPenilaianEkstraModel.books = <BookEkstra>[];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Penilaian Ekstrakulikuler",
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
            TextParagraf(
              title: 'Ektrakulikuler',
              value: widget.nameekstraPembina,
            ),
            TextParagraf(
              title: 'Semester',
              value: semester,
            ),
            TextParagraf(
              title: 'Tahun Ajaran',
              value: akademik,
            ),
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Text(
                'Nilai Ekstrakuliler',
                style: TextStyle(
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
            // Expanded(
            //   child: ListView.builder(
            //       itemCount: mappingPenilaianEkstraModel.books.length,
            //       itemBuilder: (BuildContext context, int index) => Column(
            //             children: <Widget>[
            //               Text(mappingPenilaianEkstraModel
            //                   .books[index].studentId
            //                   .toString()),
            //               Text(mappingPenilaianEkstraModel.books[index].nilai
            //                   .toString()),
            //               const SizedBox(
            //                 height: 30,
            //               )
            //             ],
            //           )),
            // ),
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
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xff4B556B),
                        ),
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20))),
                    height: 60,
                    child: const Center(
                      child: Text(
                        'Nila',
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
                itemCount: _StudentList.length,
                itemBuilder: (BuildContext context, int index) {
                  PenilaianEkstrStudentModel penilaianEkstrStudentModel =
                      _StudentList[index];
                  int footer = _StudentList.length - 1;
                  int footer2 = _StudentList.length - 2;
                  lenghtStudent = _StudentList.length;
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
                                    penilaianEkstrStudentModel.nisn,
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
                                        penilaianEkstrStudentModel.nisn,
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
                                        penilaianEkstrStudentModel.nisn,
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
                      footer2 == index
                          ? Expanded(
                              child: Container(
                                color: (index % 2 == 1)
                                    ? Colors.white
                                    : const Color(0xffF0F1F2),
                                height: 60,
                                child: Center(
                                  child: Text(
                                    penilaianEkstrStudentModel.firstName +
                                        ' ' +
                                        penilaianEkstrStudentModel.lastName,
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
                                        penilaianEkstrStudentModel.firstName +
                                            ' ' +
                                            penilaianEkstrStudentModel.lastName,
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
                                        penilaianEkstrStudentModel.firstName +
                                            ' ' +
                                            penilaianEkstrStudentModel.lastName,
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
                                  child: TextFormField(
                                    // controller: nilai,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    textAlign: TextAlign.center,
                                    onChanged: (value) {
                                      nilai = value;
                                      // int nilakus = int.parse(value);
                                      if (value.length == 2) {
                                        mappingPenilaianEkstraModel.books
                                            .removeWhere((element) =>
                                                element.studentId ==
                                                penilaianEkstrStudentModel
                                                    .studentId);
                                        mappingPenilaianEkstraModel.books.add(
                                          BookEkstra(
                                            nilai: int.parse(
                                              nilai.toString(),
                                            ),
                                            studentId:
                                                penilaianEkstrStudentModel
                                                    .studentId,
                                            semesterId:
                                                int.parse(widget.idSemester),
                                            academicYearId:
                                                int.parse(widget.idAkademik),
                                            extracurricularId:
                                                widget.idEkstraPembina,
                                          ),
                                        );
                                      }
                                      if (value.length == 3) {
                                        if (int.parse(nilai) > 100) {
                                          print('kelebihan');
                                          mappingPenilaianEkstraModel.books
                                              .removeWhere((element) =>
                                                  element.studentId ==
                                                  penilaianEkstrStudentModel
                                                      .studentId);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Nilai yang dimasukkan tidak boleh lebih dari 100')));
                                        } else if (int.parse(nilai) < 0) {
                                          print('kekurangan');
                                          mappingPenilaianEkstraModel.books
                                              .removeWhere((element) =>
                                                  element.studentId ==
                                                  penilaianEkstrStudentModel
                                                      .studentId);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Nilai yang dimasukkan tidak boleh kurang dari 0')));
                                        } else {
                                          mappingPenilaianEkstraModel.books
                                              .removeWhere((element) =>
                                                  element.studentId ==
                                                  penilaianEkstrStudentModel
                                                      .studentId);
                                          mappingPenilaianEkstraModel.books.add(
                                            BookEkstra(
                                              nilai: int.parse(
                                                nilai.toString(),
                                              ),
                                              studentId:
                                                  penilaianEkstrStudentModel
                                                      .studentId,
                                              semesterId:
                                                  int.parse(widget.idSemester),
                                              academicYearId:
                                                  int.parse(widget.idAkademik),
                                              extracurricularId:
                                                  widget.idEkstraPembina,
                                            ),
                                          );
                                        }
                                      }
                                      if (nilai == '') {
                                        mappingPenilaianEkstraModel.books
                                            .removeWhere((element) =>
                                                element.studentId ==
                                                penilaianEkstrStudentModel
                                                    .studentId);
                                      }
                                    },
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(3),
                                    ],
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
                                      child: TextFormField(
                                        // controller: nilai,
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        textAlign: TextAlign.center,
                                        onChanged: (value) {
                                          nilai = value;
                                          // int nilakus = int.parse(value);
                                          if (value.length == 2) {
                                            mappingPenilaianEkstraModel.books
                                                .removeWhere((element) =>
                                                    element.studentId ==
                                                    penilaianEkstrStudentModel
                                                        .studentId);
                                            mappingPenilaianEkstraModel.books
                                                .add(
                                              BookEkstra(
                                                nilai: int.parse(
                                                  nilai.toString(),
                                                ),
                                                studentId:
                                                    penilaianEkstrStudentModel
                                                        .studentId,
                                                semesterId: int.parse(
                                                    widget.idSemester),
                                                academicYearId: int.parse(
                                                    widget.idAkademik),
                                                extracurricularId:
                                                    widget.idEkstraPembina,
                                              ),
                                            );
                                            // FocusScope.of(context).nextFocus();
                                          }
                                          if (value.length == 3) {
                                            if (int.parse(nilai) > 100) {
                                              mappingPenilaianEkstraModel.books
                                                  .removeWhere((element) =>
                                                      element.studentId ==
                                                      penilaianEkstrStudentModel
                                                          .studentId);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'Nilai yang dimasukkan tidak boleh lebih dari 100')));
                                            } else if (int.parse(nilai) < 0) {
                                              print('kekurangan');
                                              mappingPenilaianEkstraModel.books
                                                  .removeWhere((element) =>
                                                      element.studentId ==
                                                      penilaianEkstrStudentModel
                                                          .studentId);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'Nilai yang dimasukkan tidak boleh kurang dari 0')));
                                            } else {
                                              mappingPenilaianEkstraModel.books
                                                  .removeWhere((element) =>
                                                      element.studentId ==
                                                      penilaianEkstrStudentModel
                                                          .studentId);
                                              mappingPenilaianEkstraModel.books
                                                  .add(
                                                BookEkstra(
                                                  nilai: int.parse(
                                                    nilai.toString(),
                                                  ),
                                                  studentId:
                                                      penilaianEkstrStudentModel
                                                          .studentId,
                                                  semesterId: int.parse(
                                                      widget.idSemester),
                                                  academicYearId: int.parse(
                                                      widget.idAkademik),
                                                  extracurricularId:
                                                      widget.idEkstraPembina,
                                                ),
                                              );
                                            }
                                          }
                                          if (nilai == '') {
                                            mappingPenilaianEkstraModel.books
                                                .removeWhere((element) =>
                                                    element.studentId ==
                                                    penilaianEkstrStudentModel
                                                        .studentId);
                                          }
                                        },
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(3),
                                        ],
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
                                      child: TextFormField(
                                        // controller: nilai,
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        textAlign: TextAlign.center,
                                        onChanged: (value) {
                                          nilai = value;
                                          // int nilakus = int.parse(value);
                                          if (value.length == 2) {
                                            mappingPenilaianEkstraModel.books
                                                .removeWhere((element) =>
                                                    element.studentId ==
                                                    penilaianEkstrStudentModel
                                                        .studentId);
                                            mappingPenilaianEkstraModel.books
                                                .add(
                                              BookEkstra(
                                                nilai: int.parse(
                                                  nilai.toString(),
                                                ),
                                                studentId:
                                                    penilaianEkstrStudentModel
                                                        .studentId,
                                                semesterId: int.parse(
                                                    widget.idSemester),
                                                academicYearId: int.parse(
                                                    widget.idAkademik),
                                                extracurricularId:
                                                    widget.idEkstraPembina,
                                              ),
                                            );
                                            // FocusScope.of(context).nextFocus();
                                          }
                                          if (value.length == 3) {
                                            if (int.parse(nilai) > 100) {
                                              mappingPenilaianEkstraModel.books
                                                  .removeWhere((element) =>
                                                      element.studentId ==
                                                      penilaianEkstrStudentModel
                                                          .studentId);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'Nilai yang dimasukkan tidak boleh lebih dari 100')));
                                            } else if (int.parse(nilai) < 0) {
                                              print('kekurangan');
                                              mappingPenilaianEkstraModel.books
                                                  .removeWhere((element) =>
                                                      element.studentId ==
                                                      penilaianEkstrStudentModel
                                                          .studentId);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'Nilai yang dimasukkan tidak boleh kurang dari 0')));
                                            } else {
                                              mappingPenilaianEkstraModel.books
                                                  .removeWhere((element) =>
                                                      element.studentId ==
                                                      penilaianEkstrStudentModel
                                                          .studentId);
                                              mappingPenilaianEkstraModel.books
                                                  .add(
                                                BookEkstra(
                                                  nilai: int.parse(
                                                    nilai.toString(),
                                                  ),
                                                  studentId:
                                                      penilaianEkstrStudentModel
                                                          .studentId,
                                                  semesterId: int.parse(
                                                      widget.idSemester),
                                                  academicYearId: int.parse(
                                                      widget.idAkademik),
                                                  extracurricularId:
                                                      widget.idEkstraPembina,
                                                ),
                                              );
                                            }
                                            FocusScope.of(context).nextFocus();
                                          }
                                          if (nilai == '') {
                                            mappingPenilaianEkstraModel.books
                                                .removeWhere((element) =>
                                                    element.studentId ==
                                                    penilaianEkstrStudentModel
                                                        .studentId);
                                          }
                                        },
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(4),
                                        ],
                                      ),
                                    ),
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
            GestureDetector(
              onTap: () {
                if (lenghtStudent == mappingPenilaianEkstraModel.books.length) {
                  send();
                } else if (mappingPenilaianEkstraModel.books.length <
                    lenghtStudent) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Ada nilai yang masih kosong')));
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
                    "Simpan",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        letterSpacing: 1),
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

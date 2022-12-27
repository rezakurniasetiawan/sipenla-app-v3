import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:siakad_app/services/penilaian_service.dart';

class EditPenilaian extends StatefulWidget {
  const EditPenilaian(
      {Key? key,
      required this.idClass,
      required this.idJenpen,
      required this.idMapel,
      required this.idSemester,
      required this.nilai,
      required this.nisn,
      required this.idPenilaian})
      : super(key: key);

  final String idClass, idJenpen, idMapel, idSemester, nisn, nilai, idPenilaian;
  @override
  State<EditPenilaian> createState() => _EditPenilaianState();
}

class _EditPenilaianState extends State<EditPenilaian> {
  TextEditingController nilai = TextEditingController();
  String semester = '';
  String kelas = '';
  String mapel = '';
  String penilaian = '';

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

  void fungsiUpdateNilai(String idPen) async {
    print("Halo");
    showAlertDialog(context);
    ApiResponse response =
        await updateNilaiSiswa(penilaianId: idPen, nilai: nilai.text);
    if (response.error == null) {
      Navigator.pop(context);
      // ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(content: Text('Berhasil Merubah Fasilitas')));
      setState(() {
        Navigator.pop(context, 'refresh');
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
                                  child: Image.asset(
                                      'assets/icons/icon-close.png'),
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
          .showSnackBar(const SnackBar(content: Text('Ada Kesalahan')));
      Navigator.pop(context);
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
    nilai.text = widget.nilai;
    getMapel();
    getKelas();
    getSemester();
    getPenilaian();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Nilai Pembelajaran",
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
          padding: const EdgeInsets.all(15.0),
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
                          'NIlai',
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
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          width: 1.0,
                          color: Color(0xff4B556B),
                        ),
                        left: BorderSide(
                          width: 1.0,
                          color: Color(0xff4B556B),
                        ),
                        right: BorderSide(
                          width: 1.0,
                          color: Color(0xff4B556B),
                        ),
                      )),
                      height: 60,
                      child: Center(
                        child: Text(
                          widget.nisn,
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
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          width: 1.0,
                          color: Color(0xff4B556B),
                        ),
                      )),
                      height: 60,
                      child: Center(
                        child: Text(
                          widget.nisn,
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
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1.0,
                            color: Color(0xff4B556B),
                          ),
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
                        child: TextFormField(
                          controller: nilai,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(3),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  fungsiUpdateNilai(widget.idPenilaian);
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
      ),
    );
  }
}

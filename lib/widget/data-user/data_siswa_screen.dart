import 'package:flutter/material.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/data_user_model.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:siakad_app/services/data_user_services.dart';
import 'package:siakad_app/widget/data-user/data_siswa_byId.dart';
import 'package:siakad_app/widget/data-user/list_week_statistik_siswa.dart';
import 'package:siakad_app/widget/data-user/rapor_siswa_byId.dart';

import '../../constan.dart';
import '../text_paragraf.dart';

class DataSiswaScreen extends StatefulWidget {
  const DataSiswaScreen({Key? key, required this.role}) : super(key: key);

  final String role;

  @override
  State<DataSiswaScreen> createState() => _DataSiswaScreenState();
}

class _DataSiswaScreenState extends State<DataSiswaScreen> {
  TextEditingController pencarian = TextEditingController();

  bool _loading = true;
  List<dynamic> _dataUserList = [];

  Future<void> fungsiGetDataSiswa() async {
    ApiResponse response = await getDataSiswa();
    if (response.error == null) {
      setState(() {
        _dataUserList = response.data as List<dynamic>;
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

  Future<void> fungsiGetDataSiswaFilter() async {
    ApiResponse response = await getDataSiswaFilter(value: pencarian.text);
    if (response.error == null) {
      setState(() {
        _dataUserList = response.data as List<dynamic>;
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

  @override
  void initState() {
    super.initState();
    fungsiGetDataSiswa();
  }

  @override
  void dispose() {
    super.dispose();
    pencarian.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Data Siswa",
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
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TextField(
                  controller: pencarian,
                  textInputAction: TextInputAction.go,
                  onSubmitted: (value) {
                    fungsiGetDataSiswaFilter();
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Pencarian berdasarkan Nama/NISN',
                    suffixIcon: Icon(Icons.search),
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
                      itemCount: _dataUserList.length,
                      itemBuilder: (BuildContext context, int index) {
                        DataSiswaModel dataSiswaModel = _dataUserList[index];
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
                                      title: 'Nama',
                                      value: dataSiswaModel.firstName +
                                          ' ' +
                                          dataSiswaModel.lastName,
                                    ),
                                    TextParagraf(
                                        title: 'NISN',
                                        value: dataSiswaModel.nisn),
                                    TextParagraf(
                                        title: 'Email',
                                        value: dataSiswaModel.email),
                                    TextParagraf(
                                        title: 'Jabatan',
                                        value: dataSiswaModel.role == 'student'
                                            ? 'Siswa'
                                            : ''),
                                    widget.role == 'tu'
                                        ? Column(
                                            children: [
                                              Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 130,
                                                    child: Text(
                                                      'Absensi',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily: 'Poppins',
                                                        color:
                                                            Color(0xff4B556B),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                    child: Text(
                                                      ": ",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily: 'Poppins',
                                                        color:
                                                            Color(0xff4B556B),
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ListWeekStatistikSiswa(
                                                                    idStudent: dataSiswaModel
                                                                        .studentId
                                                                        .toString(),
                                                                  )));
                                                    },
                                                    child: Container(
                                                      width: 96,
                                                      height: 27,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        gradient:
                                                            const LinearGradient(
                                                          begin:
                                                              FractionalOffset
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
                                                        "Lihat",
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.white,
                                                            letterSpacing: 1),
                                                      )),
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
                                                    width: 130,
                                                    child: Text(
                                                      'Folmulir Data',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily: 'Poppins',
                                                        color:
                                                            Color(0xff4B556B),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                    child: Text(
                                                      ": ",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily: 'Poppins',
                                                        color:
                                                            Color(0xff4B556B),
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  DataSiswabyId(
                                                                    idStudent: dataSiswaModel
                                                                        .studentId
                                                                        .toString(),
                                                                  )));
                                                    },
                                                    child: Container(
                                                      width: 96,
                                                      height: 27,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        gradient:
                                                            const LinearGradient(
                                                          begin:
                                                              FractionalOffset
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
                                                        "Lihat",
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.white,
                                                            letterSpacing: 1),
                                                      )),
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
                                                    width: 130,
                                                    child: Text(
                                                      'Rapor',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily: 'Poppins',
                                                        color:
                                                            Color(0xff4B556B),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                    child: Text(
                                                      ": ",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily: 'Poppins',
                                                        color:
                                                            Color(0xff4B556B),
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  RaporSiswabyId(
                                                                    idStudent: dataSiswaModel
                                                                        .studentId
                                                                        .toString(),
                                                                  )));
                                                    },
                                                    child: Container(
                                                      width: 96,
                                                      height: 27,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        gradient:
                                                            const LinearGradient(
                                                          begin:
                                                              FractionalOffset
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
                                                        "Lihat",
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.white,
                                                            letterSpacing: 1),
                                                      )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        : widget.role == 'kepsek'
                                            ? Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      const SizedBox(
                                                        width: 130,
                                                        child: Text(
                                                          'Absensi',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Color(
                                                                0xff4B556B),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                        child: Text(
                                                          ": ",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Color(
                                                                0xff4B556B),
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          ListWeekStatistikSiswa(
                                                                            idStudent:
                                                                                dataSiswaModel.studentId.toString(),
                                                                          )));
                                                        },
                                                        child: Container(
                                                          width: 96,
                                                          height: 27,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            gradient:
                                                                const LinearGradient(
                                                              begin:
                                                                  FractionalOffset
                                                                      .centerLeft,
                                                              end: FractionalOffset
                                                                  .centerRight,
                                                              colors: [
                                                                Color(
                                                                    0xff2E447C),
                                                                Color(
                                                                    0xff3774C3),
                                                              ],
                                                            ),
                                                          ),
                                                          child: const Center(
                                                              child: Text(
                                                            "Lihat",
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Colors
                                                                    .white,
                                                                letterSpacing:
                                                                    1),
                                                          )),
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
                                                        width: 130,
                                                        child: Text(
                                                          'Folmulir Data',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Color(
                                                                0xff4B556B),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                        child: Text(
                                                          ": ",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Color(
                                                                0xff4B556B),
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          DataSiswabyId(
                                                                            idStudent:
                                                                                dataSiswaModel.studentId.toString(),
                                                                          )));
                                                        },
                                                        child: Container(
                                                          width: 96,
                                                          height: 27,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            gradient:
                                                                const LinearGradient(
                                                              begin:
                                                                  FractionalOffset
                                                                      .centerLeft,
                                                              end: FractionalOffset
                                                                  .centerRight,
                                                              colors: [
                                                                Color(
                                                                    0xff2E447C),
                                                                Color(
                                                                    0xff3774C3),
                                                              ],
                                                            ),
                                                          ),
                                                          child: const Center(
                                                              child: Text(
                                                            "Lihat",
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Colors
                                                                    .white,
                                                                letterSpacing:
                                                                    1),
                                                          )),
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
                                                        width: 130,
                                                        child: Text(
                                                          'Rapor',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Color(
                                                                0xff4B556B),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                        child: Text(
                                                          ": ",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Color(
                                                                0xff4B556B),
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          RaporSiswabyId(
                                                                            idStudent:
                                                                                dataSiswaModel.studentId.toString(),
                                                                          )));
                                                        },
                                                        child: Container(
                                                          width: 96,
                                                          height: 27,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            gradient:
                                                                const LinearGradient(
                                                              begin:
                                                                  FractionalOffset
                                                                      .centerLeft,
                                                              end: FractionalOffset
                                                                  .centerRight,
                                                              colors: [
                                                                Color(
                                                                    0xff2E447C),
                                                                Color(
                                                                    0xff3774C3),
                                                              ],
                                                            ),
                                                          ),
                                                          child: const Center(
                                                              child: Text(
                                                            "Lihat",
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Colors
                                                                    .white,
                                                                letterSpacing:
                                                                    1),
                                                          )),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            : widget.role == 'dinaspendidikan'
                                                ? Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const SizedBox(
                                                            width: 130,
                                                            child: Text(
                                                              'Absensi',
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Color(
                                                                    0xff4B556B),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                            child: Text(
                                                              ": ",
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Color(
                                                                    0xff4B556B),
                                                              ),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          ListWeekStatistikSiswa(
                                                                            idStudent:
                                                                                dataSiswaModel.studentId.toString(),
                                                                          )));
                                                            },
                                                            child: Container(
                                                              width: 96,
                                                              height: 27,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                                gradient:
                                                                    const LinearGradient(
                                                                  begin: FractionalOffset
                                                                      .centerLeft,
                                                                  end: FractionalOffset
                                                                      .centerRight,
                                                                  colors: [
                                                                    Color(
                                                                        0xff2E447C),
                                                                    Color(
                                                                        0xff3774C3),
                                                                  ],
                                                                ),
                                                              ),
                                                              child:
                                                                  const Center(
                                                                      child:
                                                                          Text(
                                                                "Lihat",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    color: Colors
                                                                        .white,
                                                                    letterSpacing:
                                                                        1),
                                                              )),
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
                                                            width: 130,
                                                            child: Text(
                                                              'Folmulir Data',
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Color(
                                                                    0xff4B556B),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                            child: Text(
                                                              ": ",
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Color(
                                                                    0xff4B556B),
                                                              ),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          DataSiswabyId(
                                                                            idStudent:
                                                                                dataSiswaModel.studentId.toString(),
                                                                          )));
                                                            },
                                                            child: Container(
                                                              width: 96,
                                                              height: 27,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                                gradient:
                                                                    const LinearGradient(
                                                                  begin: FractionalOffset
                                                                      .centerLeft,
                                                                  end: FractionalOffset
                                                                      .centerRight,
                                                                  colors: [
                                                                    Color(
                                                                        0xff2E447C),
                                                                    Color(
                                                                        0xff3774C3),
                                                                  ],
                                                                ),
                                                              ),
                                                              child:
                                                                  const Center(
                                                                      child:
                                                                          Text(
                                                                "Lihat",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    color: Colors
                                                                        .white,
                                                                    letterSpacing:
                                                                        1),
                                                              )),
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
                                                            width: 130,
                                                            child: Text(
                                                              'Rapor',
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Color(
                                                                    0xff4B556B),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                            child: Text(
                                                              ": ",
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Color(
                                                                    0xff4B556B),
                                                              ),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          RaporSiswabyId(
                                                                            idStudent:
                                                                                dataSiswaModel.studentId.toString(),
                                                                          )));
                                                            },
                                                            child: Container(
                                                              width: 96,
                                                              height: 27,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                                gradient:
                                                                    const LinearGradient(
                                                                  begin: FractionalOffset
                                                                      .centerLeft,
                                                                  end: FractionalOffset
                                                                      .centerRight,
                                                                  colors: [
                                                                    Color(
                                                                        0xff2E447C),
                                                                    Color(
                                                                        0xff3774C3),
                                                                  ],
                                                                ),
                                                              ),
                                                              child:
                                                                  const Center(
                                                                      child:
                                                                          Text(
                                                                "Lihat",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    color: Colors
                                                                        .white,
                                                                    letterSpacing:
                                                                        1),
                                                              )),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                : const SizedBox()
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

import 'package:flutter/material.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/data_user_model.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:siakad_app/services/data_user_services.dart';

import '../../constan.dart';
import '../text_paragraf.dart';
import 'data-pegawai_byId.dart';
import 'list_week_statistik_pegawai.dart';

class DataPegawaiScreen extends StatefulWidget {
  const DataPegawaiScreen({Key? key, required this.role}) : super(key: key);

  final String role;

  @override
  State<DataPegawaiScreen> createState() => _DataPegawaiScreenState();
}

class _DataPegawaiScreenState extends State<DataPegawaiScreen> {
  TextEditingController pencarian = TextEditingController();

  bool _loading = true;
  List<dynamic> _dataUserList = [];

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

  Future<void> fungsiGetDataPegawai() async {
    ApiResponse response = await getDataPegawai();
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

  Future<void> fungsiGetDataPegawaiFilter() async {
    showAlertDialog(context);
    ApiResponse response = await getDataPegawaiFilter(value: pencarian.text);
    if (response.error == null) {
      setState(() {
        _dataUserList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
        Navigator.pop(context);
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
    fungsiGetDataPegawai();
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
          "Data Pegawai",
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
                    if (value.isEmpty) {
                      fungsiGetDataPegawai();
                    } else {
                      fungsiGetDataPegawaiFilter();
                    }
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Pencarian berdasarkan Nama/NUPTK',
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
                        DataPegawaiModel dataPegawaiModel =
                            _dataUserList[index];
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
                                      value: dataPegawaiModel.firstName +
                                          ' ' +
                                          dataPegawaiModel.lastName,
                                    ),
                                    TextParagraf(
                                      title: 'NUPTK',
                                      value: dataPegawaiModel.nuptk,
                                    ),
                                    TextParagraf(
                                      title: 'Email',
                                      value: dataPegawaiModel.email,
                                    ),
                                    TextParagraf(
                                      title: 'Jabatan',
                                      value: dataPegawaiModel.role == 'admin'
                                          ? "Administrator"
                                          : dataPegawaiModel.role == 'student'
                                              ? 'Siswa'
                                              : dataPegawaiModel.role ==
                                                      'kepsek'
                                                  ? 'Kepala Sekolah'
                                                  : dataPegawaiModel.role ==
                                                          'guru'
                                                      ? 'Guru'
                                                      : dataPegawaiModel.role ==
                                                              'tu'
                                                          ? 'Pegawai TU'
                                                          : dataPegawaiModel
                                                                      .role ==
                                                                  'walimurid'
                                                              ? 'Wali Murid'
                                                              : dataPegawaiModel
                                                                          .role ==
                                                                      'pengawassekolah'
                                                                  ? 'Pengawas Sekolah'
                                                                  : dataPegawaiModel
                                                                              .role ==
                                                                          'perpus'
                                                                      ? 'Pegawai Perpustakaan'
                                                                      : dataPegawaiModel.role ==
                                                                              'pegawaikoperasi'
                                                                          ? 'Pegawai Koperasi'
                                                                          : dataPegawaiModel.role == 'pegawaikantin'
                                                                              ? 'Pegawai Kantin'
                                                                              : dataPegawaiModel.role == 'pembinaextra'
                                                                                  ? 'Pembina Ekstra'
                                                                                  : 'Dinas Pendidikan',
                                    ),
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
                                                                  ListWeekStatistikPegawai(
                                                                    idEmployee: dataPegawaiModel
                                                                        .employeeId
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
                                                                  DataPegawaibyId(
                                                                    idEmployee: dataPegawaiModel
                                                                        .employeeId
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
                                                                          ListWeekStatistikPegawai(
                                                                            idEmployee:
                                                                                dataPegawaiModel.employeeId.toString(),
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
                                                                          DataPegawaibyId(
                                                                            idEmployee:
                                                                                dataPegawaiModel.employeeId.toString(),
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
                                                                          ListWeekStatistikPegawai(
                                                                            idEmployee:
                                                                                dataPegawaiModel.employeeId.toString(),
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
                                                                          DataPegawaibyId(
                                                                            idEmployee:
                                                                                dataPegawaiModel.employeeId.toString(),
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

import 'package:flutter/material.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/rapor_model.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:siakad_app/services/rapor_service.dart';

import '../../../constan.dart';
import '../../text_paragraf.dart';

class RiwayatKepsek extends StatefulWidget {
  const RiwayatKepsek({Key? key}) : super(key: key);

  @override
  State<RiwayatKepsek> createState() => _RiwayatKepsekState();
}

class _RiwayatKepsekState extends State<RiwayatKepsek> {
  List<dynamic> _listRiwayat = [];
  bool _loading = true;

  Future<void> fungsiGetRiwayatRaporKepsek() async {
    ApiResponse response = await getRiwayatRaporKepsek();
    if (response.error == null) {
      setState(() {
        _listRiwayat = response.data as List<dynamic>;
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
    fungsiGetRiwayatRaporKepsek();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Riwayat Rapor",
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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
            itemCount: _listRiwayat.length,
            itemBuilder: (BuildContext context, int index) {
              RiwayatKepsekModel riwayatKepsekModel = _listRiwayat[index];

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
                              value: riwayatKepsekModel.gradeName),
                          TextParagraf(
                              title: 'Semester',
                              value: riwayatKepsekModel.semesterName),
                          TextParagraf(
                              title: 'Tahun Ajaran',
                              value: riwayatKepsekModel.academicYear),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Text(
                                "Sudah Terkonfirmasi",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff83BC10),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}

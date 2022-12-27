import 'package:flutter/material.dart';
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/fasilitas_model.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:siakad_app/services/fasilitas_service.dart';

class RiwayatPegawaiFasilitas extends StatefulWidget {
  const RiwayatPegawaiFasilitas({Key? key}) : super(key: key);

  @override
  State<RiwayatPegawaiFasilitas> createState() =>
      _RiwayatPegawaiFasilitasState();
}

class _RiwayatPegawaiFasilitasState extends State<RiwayatPegawaiFasilitas> {
  bool _loading = true;
  List<dynamic> _RiwayatList = [];

  Future<void> fungsiGetRiwayat() async {
    ApiResponse response = await getRiwayatPegawaiFasilitas();
    if (response.error == null) {
      print('halo');
      setState(() {
        _RiwayatList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => GetStartedScreen()),
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
    fungsiGetRiwayat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Riwayat Fasilitas",
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
        body: _loading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.blueAccent,
                ),
              )
            : ListView.builder(
                itemCount: _RiwayatList.length,
                itemBuilder: (BuildContext context, int index) {
                  RiwayatSiswaFasilitasModel riwayatSiswaFasilitasModel =
                      _RiwayatList[index];
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 130,
                              child: Text(
                                "Kode Fasilitas",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                  color: Color(0xff2E447C),
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
                                  color: Color(0xff2E447C),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                riwayatSiswaFasilitasModel.facilityCode,
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
                                "Nama Fasilitas",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                  color: Color(0xff2E447C),
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
                                  color: Color(0xff2E447C),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                riwayatSiswaFasilitasModel.facilityName,
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
                                "Jumlah",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                  color: Color(0xff2E447C),
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
                                  color: Color(0xff2E447C),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                riwayatSiswaFasilitasModel.totalFacility,
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
                                "Status",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                  color: Color(0xff2E447C),
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
                                  color: Color(0xff2E447C),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                riwayatSiswaFasilitasModel.status,
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
                                "Tanggal",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                  color: Color(0xff2E447C),
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
                                  color: Color(0xff2E447C),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                riwayatSiswaFasilitasModel.date,
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
                          height: 15,
                        ),
                        Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width,
                          color: Color(0xff2E447C),
                        )
                      ],
                    ),
                  );
                }),
                );
  }
}

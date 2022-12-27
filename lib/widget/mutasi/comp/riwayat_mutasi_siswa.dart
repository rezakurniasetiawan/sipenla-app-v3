import 'package:flutter/material.dart';
import 'package:siakad_app/widget/mutasi/comp/detail_riwayat_mutasi_siswa.dart';

import '../../../constan.dart';
import '../../../models/api_response_model.dart';
import '../../../models/mutasi_model.dart';
import '../../../screens/started_screen.dart';
import '../../../services/auth_service.dart';
import '../../../services/mutasi_services.dart';

class RiwayatMutasiSiswa extends StatefulWidget {
  const RiwayatMutasiSiswa({Key? key, required this.role}) : super(key: key);

  final String role;

  @override
  State<RiwayatMutasiSiswa> createState() => _RiwayatMutasiSiswaState();
}

class _RiwayatMutasiSiswaState extends State<RiwayatMutasiSiswa> {
  bool _loading = true;
  List<dynamic> _riwayatMutasiSiswa = [];

  Future<void> fungsiGetRiwayatMutasiSiswa() async {
    ApiResponse response = await getRiwayatMutasiSiswa();
    if (response.error == null) {
      setState(() {
        _riwayatMutasiSiswa = response.data as List<dynamic>;
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

  Future<void> fungsiGetRiwayatMutasiWalmur() async {
    ApiResponse response = await getRiwayatMutasiWalmur();
    if (response.error == null) {
      setState(() {
        _riwayatMutasiSiswa = response.data as List<dynamic>;
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
    if (widget.role == 'student') {
      fungsiGetRiwayatMutasiSiswa();
    } else {
      fungsiGetRiwayatMutasiWalmur();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Riwayat Mutasi",
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
        child: Column(
          children: [
            const Text(
              'Riwayat',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins',
                color: Color(0xff4B556B),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _riwayatMutasiSiswa.length,
                itemBuilder: (BuildContext context, int index) {
                  RiwayatMutasiSiswaModel riwayatMutasiSiswaModel =
                      _riwayatMutasiSiswa[index];
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xff4B556B),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              const Text(
                                'Pengajuan Mutasi',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                  color: Color(0xff4B556B),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextParagrafMutasi(
                                title: 'Tanggal',
                                value: riwayatMutasiSiswaModel.tanggal,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    width: 130,
                                    child: Text(
                                      'Status',
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
                                      child: riwayatMutasiSiswaModel.status ==
                                              'pending'
                                          ? const Text(
                                              'Belum DiKonfirmasi',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Poppins',
                                                letterSpacing: 1,
                                                color: Color(0xffFFB711),
                                              ),
                                            )
                                          : riwayatMutasiSiswaModel.status ==
                                                  'konfirmasi'
                                              ? const Text(
                                                  'Telah DiKonfirmasi',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Poppins',
                                                    letterSpacing: 1,
                                                    color: Color(0xff83BC10),
                                                  ),
                                                )
                                              : const Text(
                                                  'Tidak DiKonfirmasi',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Poppins',
                                                    letterSpacing: 1,
                                                    color: Color(0xffFF4238),
                                                  ),
                                                )),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailRiwayatMutasiSiswa(
                                                    riwayatMutasiSiswaModel:
                                                        riwayatMutasiSiswaModel,
                                                  )));
                                    },
                                    child: const SizedBox(
                                      height: 40,
                                      width: 50,
                                      child: Center(
                                        child: Text(
                                          'Detail',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Poppins',
                                            color: Color(0xff3774C3),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextParagrafMutasi extends StatelessWidget {
  const TextParagrafMutasi({Key? key, required this.title, required this.value})
      : super(key: key);

  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 130,
              child: Text(
                title,
                style: const TextStyle(
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
                value,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                  color: Color(0xff4B556B),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}

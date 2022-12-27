import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/fasilitas_model.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:siakad_app/services/fasilitas_service.dart';
import 'package:siakad_app/widget/fasilitas/comp/detail_pengembalian_fasilitas.dart';

class PengembalianFasilitas extends StatefulWidget {
  const PengembalianFasilitas({Key? key}) : super(key: key);

  @override
  State<PengembalianFasilitas> createState() => _PengembalianFasilitasState();
}

class _PengembalianFasilitasState extends State<PengembalianFasilitas> {
  bool _loading = true;
  List<dynamic> _PengembalianList = [];
  String roles = '';

  void fungsiGetpengembalianSiswa() async {
    print('get ini');
    ApiResponse response = await getPengembalianSiswaFasilitas();
    if (response.error == null) {
      setState(() {
        _PengembalianList = response.data as List<dynamic>;
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

  void fungsiGetpengembalianPegawai() async {
    ApiResponse response = await getPengembalianPegawaiFasilitas();
    if (response.error == null) {
      setState(() {
        _PengembalianList = response.data as List<dynamic>;
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

  checkUser() async {
    String role = await getrole();
    roles = role;
    if (role == 'student') {
      fungsiGetpengembalianSiswa();
    } else {
      fungsiGetpengembalianPegawai();
    }
  }

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Pengembalian Fasilitas",
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
          : roles == 'student'
              ? ListView.builder(
                  itemCount: _PengembalianList.length,
                  itemBuilder: (BuildContext context, int index) {
                    PengembalianFasilitasSiswaModel
                        pengembalianFasilitasSiswaModel =
                        _PengembalianList[index];
                    String tanggalawal = DateFormat('dd MMMM yyyy')
                        .format(pengembalianFasilitasSiswaModel.fromDate);
                    String tanggalakhir = DateFormat('dd MMMM yyyy')
                        .format(pengembalianFasilitasSiswaModel.toDate);
                    return Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 120,
                                child: Text(
                                  'Kode Fasilitas',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff4B556B),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const Text(
                                ': ',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff4B556B),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                // pengembalianFasilitasModel.facilityCode,
                                tanggalawal,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff4B556B),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
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
                                width: 120,
                                child: Text(
                                  'Nama Fasilitas',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff4B556B),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const Text(
                                ': ',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff4B556B),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                pengembalianFasilitasSiswaModel.facilityName,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff4B556B),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
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
                                width: 120,
                                child: Text(
                                  'Jumlah',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff4B556B),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const Text(
                                ': ',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff4B556B),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                pengembalianFasilitasSiswaModel.totalFacility,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff4B556B),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () async {
                              String refresh = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailPengembalianFasilitas(
                                            tanggalakhir: tanggalakhir,
                                            tanggalawal: tanggalawal,
                                            idLoad:
                                                pengembalianFasilitasSiswaModel
                                                    .loanFacilityId,
                                            imageFas:
                                                pengembalianFasilitasSiswaModel
                                                    .image,
                                            jumlahFas:
                                                pengembalianFasilitasSiswaModel
                                                    .numberOfFacility,
                                            kodeFas:
                                                pengembalianFasilitasSiswaModel
                                                    .facilityCode,
                                            nameFas:
                                                pengembalianFasilitasSiswaModel
                                                    .facilityName,
                                          )));

                              if (refresh == 'refresh') {
                                checkUser();
                              }
                            },
                            child: Center(
                              child: Container(
                                width: 100,
                                height: 27,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
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
                                  "Lihat",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                  ),
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              : ListView.builder(
                  itemCount: _PengembalianList.length,
                  itemBuilder: (BuildContext context, int index) {
                    PengembalianFasilitasPegawaiModel
                        pengembalianFasilitasPegawaiModel =
                        _PengembalianList[index];
                    String tanggalawal = DateFormat('dd MMMM yyyy')
                        .format(pengembalianFasilitasPegawaiModel.fromDate);
                    String tanggalakhir = DateFormat('dd MMMM yyyy')
                        .format(pengembalianFasilitasPegawaiModel.toDate);
                    return Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 120,
                                child: Text(
                                  'Kode Fasilitas',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff4B556B),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const Text(
                                ': ',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff4B556B),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                // pengembalianFasilitasModel.facilityCode,
                                tanggalawal,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff4B556B),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
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
                                width: 120,
                                child: Text(
                                  'Nama Fasilitas',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff4B556B),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const Text(
                                ': ',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff4B556B),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                pengembalianFasilitasPegawaiModel.facilityName,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff4B556B),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
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
                                width: 120,
                                child: Text(
                                  'Jumlah',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff4B556B),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const Text(
                                ': ',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff4B556B),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                pengembalianFasilitasPegawaiModel.totalFacility,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff4B556B),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () async {
                              String refresh = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailPengembalianFasilitas(
                                            tanggalakhir: tanggalakhir,
                                            tanggalawal: tanggalawal,
                                            idLoad:
                                                pengembalianFasilitasPegawaiModel
                                                    .loanFacilityId,
                                            imageFas:
                                                pengembalianFasilitasPegawaiModel
                                                    .image,
                                            jumlahFas:
                                                pengembalianFasilitasPegawaiModel
                                                    .numberOfFacility,
                                            kodeFas:
                                                pengembalianFasilitasPegawaiModel
                                                    .facilityCode,
                                            nameFas:
                                                pengembalianFasilitasPegawaiModel
                                                    .facilityName,
                                          )));

                              if (refresh == 'refresh') {
                                setState(() {});
                              }
                            },
                            child: Center(
                              child: Container(
                                width: 100,
                                height: 27,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
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
                                  "Lihat",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                  ),
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}

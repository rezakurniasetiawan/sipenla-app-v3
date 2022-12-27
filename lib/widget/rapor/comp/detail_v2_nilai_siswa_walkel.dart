import 'package:flutter/material.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/rapor_model.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:siakad_app/services/rapor_service.dart';

import '../../../constan.dart';

class DetailV2NilaiSiswaWalkel extends StatefulWidget {
  const DetailV2NilaiSiswaWalkel(
      {Key? key,
      required this.idAkademik,
      required this.idGrade,
      required this.idMapel,
      required this.idSemester,
      required this.idStudent})
      : super(key: key);

  final String idAkademik, idGrade, idMapel, idSemester, idStudent;

  @override
  State<DetailV2NilaiSiswaWalkel> createState() =>
      _DetailV2NilaiSiswaWalkelState();
}

class _DetailV2NilaiSiswaWalkelState extends State<DetailV2NilaiSiswaWalkel> {
  bool loading = true;
  DetailNilaiSiswaModel? detailNilaiSiswaModel;

  int fixNilai = 0;

  fungsiGetDetailNilaiSiswa() async {
    ApiResponse response = await getDetailNilaiSiswa(
        idAkademik: widget.idAkademik,
        idGrade: widget.idGrade,
        idMapel: widget.idMapel,
        idSemester: widget.idSemester,
        idStudent: widget.idStudent);
    if (response.error == null) {
      setState(() {
        detailNilaiSiswaModel = response.data as DetailNilaiSiswaModel;
        fixNilai = detailNilaiSiswaModel!.nilaiFix.ceil();
        loading = false;
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
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  @override
  void initState() {
    super.initState();
    fungsiGetDetailNilaiSiswa();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Data Pembelajaran",
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
        child: loading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.blueAccent,
                ),
              )
            : Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xff4B556B),
                        ),
                        borderRadius: BorderRadius.circular(14)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          ItemRiwayatPenilaian(
                              title: 'Mata Pelajaran',
                              value: detailNilaiSiswaModel!.mapel),
                          ItemRiwayatPenilaian(
                              title: 'Tugas 1',
                              value: detailNilaiSiswaModel!.nilaiTugas1
                                  .toString()),
                          ItemRiwayatPenilaian(
                              title: 'Tugas 2',
                              value: detailNilaiSiswaModel!.nilaiTugas2
                                  .toString()),
                          ItemRiwayatPenilaian(
                              title: 'Tugas 3',
                              value: detailNilaiSiswaModel!.nilaiTugas3
                                  .toString()),
                          ItemRiwayatPenilaian(
                              title: 'Tugas 4',
                              value: detailNilaiSiswaModel!.nilaiTugas4
                                  .toString()),
                          ItemRiwayatPenilaian(
                              title: 'UH 1',
                              value:
                                  detailNilaiSiswaModel!.nilaiUh1.toString()),
                          ItemRiwayatPenilaian(
                              title: 'UH 2',
                              value:
                                  detailNilaiSiswaModel!.nilaiUh2.toString()),
                          ItemRiwayatPenilaian(
                              title: 'UH 3',
                              value:
                                  detailNilaiSiswaModel!.nilaiUh3.toString()),
                          ItemRiwayatPenilaian(
                              title: 'UH 4',
                              value:
                                  detailNilaiSiswaModel!.nilaiUh4.toString()),
                          ItemRiwayatPenilaian(
                              title: 'UTS',
                              value:
                                  detailNilaiSiswaModel!.nilaiUts.toString()),
                          ItemRiwayatPenilaian(
                              title: 'UAS',
                              value:
                                  detailNilaiSiswaModel!.nilaiUas.toString()),
                          ItemRiwayatPenilaian(
                              title: 'Guru Mata Pelajaran',
                              value: detailNilaiSiswaModel!.firstName +
                                  ' ' +
                                  detailNilaiSiswaModel!.lastName),
                          ItemRiwayatPenilaian(
                              title: 'Total Nilai', value: fixNilai.toString()),
                        ],
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}

class ItemRiwayatPenilaian extends StatefulWidget {
  const ItemRiwayatPenilaian(
      {Key? key, required this.title, required this.value})
      : super(key: key);

  final String title, value;

  @override
  State<ItemRiwayatPenilaian> createState() => _ItemRiwayatPenilaianState();
}

class _ItemRiwayatPenilaianState extends State<ItemRiwayatPenilaian> {
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
                widget.title,
                style: const TextStyle(
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
                widget.value,
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
        )
      ],
    );
  }
}

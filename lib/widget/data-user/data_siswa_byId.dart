import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/student_model.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:siakad_app/services/data_user_services.dart';

import '../data_siswa.dart';

class DataSiswabyId extends StatefulWidget {
  const DataSiswabyId({Key? key, required this.idStudent}) : super(key: key);

  final String idStudent;

  @override
  State<DataSiswabyId> createState() => _DataSiswabyIdState();
}

class _DataSiswabyIdState extends State<DataSiswabyId> {
  StudentDataModel? studentDataModel;
  bool loading = true;

  void getUserData() async {
    ApiResponse response =
        await getDataStudentbyId(idStudent: widget.idStudent);
    if (response.error == null) {
      setState(() {
        studentDataModel = response.data as StudentDataModel;
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
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Data Penerimaan",
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
      body: loading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blueAccent,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 40,
                        child: Image.asset('assets/image/logo.png'),
                      ),
                      SizedBox(
                        height: 40,
                        child: Image.asset('assets/image/logo.png'),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                    child: Text(
                      "Folmulir",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff4B556B),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Center(
                    child: Text(
                      "DAFTAR ULANG PENERIMAAN SISWA BARU",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff4B556B),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.double,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Center(
                    child: Text(
                      "BIODATA PESERTA DIDIK",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff4B556B),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 42,
                  ),
                  ItemData(
                      title: '1. Nama Lengkap',
                      respons: studentDataModel!.firstName +
                          " " +
                          studentDataModel!.lastName),
                  // ItemData(
                  //   title: '2. NIK',
                  //   respons: studentDataModel!.nik,
                  // ),
                  ItemData(
                    title: '3. NISN',
                    respons: studentDataModel!.nisn,
                  ),
                  ItemData(
                      title: '4. Tempat, Tanggal Lahir',
                      respons: studentDataModel!.placeOfBirth +
                          " " +
                          studentDataModel!.dateOfBirth),
                  ItemData(
                    title: '5. Jenis Kelamin',
                    respons: studentDataModel!.gender,
                  ),
                  ItemData(
                    title: '6. Agama',
                    respons: studentDataModel!.religion,
                  ),
                  ItemData(
                    title: '7. Alamat Tinggal',
                    respons: studentDataModel!.address,
                  ),
                  ItemData(
                    title: '8. Asal Sekolah',
                    respons: studentDataModel!.schoolOrigin,
                  ),
                  const ItemData(
                    title: '9. Diterima di Sekolah ini',
                    respons: '',
                  ),
                  ItemDataMargin(
                    urut2: 'a. ',
                    title2: 'Kelas',
                    response2: studentDataModel!.schoolNow,
                  ),
                  ItemDataMargin(
                    urut2: 'b. ',
                    title2: 'Tanggal \n Penerimaan',
                    response2: studentDataModel!.dateSchoolNow,
                  ),
                  const ItemData(
                    title: '10. Nama Orang Tua',
                    respons: 'fds dsf sdf sd f fds sdf dsf  s',
                  ),
                  ItemDataMargin(
                    urut2: 'a. ',
                    title2: 'Ayah',
                    response2: studentDataModel!.fatherName,
                  ),
                  ItemDataMargin(
                    urut2: 'b. ',
                    title2: 'Ibu',
                    response2: studentDataModel!.motherName,
                  ),
                  ItemData(
                    title: '11. Alamat Orang Tua',
                    respons: studentDataModel!.parentAddress,
                  ),
                  const ItemData(
                    title: '12. Pekerjaan Orang Tua',
                    respons: '',
                  ),
                  ItemDataMargin(
                    urut2: 'a. ',
                    title2: 'Ayah',
                    response2: studentDataModel!.fatherProfession,
                  ),
                  ItemDataMargin(
                      urut2: 'b. ',
                      title2: 'Ibu',
                      response2: studentDataModel!.motherProfession),
                  const ItemData(
                    title: '13. Pendidikan Terakhir',
                    respons: '',
                  ),
                  ItemDataMargin(
                    urut2: 'a. ',
                    title2: 'Ayah',
                    response2: studentDataModel!.fatherEducation,
                  ),
                  ItemDataMargin(
                    urut2: 'b. ',
                    title2: 'Ibu',
                    response2: studentDataModel!.motherEducation,
                  ),
                  ItemData(
                    title: '14. Nama Wali',
                    respons: studentDataModel!.familyName,
                  ),
                  ItemDataMargin(
                    urut2: 'a. ',
                    title2: 'Alamat',
                    response2: studentDataModel!.familyAddress,
                  ),
                  ItemDataMargin(
                    urut2: 'b. ',
                    title2: 'Pekerjaan',
                    response2: studentDataModel!.familyProfession,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                '15. Foto',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff4B556B),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                ': ',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff4B556B),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      width: 140,
                                      height: 160,
                                      child: studentDataModel!.image != null
                                          ? CachedNetworkImage(
                                              imageUrl: studentDataModel!.image,
                                              fit: BoxFit.cover,
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                height: 100.0,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                              placeholder: (context, url) =>
                                                  Shimmer(
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.grey,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      gradient:
                                                          const LinearGradient(
                                                              stops: [
                                                            0.2,
                                                            0.5,
                                                            0.6
                                                          ],
                                                              colors: [
                                                            Colors.grey,
                                                            Colors.white12,
                                                            Colors.grey,
                                                          ])),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            )
                                          : Container(
                                              height: 160,
                                              width: 140,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: const DecorationImage(
                                                      image: AssetImage(
                                                          "assets/image/image-not-available.jpg"),
                                                      fit: BoxFit.cover)),
                                            )),
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
    );
  }
}

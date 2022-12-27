// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/employee_model.dart';
import 'package:siakad_app/models/guardian_model.dart';
import 'package:siakad_app/models/student_model.dart';
import 'package:siakad_app/screens/home/component/berita_sekolah.dart';
import 'package:siakad_app/screens/home/component/berita_sekolah_home.dart';
import 'package:siakad_app/screens/home/component/create_berita_sekolah.dart';

import 'package:siakad_app/screens/home/component/kategori/kategori_admin.dart';
import 'package:siakad_app/screens/home/component/kategori/kategori_dinpes.dart';
import 'package:siakad_app/screens/home/component/kategori/kategori_guru.dart';
import 'package:siakad_app/screens/home/component/kategori/kategori_kantin.dart';
import 'package:siakad_app/screens/home/component/kategori/kategori_kepsek.dart';
import 'package:siakad_app/screens/home/component/kategori/kategori_koperasi.dart';
import 'package:siakad_app/screens/home/component/kategori/kategori_pembina_ekstra.dart';
import 'package:siakad_app/screens/home/component/kategori/kategori_perpus.dart';
import 'package:siakad_app/screens/home/component/kategori/kategori_siswa.dart';
import 'package:siakad_app/screens/home/component/kategori/kategori_tu.dart';
import 'package:siakad_app/screens/home/component/kategori/kategori_walimurid.dart';
import 'package:siakad_app/screens/home/component/penerimaan_siswa.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? role, photoProfile;
  String rolesku = '';
  String firstName = '';
  String lastName = '';
  String gradeName = '';
  int idGrade = 0;
  int idEkstra = 0;
  int idEkstraPembina = 0;
  String ekstraNme = '';
  String imageTeacher = '';
  String isWali = '';
  String email = '';
  String nisnSiswa = '';
  String statusStudent = '';

  EmployeeModel? employeeModel;
  StudentModel? studentModel;
  GuardianModel? guardianModel;
  bool loading = true;
  String _debugLabelString = "";

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // String className = await getClassName();
    // int idClass = await getidClass();
    // int idEkstraku = await getidEkstra();
    setState(() {
      role = preferences.getString("role")!;
      firstName = preferences.getString("first_name") ?? '';
      email = preferences.getString("email") ?? '';
      lastName = preferences.getString("last_name") ?? '';
      photoProfile = preferences.getString("photoUser");
      gradeName = preferences.getString("gradeName") ?? '';
      idGrade = preferences.getInt("idGrade") ?? 0;
      idEkstra = preferences.getInt("idEkstra") ?? 0;
      idEkstraPembina = preferences.getInt("extracurricular_id") ?? 0;
      ekstraNme = preferences.getString("extracurricular") ?? '';
      nisnSiswa = preferences.getString("nisn") ?? '';
      statusStudent = preferences.getString("status_student") ?? '';
      // className = gradeName;
      // idClass = idGrade;
      // idEkstraku = idEkstra;
      print(statusStudent);

      if (email == '') return;

      OneSignal.shared.setExternalUserId(email).then((results) {
        if (results == null) return;

        this.setState(() {
          _debugLabelString = "External user id set: $results";
        });
      });
    });
  }

  //Get user detail
  void getUser() async {
    String roles = await getrole();

    setState(() {
      rolesku = roles;
    });
    ApiResponse response = await getUserDetail();
    if (response.error == null) {
      setState(() {
        print(roles);
        if (roles == 'student') {
          setState(() {
            studentModel = response.data as StudentModel;
            loading = false;
          });
        } else if (roles == 'walimurid') {
          setState(() {
            getGuardian();
          });
        } else {
          setState(() {
            employeeModel = response.data as EmployeeModel;
            imageTeacher = employeeModel?.image;
            isWali = employeeModel?.isWali ?? '';
            loading = false;
          });
        }
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const GetStartedScreen()),
                (route) => false)
          });
    } else {
      print('ada kesalahan gays');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  getGuardian() async {
    ApiResponse response = await getGuardianDetail();
    if (response.error == null) {
      setState(() {
        guardianModel = response.data as GuardianModel;
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
    getPref();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 180,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/image/header.png'))),
              child: Stack(
                children: [
                  Positioned(
                      bottom: 60,
                      left: 23,
                      child: role == null
                          ? Shimmer(
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                width: 150,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              gradient: const LinearGradient(stops: [
                                0.2,
                                0.5,
                                0.6
                              ], colors: [
                                Colors.grey,
                                Colors.white12,
                                Colors.grey,
                              ]))
                          : role == 'walimurid'
                              ? Text(
                                  "$firstName",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                    letterSpacing: 1,
                                  ),
                                )
                              : loading
                                  ? Shimmer(
                                      child: Container(
                                        width: 200,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      gradient: const LinearGradient(
                                        stops: [0.2, 0.5, 0.6],
                                        colors: [
                                          Colors.grey,
                                          Colors.white12,
                                          Colors.grey,
                                        ],
                                      ),
                                    )
                                  : rolesku == 'student'
                                      ? Text(
                                          studentModel!.studentFirstName +
                                              ' ' +
                                              studentModel!.studentLastName,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Poppins',
                                            letterSpacing: 1,
                                          ),
                                        )
                                      : rolesku == 'walimurid'
                                          ? Text(
                                              guardianModel!.fatherName,
                                              style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Poppins',
                                                letterSpacing: 1,
                                              ),
                                            )
                                          : Text(
                                              employeeModel!.firstName +
                                                  ' ' +
                                                  employeeModel!.lastName,
                                              style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Poppins',
                                                letterSpacing: 1,
                                              ),
                                            )),
                  Positioned(
                      bottom: 35,
                      left: 23,
                      child: loading
                          ? Shimmer(
                              child: Container(
                                width: 100,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              gradient: const LinearGradient(stops: [
                                0.2,
                                0.5,
                                0.6
                              ], colors: [
                                Colors.grey,
                                Colors.white12,
                                Colors.grey,
                              ]))
                          : Text(
                              role == 'admin'
                                  ? "Administrator"
                                  : role == 'student'
                                      ? 'Siswa'
                                      : role == 'kepsek'
                                          ? 'Kepala Sekolah'
                                          : role == 'guru'
                                              ? 'Guru'
                                              : role == 'tu'
                                                  ? 'Pegawai TU'
                                                  : role == 'walimurid'
                                                      ? 'Wali Murid'
                                                      : role ==
                                                              'pengawassekolah'
                                                          ? 'Pengawas Sekolah'
                                                          : role == 'perpus'
                                                              ? 'Pegawai Perpustakaan'
                                                              : role ==
                                                                      'pegawaikoperasi'
                                                                  ? 'Pegawai Koperasi'
                                                                  : role ==
                                                                          'pegawaikantin'
                                                                      ? 'Pegawai Kantin'
                                                                      : role ==
                                                                              'pembinaextra'
                                                                          ? 'Pembina Ekstra'
                                                                          : 'Dinas Pendidikan',
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1,
                                  fontFamily: 'Poppins'),
                            )),
                  Positioned(
                    bottom: 20,
                    right: 25,
                    child: SizedBox(
                      height: 75,
                      width: 75,
                      child: loading
                          ? Shimmer(
                              child: Container(
                                width: 75,
                                height: 75,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              gradient: const LinearGradient(
                                stops: [0.2, 0.5, 0.6],
                                colors: [
                                  Colors.grey,
                                  Colors.white12,
                                  Colors.grey,
                                ],
                              ),
                            )
                          : rolesku == 'student'
                              ? studentModel!.image != null
                                  ? CachedNetworkImage(
                                      imageUrl: studentModel!.image,
                                      fit: BoxFit.cover,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        width: 75.0,
                                        height: 75.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      placeholder: (context, url) => Shimmer(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                          ),
                                          gradient:
                                              const LinearGradient(stops: [
                                            0.2,
                                            0.5,
                                            0.6
                                          ], colors: [
                                            Colors.grey,
                                            Colors.white12,
                                            Colors.grey,
                                          ])),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    )
                                  : Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          image: const DecorationImage(
                                              image: AssetImage(
                                                  "assets/image/image-not-available.jpg"),
                                              fit: BoxFit.cover)),
                                    )
                              : rolesku == 'walimurid'
                                  ? guardianModel!.image != null
                                      ? CachedNetworkImage(
                                          imageUrl: guardianModel!.image,
                                          fit: BoxFit.cover,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            width: 75.0,
                                            height: 75.0,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              Shimmer(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
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
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        )
                                      : Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              image: const DecorationImage(
                                                  image: AssetImage(
                                                      "assets/image/image-not-available.jpg"),
                                                  fit: BoxFit.cover)),
                                        )
                                  : employeeModel!.image != null
                                      ? CachedNetworkImage(
                                          imageUrl: employeeModel!.image,
                                          fit: BoxFit.cover,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            width: 75.0,
                                            height: 75.0,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              Shimmer(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
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
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        )
                                      : Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              image: const DecorationImage(
                                                  image: AssetImage(
                                                      "assets/image/image-not-available.jpg"),
                                                  fit: BoxFit.cover)),
                                        ),
                    ),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Kategori",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                  fontFamily: 'Poppins',
                  color: Color(0xff4B556B),
                ),
              ),
            ),
            role == 'admin'
                ? KategoriAdmin(
                    role: rolesku,
                    className: gradeName,
                    idClass: idGrade,
                    idEkstra: idEkstra,
                  )
                : role == 'student'
                    ? KategoriSiswa(
                        role: rolesku,
                        className: gradeName,
                        idClass: idGrade,
                        idEkstra: idEkstra,
                        nameSiswa: firstName + ' ' + lastName,
                        nisnSIswa: nisnSiswa,
                        statusStudent: statusStudent,
                      )
                    : role == 'guru'
                        ? KategoriGuru(
                            role: rolesku,
                            className: gradeName,
                            idClass: idGrade,
                            idEkstra: idEkstra,
                            imageTeacher: imageTeacher,
                            isWali: isWali,
                            idEkstraPembina: idEkstraPembina,
                            ekstraPembinaName: ekstraNme,
                            nameSiswa: firstName + ' ' + lastName,
                            nisnSIswa: nisnSiswa,
                            statusStudent: statusStudent,
                          )
                        : role == 'walimurid'
                            ? KategoriWaliMurid(
                                role: rolesku,
                                idClass: idGrade.toString(),
                              )
                            : role == 'pembinaextra'
                                ? KategoriPembinaEkstra(
                                    role: rolesku,
                                    className: gradeName,
                                    idClass: idGrade,
                                    idEkstra: idEkstra,
                                    imageTeacher: imageTeacher,
                                    idEkstraPembina: idEkstraPembina,
                                    ekstraPembinaName: ekstraNme,
                                  )
                                : role == 'perpus'
                                    ? KategoriPerpus(
                                        role: rolesku,
                                        className: gradeName,
                                        idClass: idGrade,
                                        idEkstra: idEkstra,
                                      )
                                    : role == 'pegawaikoperasi'
                                        ? KategoriKoperasi(
                                            role: rolesku,
                                            className: gradeName,
                                            idClass: idGrade,
                                            idEkstra: idEkstra,
                                          )
                                        : role == 'kepsek'
                                            ? KategoriKepsek(
                                                role: rolesku,
                                                className: gradeName,
                                                idClass: idGrade,
                                                idEkstra: idEkstra,
                                                nameSiswa:
                                                    firstName + ' ' + lastName,
                                                nisnSIswa: nisnSiswa,
                                                statusStudent: statusStudent,
                                              )
                                            : role == 'pegawaikantin'
                                                ? KategoriKantin(
                                                    role: rolesku,
                                                    className: gradeName,
                                                    idClass: idGrade,
                                                    idEkstra: idEkstra,
                                                  )
                                                : role == 'tu'
                                                    ? KategoriTU(
                                                        role: rolesku,
                                                        statusStudent:
                                                            statusStudent,
                                                      )
                                                    : KategoriDinpes(
                                                        role: rolesku,
                                                        className: gradeName,
                                                        idClass: idGrade,
                                                        idEkstra: idEkstra,
                                                        imageTeacher:
                                                            imageTeacher,
                                                        isWali: isWali,
                                                        idEkstraPembina:
                                                            idEkstraPembina,
                                                        ekstraPembinaName:
                                                            ekstraNme,
                                                        nameSiswa: firstName +
                                                            ' ' +
                                                            lastName,
                                                        nisnSIswa: nisnSiswa,
                                                        statusStudent:
                                                            statusStudent,
                                                      ),
            const SizedBox(
              height: 30,
            ),
            // role == 'student' ? const PenerimaanSiswa() : const SizedBox(),
            Padding(
                padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Berita Dan Pengumuman",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                        fontFamily: 'Poppins',
                        color: Color(0xff4B556B),
                      ),
                    ),
                    role == 'admin'
                        ? GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CreateBeritaSekolah()));
                            },
                            child: SizedBox(
                              height: 25,
                              child: Image.asset('assets/icons/add-news.png'),
                            ),
                          )
                        : const SizedBox()
                  ],
                )),
            BeritaSekolahHome(
              role: '$role',
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BeritaSekolah(
                                role: role!,
                              )));
                },
                child: Center(
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xff2E447C),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Selengkapnya",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                                color: Color(0xff2E447C),
                                letterSpacing: 1),
                          ),
                          Icon(Icons.arrow_right)
                        ],
                      )),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

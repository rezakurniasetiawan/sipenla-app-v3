// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:siakad_app/check_auth.dart';
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/employee_model.dart';
import 'package:siakad_app/models/guardian_model.dart';
import 'package:siakad_app/models/student_model.dart';
import 'package:siakad_app/models/user_model.dart';
import 'package:siakad_app/screens/profile/component/item_biodata.dart';
import 'package:siakad_app/screens/profile/component/item_kartu_pelajar.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:getwidget/getwidget.dart';
import 'package:siakad_app/services/data_user_services.dart';
import 'package:siakad_app/widget/data_pegawai.dart';
import 'package:siakad_app/widget/data_siswa.dart';
import 'package:siakad_app/widget/ganti_sandi.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String role = "";
  String firstName = "";
  String lastName = "";
  String email = "";
  int idAuth = 0;
  String? photoProfile;

  EmployeeModel? employeeModel;
  StudentModel? studentModel;
  GuardianModel? guardianModel;
  UpdateFotoProfileModel? updateFotoProfileModel;
  bool loading = true;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      idAuth = preferences.getInt("userId")!;
      role = preferences.getString("role")!;
      firstName = preferences.getString("first_name")!;
      lastName = preferences.getString("last_name")!;
      email = preferences.getString("email")!;
      photoProfile = preferences.getString("photoUser");
    });
  }

  removePred() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("photoUser");
    preferences.remove("first_name");
    preferences.remove("last_name");
    preferences.remove("absensi");
    preferences.remove("gradeName");
    preferences.remove("idGrade");
    preferences.remove("idEkstra");
    preferences.remove("isWali");
    preferences.commit();
  }

  File? _imageFile;
  final _picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

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

  void fungsiUpdateFoto(int studentId) async {
    showAlertDialog(context);
    ApiResponse response =
        await updatePhotoStudent(studentId, getStringImage(_imageFile));
    if (response.error == null) {
      Navigator.pop(context);
      updateFotoProfileModel = response.data as UpdateFotoProfileModel;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Foto Profile Berhasil diubah')));
      setState(() {
        getUser();
        setPrefFotoProfile();
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const GetStartedScreen()),
                (route) => false)
          });
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  void fungsiUpdateFotoEmployee(int employeeId) async {
    showAlertDialog(context);
    ApiResponse response =
        await updatePhotoEmployee(employeeId, getStringImage(_imageFile));
    if (response.error == null) {
      Navigator.pop(context);
      updateFotoProfileModel = response.data as UpdateFotoProfileModel;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Foto Profile Berhasil diubah')));
      setState(() {
        getUser();
        setPrefFotoProfile();
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const GetStartedScreen()),
                (route) => false)
          });
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  //Get user detail
  void getUser() async {
    ApiResponse response = await getUserDetail();
    if (response.error == null) {
      setState(() {
        if (role == 'student') {
          studentModel = response.data as StudentModel;
          loading = false;
        } else if (role == 'walimurid') {
          setState(() {
            getGuardian();
          });
        } else {
          employeeModel = response.data as EmployeeModel;
          loading = false;
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
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  setPrefFotoProfile() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('photoUser', updateFotoProfileModel!.image);
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
    // TODO: implement initState
    super.initState();
    getPref();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              color: Colors.white,
              child: ListView(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: 200,
                      ),
                      (role == 'student')
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: 200,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: Stack(
                                        fit: StackFit.expand,
                                        // overflow: Overflow.visible,
                                        children: [
                                          SizedBox(
                                            width: 100,
                                            height: 100,
                                            child: _imageFile == null
                                                ? studentModel!.image != null
                                                    ? CachedNetworkImage(
                                                        imageUrl:
                                                            studentModel!.image,
                                                        fit: BoxFit.cover,
                                                        imageBuilder: (context,
                                                                imageProvider) =>
                                                            Container(
                                                          width: 100.0,
                                                          height: 100.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            image: DecorationImage(
                                                                image:
                                                                    imageProvider,
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                        placeholder: (context,
                                                                url) =>
                                                            Shimmer(
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .grey,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            100),
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
                                                                      Colors
                                                                          .grey,
                                                                      Colors
                                                                          .white12,
                                                                      Colors
                                                                          .grey,
                                                                    ])),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            const Icon(
                                                                Icons.error),
                                                      )
                                                    : Container(
                                                        height: 100,
                                                        width: 100,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            image: const DecorationImage(
                                                                image: AssetImage(
                                                                    "assets/image/image-not-available.jpg"),
                                                                fit: BoxFit
                                                                    .cover)),
                                                      )
                                                : Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      image: DecorationImage(
                                                          image: FileImage(
                                                              _imageFile ??
                                                                  File('')),
                                                          fit: BoxFit.cover),
                                                    ),
                                                  ),
                                          ),
                                          // Positioned(
                                          //   bottom: 0,
                                          //   right: -10,
                                          //   child: InkWell(
                                          //     onTap: () {
                                          //       getImage();
                                          //     },
                                          //     child: Container(
                                          //       height: 43,
                                          //       width: 43,
                                          //       decoration: BoxDecoration(
                                          //           borderRadius:
                                          //               BorderRadius.circular(
                                          //                   50),
                                          //           color:
                                          //               const Color(0xff3774C3),
                                          //           border: Border.all(
                                          //               color: Colors.white,
                                          //               width: 2)),
                                          //       child: Image.asset(
                                          //         'assets/icons/edit_admin.png',
                                          //         color: Colors.white,
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  role == 'walimurid'
                                      ? Text(
                                          firstName,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Color(0xff4B556B),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              letterSpacing: 1),
                                        )
                                      : Text(
                                          "$firstName $lastName",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Color(0xff4B556B),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              letterSpacing: 1),
                                        ),
                                  Text(
                                    role == 'student'
                                        ? 'Siswa'
                                        : role == 'admin'
                                            ? 'Administrator'
                                            : role == 'guru'
                                                ? 'Guru'
                                                : role == 'walimurid'
                                                    ? 'Wali Murid'
                                                    : '',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Color(0xff4B556B),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                        letterSpacing: 1),
                                  ),
                                ],
                              ),
                            )
                          : role == 'walimurid'
                              ? SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  height: 200,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: SizedBox(
                                          width: 100,
                                          height: 100,
                                          child: _imageFile == null
                                              ? guardianModel!.image != null
                                                  ? CachedNetworkImage(
                                                      imageUrl:
                                                          guardianModel!.image,
                                                      fit: BoxFit.cover,
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          Container(
                                                        width: 100.0,
                                                        height: 100.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                          image: DecorationImage(
                                                              image:
                                                                  imageProvider,
                                                              fit:
                                                                  BoxFit.cover),
                                                        ),
                                                      ),
                                                      placeholder: (context,
                                                              url) =>
                                                          Shimmer(
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .grey,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              100),
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
                                                                    Colors
                                                                        .white12,
                                                                    Colors.grey,
                                                                  ])),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Icon(
                                                              Icons.error),
                                                    )
                                                  : Container(
                                                      height: 185,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          image: const DecorationImage(
                                                              image: AssetImage(
                                                                  "assets/image/image-not-available.jpg"),
                                                              fit: BoxFit
                                                                  .cover)),
                                                    )
                                              : Container(
                                                  height: 100,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    image: DecorationImage(
                                                        image: FileImage(
                                                            _imageFile ??
                                                                File('')),
                                                        fit: BoxFit.cover),
                                                  ),
                                                ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      role == 'walimurid'
                                          ? Text(
                                              firstName,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: Color(0xff4B556B),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  letterSpacing: 1),
                                            )
                                          : Text(
                                              "$firstName $lastName",
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: Color(0xff4B556B),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  letterSpacing: 1),
                                            ),
                                      Text(
                                        role == 'student'
                                            ? 'Siswa'
                                            : role == 'admin'
                                                ? 'Administrator'
                                                : role == 'guru'
                                                    ? 'Guru'
                                                    : role == 'walimurid'
                                                        ? 'Wali Murid'
                                                        : '',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Color(0xff4B556B),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12,
                                            letterSpacing: 1),
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  height: 200,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: SizedBox(
                                          height: 100,
                                          width: 100,
                                          child: Stack(
                                            // fit: StackFit.expand,
                                            clipBehavior: Clip.none,
                                            //  overflow: Overflow.visible,
                                            children: [
                                              SizedBox(
                                                width: 100,
                                                height: 100,
                                                child: _imageFile == null
                                                    ? employeeModel!.image !=
                                                            null
                                                        ? CachedNetworkImage(
                                                            imageUrl:
                                                                employeeModel!
                                                                    .image,
                                                            fit: BoxFit.cover,
                                                            imageBuilder: (context,
                                                                    imageProvider) =>
                                                                Container(
                                                              width: 100.0,
                                                              height: 100.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                                image: DecorationImage(
                                                                    image:
                                                                        imageProvider,
                                                                    fit: BoxFit
                                                                        .cover),
                                                              ),
                                                            ),
                                                            placeholder: (context,
                                                                    url) =>
                                                                Shimmer(
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .grey,
                                                                        borderRadius:
                                                                            BorderRadius.circular(100),
                                                                      ),
                                                                    ),
                                                                    gradient: const LinearGradient(
                                                                        stops: [
                                                                          0.2,
                                                                          0.5,
                                                                          0.6
                                                                        ],
                                                                        colors: [
                                                                          Colors
                                                                              .grey,
                                                                          Colors
                                                                              .white12,
                                                                          Colors
                                                                              .grey,
                                                                        ])),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                const Icon(Icons
                                                                    .error),
                                                          )
                                                        : Container(
                                                            height: 185,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        50),
                                                                image: const DecorationImage(
                                                                    image: AssetImage(
                                                                        "assets/image/image-not-available.jpg"),
                                                                    fit: BoxFit
                                                                        .cover)),
                                                          )
                                                    : Container(
                                                        height: 100,
                                                        width: 100,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                          image: DecorationImage(
                                                              image: FileImage(
                                                                  _imageFile ??
                                                                      File('')),
                                                              fit:
                                                                  BoxFit.cover),
                                                        ),
                                                      ),
                                              ),
                                              // Positioned(
                                              //   bottom: 0,
                                              //   right: -10,
                                              //   child: InkWell(
                                              //     onTap: () {
                                              //       getImage();
                                              //     },
                                              //     child: Container(
                                              //       height: 43,
                                              //       width: 43,
                                              //       decoration: BoxDecoration(
                                              //           color: const Color(
                                              //               0xff3774C3),
                                              //           borderRadius:
                                              //               BorderRadius
                                              //                   .circular(50),
                                              //           border: Border.all(
                                              //               color: Colors.white,
                                              //               width: 2)),
                                              //       child: Padding(
                                              //         padding:
                                              //             const EdgeInsets.all(
                                              //                 10.0),
                                              //         child: Image.asset(
                                              //           'assets/icons/edit_admin.png',
                                              //           color: Colors.white,
                                              //         ),
                                              //       ),
                                              //     ),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      role == 'walimurid'
                                          ? Text(
                                              firstName,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: Color(0xff4B556B),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  letterSpacing: 1),
                                            )
                                          : Text(
                                              "$firstName $lastName",
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: Color(0xff4B556B),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  letterSpacing: 1),
                                            ),
                                      Text(
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
                                                            : role ==
                                                                    'walimurid'
                                                                ? 'Wali Murid'
                                                                : role ==
                                                                        'pengawassekolah'
                                                                    ? 'Pengawas Sekolah'
                                                                    : role ==
                                                                            'perpus'
                                                                        ? 'Pegawai Perpustakaan'
                                                                        : role ==
                                                                                'pegawaikoperasi'
                                                                            ? 'Pegawai Koperasi'
                                                                            : role == 'pegawaikantin'
                                                                                ? 'Pegawai Kantin'
                                                                                : role == 'pembinaextra'
                                                                                    ? 'Pembina Ekstra'
                                                                                    : 'Dinas Pendidikan',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Color(0xff4B556B),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12,
                                            letterSpacing: 1),
                                      ),
                                    ],
                                  ),
                                ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title:
                                      const Text("Apakah Anda Ingin Keluar?"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Batal")),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          removePred();
                                        });
                                        logout().then((value) =>
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const CheckAuth()),
                                                    (route) => false));
                                      },
                                      child: const Text(
                                        "Keluar",
                                        style:
                                            TextStyle(color: Colors.redAccent),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        },
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 200,
                            child: Stack(
                              children: [
                                Positioned(
                                    top: 10,
                                    right: 10,
                                    child: SizedBox(
                                      height: 35,
                                      child: Image.asset(
                                          'assets/icons/logout.png'),
                                    ))
                              ],
                            )),
                      ),
                    ],
                  ),
                  role == 'student'
                      ? InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                      title: const Text("Barcode Card"),
                                      content: SizedBox(
                                        height: 200,
                                        width: double.infinity,
                                        child: SfBarcodeGenerator(
                                            value: '${studentModel?.nisn}',
                                            // value: '212345678987456321',
                                            // symbology: Code128B(),
                                            symbology: QRCode(),
                                            barColor: const Color(0xff2E447C)
                                            // symbology: Code39(),
                                            ),
                                      ));
                                });
                          },
                          child: GFAccordion(
                            expandedTitleBackgroundColor: Colors.white,
                            title: 'Kartu Pelajar Digital',
                            collapsedIcon: const Icon(Icons.arrow_forward_ios),
                            expandedIcon: const Icon(Icons.arrow_downward),
                            contentChild: Column(
                              children: [
                                Container(
                                    height: 200,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          const Color(0xffFFFFFF),
                                          const Color(0xffC2D3F6),
                                          const Color(0xff2E447C)
                                              .withOpacity(0.9),
                                        ],
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                height: 50,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2,
                                                child: Image.asset(
                                                    'assets/image/logo.png'),
                                              ),
                                              const Expanded(
                                                  child: SizedBox(
                                                height: 50,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10, left: 5),
                                                  child: Text(
                                                    "SIPENLA Kartu Digital",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'Poppins',
                                                    ),
                                                  ),
                                                ),
                                              ))
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 100,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2,
                                                child: studentModel!.image !=
                                                        null
                                                    ? CachedNetworkImage(
                                                        imageUrl:
                                                            studentModel!.image,
                                                        fit: BoxFit.cover,
                                                        imageBuilder: (context,
                                                                imageProvider) =>
                                                            Container(
                                                          height: 100.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            image: DecorationImage(
                                                                image:
                                                                    imageProvider,
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                        placeholder: (context,
                                                                url) =>
                                                            Shimmer(
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .grey,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
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
                                                                      Colors
                                                                          .grey,
                                                                      Colors
                                                                          .white12,
                                                                      Colors
                                                                          .grey,
                                                                    ])),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            const Icon(
                                                                Icons.error),
                                                      )
                                                    : Shimmer(
                                                        child: Container(
                                                          width: 100,
                                                          height: 100,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.grey,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
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
                                                          ],
                                                        ),
                                                      ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5),
                                                  child: SizedBox(
                                                    child: Column(
                                                      children: [
                                                        ItemKartuPelajar(
                                                          text1: 'Nama',
                                                          text2:
                                                              '${studentModel?.studentFirstName} ${studentModel?.studentLastName} ',
                                                        ),
                                                        ItemKartuPelajar(
                                                            text1: 'NISN',
                                                            text2:
                                                                '${studentModel?.nisn}'),
                                                        ItemKartuPelajar(
                                                            text1:
                                                                'Tempat/Tgl.',
                                                            text2:
                                                                '${studentModel?.placeOfBirth} ${studentModel?.dateOfBirth}'),
                                                        ItemKartuPelajar(
                                                            text1: 'Alamat',
                                                            text2:
                                                                '${studentModel?.address}'),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        SizedBox(
                                                          height: 45,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(3.0),
                                                            child:
                                                                SfBarcodeGenerator(
                                                              value:
                                                                  '${studentModel?.nisn}',
                                                              symbology:
                                                                  Code128B(),
                                                              // symbology:
                                                              //     Code39(),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        )
                      : role == 'walimurid'
                          ? Container()
                          : GFAccordion(
                              expandedTitleBackgroundColor: Colors.white,
                              title: 'Kartu Pegawai Digital',
                              collapsedIcon:
                                  const Icon(Icons.arrow_forward_ios),
                              expandedIcon: const Icon(Icons.arrow_downward),
                              contentChild: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                                title:
                                                    const Text("Barcode Card"),
                                                content: SizedBox(
                                                  height: 200,
                                                  child: SfBarcodeGenerator(
                                                      value:
                                                          employeeModel!.npsn,
                                                      // value: '212345678987456321',
                                                      symbology: QRCode(),
                                                      barColor: const Color(
                                                          0xff2E447C)
                                                      // symbology: Code39(),
                                                      ),
                                                ));
                                          });
                                    },
                                    child: Container(
                                        height: 200,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              const Color(0xffFFFFFF),
                                              const Color(0xffC2D3F6),
                                              const Color(0xff2E447C)
                                                  .withOpacity(0.9),
                                            ],
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    height: 50,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                    child: Image.asset(
                                                        'assets/image/logo.png'),
                                                  ),
                                                  Expanded(
                                                      child: const SizedBox(
                                                    height: 50,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 10, left: 5),
                                                      child: Text(
                                                        "SIPENLA Kartu Digital",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontFamily: 'Poppins',
                                                        ),
                                                      ),
                                                    ),
                                                  ))
                                                ],
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 100,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                    child: employeeModel!
                                                                .image !=
                                                            null
                                                        ? CachedNetworkImage(
                                                            imageUrl:
                                                                employeeModel!
                                                                    .image,
                                                            fit: BoxFit.cover,
                                                            imageBuilder: (context,
                                                                    imageProvider) =>
                                                                Container(
                                                              height: 100.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                image: DecorationImage(
                                                                    image:
                                                                        imageProvider,
                                                                    fit: BoxFit
                                                                        .cover),
                                                              ),
                                                            ),
                                                            placeholder: (context,
                                                                    url) =>
                                                                Shimmer(
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .grey,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                      ),
                                                                    ),
                                                                    gradient: const LinearGradient(
                                                                        stops: [
                                                                          0.2,
                                                                          0.5,
                                                                          0.6
                                                                        ],
                                                                        colors: [
                                                                          Colors
                                                                              .grey,
                                                                          Colors
                                                                              .white12,
                                                                          Colors
                                                                              .grey,
                                                                        ])),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                const Icon(Icons
                                                                    .error),
                                                          )
                                                        : Shimmer(
                                                            child: Container(
                                                              width: 100,
                                                              height: 100,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    Colors.grey,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
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
                                                              ],
                                                            ),
                                                          ),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5),
                                                      child: SizedBox(
                                                        child: Column(
                                                          children: [
                                                            ItemKartuPelajar(
                                                                text1: 'Nama',
                                                                text2: employeeModel!
                                                                        .firstName +
                                                                    " " +
                                                                    employeeModel!
                                                                        .lastName),
                                                            ItemKartuPelajar(
                                                                text1: 'NPSN',
                                                                text2:
                                                                    employeeModel!
                                                                        .npsn),
                                                            ItemKartuPelajar(
                                                                text1:
                                                                    'Tempat/Tgl.',
                                                                text2: employeeModel!
                                                                        .placeOfBirth +
                                                                    "/ " +
                                                                    employeeModel!
                                                                        .dateOfBirth),
                                                            ItemKartuPelajar(
                                                                text1: 'Alamat',
                                                                text2:
                                                                    employeeModel!
                                                                        .address),
                                                            SizedBox(
                                                              height: 45,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        3.0),
                                                                child:
                                                                    SfBarcodeGenerator(
                                                                  value:
                                                                      employeeModel!
                                                                          .npsn,
                                                                  // symbology: Code128B(),
                                                                  symbology:
                                                                      Code128B(),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        )),
                                  )
                                ],
                              ),
                            ),
                  role == 'student'
                      ? GFAccordion(
                          expandedTitleBackgroundColor: Colors.white,
                          title: 'Biodata',
                          collapsedIcon: const Icon(Icons.arrow_forward_ios),
                          expandedIcon: const Icon(Icons.arrow_downward),
                          contentChild: Column(
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              ItemBiodata(
                                  text1: 'NISN',
                                  text2: '${studentModel?.nisn}'),
                              const SizedBox(
                                height: 10,
                              ),
                              ItemBiodata(
                                text1: 'Nama',
                                text2:
                                    '${studentModel?.studentFirstName} ${studentModel?.studentLastName}',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ItemBiodata(
                                text1: 'Kelas',
                                text2: studentModel!.gradeName == '-'
                                    ? 'Belum Memiliki Kelas'
                                    : studentModel!.gradeName,
                              ),
                              // const SizedBox(
                              //   height: 10,
                              // ),
                              // ItemBiodata(
                              //   text1: 'NIK',
                              //   text2: '${studentModel?.nik}',
                              // ),
                              const SizedBox(
                                height: 10,
                              ),
                              ItemBiodata(
                                text1: 'Tempat Lahir',
                                text2: '${studentModel?.placeOfBirth}',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ItemBiodata(
                                text1: 'Tanggal Lahir',
                                text2: '${studentModel?.dateOfBirth}',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ItemBiodata(
                                text1: 'Jenis Kelamin',
                                text2: '${studentModel?.gender}',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ItemBiodata(
                                text1: 'Agama',
                                text2: '${studentModel?.religion}',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ItemBiodata(
                                text1: 'Nama Ayah',
                                text2: '${studentModel?.fatherName}',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ItemBiodata(
                                text1: 'Nama Ibu',
                                text2: '${studentModel?.motherName}',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ItemBiodata(
                                text1: 'Email',
                                text2: email,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ItemBiodata(
                                text1: 'Wali Kelas',
                                text2: studentModel!.employeeFirstName == '-'
                                    ? 'Belum Memiliki Wali Kelas'
                                    : studentModel!.employeeFirstName +
                                        ' ' +
                                        studentModel!.employeeLastName,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ItemBiodata(
                                text1: 'Ekstrakurikuler',
                                text2: studentModel!.extracurricularName,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        )
                      : role == 'walimurid'
                          ? GFAccordion(
                              expandedTitleBackgroundColor: Colors.white,
                              title: 'Biodata',
                              collapsedIcon:
                                  const Icon(Icons.arrow_forward_ios),
                              expandedIcon: const Icon(Icons.arrow_downward),
                              contentChild: Column(
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  ItemBiodata(
                                      text1: 'NISN',
                                      text2: '${guardianModel?.nisn}'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ItemBiodata(
                                    text1: 'Nama',
                                    text2:
                                        '${guardianModel?.firstName} ${guardianModel?.lastName}',
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const ItemBiodata(
                                    text1: 'Kelas',
                                    text2: '',
                                  ),
                                  // const SizedBox(
                                  //   height: 10,
                                  // ),
                                  // ItemBiodata(
                                  //   text1: 'NIK',
                                  //   text2: '${guardianModel?.nik}',
                                  // ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ItemBiodata(
                                    text1: 'Tempat Lahir',
                                    text2: '${guardianModel?.placeOfBirth}',
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ItemBiodata(
                                    text1: 'Tanggal Lahir',
                                    text2: '${guardianModel?.dateOfBirth}',
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ItemBiodata(
                                    text1: 'Jenis Kelamin',
                                    text2: '${guardianModel?.gender}',
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ItemBiodata(
                                    text1: 'Agama',
                                    text2: '${guardianModel?.religion}',
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ItemBiodata(
                                    text1: 'Nama Ayah',
                                    text2: '${guardianModel?.fatherName}',
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ItemBiodata(
                                    text1: 'Nama Ibu',
                                    text2: '${guardianModel?.motherName}',
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ItemBiodata(
                                    text1: 'Email',
                                    text2: email,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const ItemBiodata(
                                    text1: 'Wali Kelas',
                                    text2: 'Bukyah',
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const ItemBiodata(
                                    text1: 'Ekstrkurikuler',
                                    text2: '',
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            )
                          : GFAccordion(
                              expandedTitleBackgroundColor: Colors.white,
                              title: 'Biodata',
                              collapsedIcon:
                                  const Icon(Icons.arrow_forward_ios),
                              expandedIcon: const Icon(Icons.arrow_downward),
                              contentChild: Column(
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  ItemBiodata(
                                      text1: 'NUPTK',
                                      text2: employeeModel!.nuptk),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ItemBiodata(
                                      text1: 'Nama',
                                      text2:
                                          '${employeeModel!.firstName} ${employeeModel!.lastName}'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  // ItemBiodata(
                                  //     text1: 'NIK', text2: employeeModel!.nik),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ItemBiodata(
                                      text1: 'NPSN',
                                      text2: employeeModel!.npsn),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ItemBiodata(
                                      text1: 'Tempat Lahir',
                                      text2: employeeModel!.placeOfBirth),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ItemBiodata(
                                      text1: 'Tanggal Lahir',
                                      text2: employeeModel!.dateOfBirth),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ItemBiodata(
                                      text1: 'Jenis Kelamin',
                                      text2: employeeModel!.gender),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ItemBiodata(
                                      text1: 'Alamat',
                                      text2: employeeModel!.address),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ItemBiodata(
                                      text1: 'Agama',
                                      text2: employeeModel!.religion),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ItemBiodata(
                                      text1: 'Riwayat Pendidikan',
                                      text2: employeeModel!.education),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ItemBiodata(
                                      text1: 'Nama Ibu',
                                      text2: employeeModel!.familyName),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ItemBiodata(
                                      text1: 'Almaat Orang Tua',
                                      text2: employeeModel!.familyAddress),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ItemBiodata(text1: 'Email', text2: email),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ItemBiodata(
                                      text1: 'Jabatan',
                                      text2: employeeModel!.position),
                                ],
                              ),
                            ),
                  const SizedBox(
                    height: 20,
                  ),
                  role == 'student'
                      ? Column(
                          children: [
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const DataSiswa()));
                                },
                                child: Center(
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height: 55,
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
                                      "Data Penerimaan",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                          letterSpacing: 1),
                                    )),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            _imageFile != null
                                ? Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        fungsiUpdateFoto(
                                            studentModel!.studentId);
                                      },
                                      child: Center(
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
                                          height: 55,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            gradient: const LinearGradient(
                                              begin:
                                                  FractionalOffset.centerLeft,
                                              end: FractionalOffset.centerRight,
                                              colors: [
                                                Color(0xff2E447C),
                                                Color(0xff3774C3),
                                              ],
                                            ),
                                          ),
                                          child: const Center(
                                              child: Text(
                                            "Ganti Foto",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Poppins',
                                                color: Colors.white,
                                                letterSpacing: 1),
                                          )),
                                        ),
                                      ),
                                    ),
                                  )
                                : Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        getImage();
                                      },
                                      child: Center(
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
                                          height: 55,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: const Color(0xff2E447C),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: const Center(
                                              child: Text(
                                            "Ganti Foto",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Poppins',
                                                color: Color(0xff2E447C),
                                                letterSpacing: 1),
                                          )),
                                        ),
                                      ),
                                    ),
                                  ),
                            const SizedBox(
                              height: 15,
                            )
                          ],
                        )
                      : role == 'walimurid'
                          ? Column(
                              children: const [
                                SizedBox(
                                  height: 15,
                                )
                              ],
                            )
                          : Column(
                              children: [
                                Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const DataPegawai()));
                                    },
                                    child: Center(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        height: 55,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                          "Formulir Data Pegawai",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              letterSpacing: 1),
                                        )),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                _imageFile != null
                                    ? Center(
                                        child: GestureDetector(
                                          onTap: () {
                                            fungsiUpdateFotoEmployee(
                                                employeeModel!.employeeId);
                                          },
                                          child: Center(
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              height: 55,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                gradient: const LinearGradient(
                                                  begin: FractionalOffset
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
                                                "Ganti Foto",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Poppins',
                                                    color: Colors.white,
                                                    letterSpacing: 1),
                                              )),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Center(
                                        child: GestureDetector(
                                          onTap: () {
                                            getImage();
                                          },
                                          child: Center(
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              height: 55,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color:
                                                      const Color(0xff2E447C),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: const Center(
                                                  child: Text(
                                                "Ganti Foto",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Poppins',
                                                    color: Color(0xff2E447C),
                                                    letterSpacing: 1),
                                              )),
                                            ),
                                          ),
                                        ),
                                      ),
                                const SizedBox(
                                  height: 15,
                                )
                              ],
                            ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // Center(
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       // Navigator.push(
                  //       //     context,
                  //       //     MaterialPageRoute(
                  //       //         builder: (context) => LogiScreen()));
                  //     },
                  //     child: Center(
                  //       child: Container(
                  //         width: MediaQuery.of(context).size.width * 0.9,
                  //         height: 55,
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(8),
                  //           gradient: const LinearGradient(
                  //             begin: FractionalOffset.centerLeft,
                  //             end: FractionalOffset.centerRight,
                  //             colors: [
                  //               Color(0xff2E447C),
                  //               Color(0xff3774C3),
                  //             ],
                  //           ),
                  //         ),
                  //         child: const Center(
                  //             child: Text(
                  //           "Mutasi",
                  //           style: TextStyle(
                  //               fontSize: 16,
                  //               fontWeight: FontWeight.bold,
                  //               fontFamily: 'Poppins',
                  //               color: Colors.white,
                  //               letterSpacing: 1),
                  //         )),
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const GantiSandiScreen()));
                      },
                      child: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 55,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xff2E447C),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                              child: Text(
                            "Ganti Sandi",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                                color: Color(0xff2E447C),
                                letterSpacing: 1),
                          )),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
    );
  }
}

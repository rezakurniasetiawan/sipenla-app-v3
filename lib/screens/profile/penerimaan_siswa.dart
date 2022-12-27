// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, unnecessary_const

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/screens/check_userdata.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:http/http.dart' as http;
import 'package:siakad_app/services/auth_service.dart';
import 'package:siakad_app/services/penerimaan_service.dart';

class DataPenerimaanStudent extends StatefulWidget {
  const DataPenerimaanStudent({Key? key}) : super(key: key);

  @override
  State<DataPenerimaanStudent> createState() => _DataPenerimaanStudentState();
}

class _DataPenerimaanStudentState extends State<DataPenerimaanStudent> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  TextEditingController namadepan = TextEditingController();
  TextEditingController namabelakang = TextEditingController();
  TextEditingController nik = TextEditingController();
  TextEditingController nisn = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController tempatlahir = TextEditingController();
  TextEditingController tanggallahir = TextEditingController();
  TextEditingController agama = TextEditingController();
  TextEditingController alamattinggal = TextEditingController();
  TextEditingController asalsekolah = TextEditingController();
  TextEditingController kelas = TextEditingController();
  TextEditingController tglKelas = TextEditingController();
  TextEditingController namaayah = TextEditingController();
  TextEditingController namaibu = TextEditingController();
  TextEditingController alamatortu = TextEditingController();
  TextEditingController pekerjaanayah = TextEditingController();
  TextEditingController pekerjaanibu = TextEditingController();
  // TextEditingController pendidikanayah = TextEditingController();
  // TextEditingController pendidikanibu = TextEditingController();
  TextEditingController namawali = TextEditingController();
  TextEditingController alamatwali = TextEditingController();
  TextEditingController pekerjaanwali = TextEditingController();

  final List<String> items = [
    'Laki-laki',
    'Perempuan',
  ];

  final List<String> itemsPendidikan = [
    'SD / MI',
    'SMP / MTS',
    'SMA / SMK',
    'Diploma III / IV',
    'Strata I',
    'Strata II',
    'Strata III',
  ];
  final List<String> itemsAgama = [
    'Islam',
    'Kristen',
    'Katolik',
    'Hindu',
    'Budha',
    'Konghucu',
  ];

  List ekstraList = [];
  var valueEkstra;
  String? jeniskelamin;
  String? pendidikanAyah;
  String? agamaUser;
  String? pendidikanIbu;

  File? _imageFile;
  final _picker = ImagePicker();

  Future getImage() async {
    print('halo');
    // ignore: deprecated_member_use
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  bool _loading = false;

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

  Future getEkstra() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(baseURL + '/api/extraschedule/getextra'),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body)['data'];
      setState(() {
        ekstraList = jsonData;
      });
    }
  }

  void fungsiPenerimaanSiswa() async {
    showAlertDialog(context);
    String? image = _imageFile == null ? null : getStringImage(_imageFile);
    ApiResponse response = await penerimaanSiswa(
      namadepan: namadepan.text,
      namabelakang: namabelakang.text,
      // nik: nik.text,
      nisn: nisn.text,
      phone: phone.text,
      tempatlahir: tempatlahir.text,
      tanggallahir: tanggallahir.text.toString(),
      jeniskelamin: jeniskelamin.toString(),
      agama: agamaUser.toString(),
      alamattinggal: alamattinggal.text,
      asalsekolah: asalsekolah.text,
      kelas: kelas.text,
      namaayah: namaayah.text,
      namaibu: namaibu.text,
      alamatortu: alamatortu.text,
      pekerjaanayah: pekerjaanayah.text,
      pekerjaanibu: pekerjaanibu.text,
      pendidikanayah: pendidikanAyah.toString(),
      pendidikanibu: pendidikanIbu.toString(),
      namawali: namawali.text.isEmpty ? '-' : namawali.text,
      alamatwali: alamatwali.text.isEmpty ? '-' : alamatwali.text,
      profilestudent: image,
      tglKelas: tglKelas.text.toString(),
      pekerjaanwali: pekerjaanwali.text.isEmpty ? '-' : pekerjaanwali.text,
      ekstra: valueEkstra.toString(),
    );
    if (response.error == null) {
      Navigator.pop(context);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const CheckUserData()));
    } else {
      print(response.error);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Ada Kesalahan')));
      setState(() {
        _loading = !_loading;
      });
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    getEkstra();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    InkWell(
                        onTap: () {
                          logout().then((value) => {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const GetStartedScreen()),
                                    (route) => false)
                              });
                        },
                        child: const Icon(Icons.arrow_back)),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "Data Penerimaan",
                      style: const TextStyle(
                        fontSize: 20,
                        color: const Color(0xff4B556B),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 25,
                      child: Image.asset('assets/image/logo-sipenla.png'),
                    ),
                    SizedBox(
                      height: 25,
                      child: Image.asset('assets/image/kemendikbud.png'),
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
                const Text(
                  "Nama Lengkap",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: Color(0xff4B556B),
                  ),
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                      controller: namadepan,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Masukkan Nama Depan',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Wajib Di isi';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                      controller: namabelakang,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Masukkan Belakang',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Wajib Di isi';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "NISN",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: Color(0xff4B556B),
                  ),
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                      controller: nisn,
                      maxLength: 16,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Masukkan NISN',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Wajib Di isi';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Nomor Hp",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: const Color(0xff4B556B),
                  ),
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                      controller: phone,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Masukkan No Hp',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Wajib Di isi';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Tempat, Tanggal Lahir",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: Color(0xff4B556B),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextFormField(
                            controller: tempatlahir,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Masuukan Tempat Lahir',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Wajib Di isi';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextFormField(
                            controller: tanggallahir,
                            readOnly: true,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              suffixIcon: ImageIcon(AssetImage(
                                  'assets/icons/calendar_month.png')),
                              hintText: 'yyyy-mm-dd',
                            ),
                            onTap: () async {
                              DateTime? pickedDate2 = await showDatePicker(
                                  context: context,
                                  // locale: const Locale("id", "ID"),
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101));

                              if (pickedDate2 != null) {
                                // print(pickedDate);
                                String formattedDate = DateFormat('yyyy-MM-dd')
                                    .format(pickedDate2);
                                print(formattedDate);

                                setState(() {
                                  tanggallahir.text = formattedDate;
                                });
                              } else {
                                print("Date is not selected");
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Wajib Di isi';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Jenis Kelamin",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: Color(0xff4B556B),
                  ),
                ),
                Container(
                  height: 48,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color(0xffF0F1F2),
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        icon: const ImageIcon(
                          AssetImage('assets/icons/arrow-down.png'),
                        ),
                        dropdownColor: const Color(0xffF0F1F2),
                        borderRadius: BorderRadius.circular(15),
                        isExpanded: true,
                        items: items
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                            .toList(),
                        hint: const Text(
                          'Pilih Jenis Kelamin',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        menuMaxHeight: 300,
                        value: jeniskelamin,
                        onChanged: (value) {
                          setState(() {
                            jeniskelamin = value as String;
                            print(jeniskelamin);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Agama",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: Color(0xff4B556B),
                  ),
                ),
                Container(
                  height: 48,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color(0xffF0F1F2),
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        icon: const ImageIcon(
                          AssetImage('assets/icons/arrow-down.png'),
                        ),
                        dropdownColor: const Color(0xffF0F1F2),
                        borderRadius: BorderRadius.circular(15),
                        isExpanded: true,
                        items: itemsAgama
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                            .toList(),
                        hint: const Text(
                          'Pilih Agama',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        menuMaxHeight: 300,
                        value: agamaUser,
                        onChanged: (value) {
                          setState(() {
                            agamaUser = value as String;
                            print(agamaUser);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Alamat Tinggal",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: Color(0xff4B556B),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                      maxLines: 4,
                      controller: alamattinggal,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Masukkan Alamat Tinggal',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Wajib Di isi';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const Text(
                  "Asal Sekolah",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: Color(0xff4B556B),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                      controller: asalsekolah,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Masukkan Asal Sekolah',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Wajib Di isi';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Diterima di Sekolah ini",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: Color(0xff4B556B),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextFormField(
                            controller: kelas,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Kelas',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Wajib Di isi';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextFormField(
                            controller: tglKelas,
                            readOnly: true,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              suffixIcon: ImageIcon(AssetImage(
                                  'assets/icons/calendar_month.png')),
                              hintText: 'yyyy-mm-dd',
                            ),
                            onTap: () async {
                              DateTime? pickedDate1 = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101));

                              if (pickedDate1 != null) {
                                // print(pickedDate1);
                                String formattedDate1 = DateFormat('yyyy-MM-dd')
                                    .format(pickedDate1);
                                print(formattedDate1);

                                setState(() {
                                  tglKelas.text = formattedDate1;
                                });
                              } else {
                                print("Date is not selected");
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Wajib Di isi';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Nama Ayah",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: Color(0xff4B556B),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                      controller: namaayah,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Masukkan Nama Ayah',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Wajib Di isi';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Pekerjaan Ayah",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: Color(0xff4B556B),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                      controller: pekerjaanayah,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Masukkan Pekerjaan Ayah',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Wajib Di isi';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Pendidikan Terakhir Ayah",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: Color(0xff4B556B),
                  ),
                ),
                Container(
                  height: 48,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color(0xffF0F1F2),
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        icon: const ImageIcon(
                          AssetImage('assets/icons/arrow-down.png'),
                        ),
                        dropdownColor: const Color(0xffF0F1F2),
                        borderRadius: BorderRadius.circular(15),
                        isExpanded: true,
                        items: itemsPendidikan
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                            .toList(),
                        hint: const Text(
                          'Pendidikan Terakhir Ayah',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        menuMaxHeight: 300,
                        value: pendidikanAyah,
                        onChanged: (value) {
                          setState(() {
                            pendidikanAyah = value as String;
                            print(pendidikanAyah);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Nama Ibu",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: Color(0xff4B556B),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                      controller: namaibu,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Masukkan Nama Ibu',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Wajib Di isi';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Pekerjaan Ibu",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: Color(0xff4B556B),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                      controller: pekerjaanibu,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Masukkan Pekerjaan Ibu',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Wajib Di isi';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Pendidikan Terakhir Ibu",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: Color(0xff4B556B),
                  ),
                ),
                Container(
                  height: 48,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color(0xffF0F1F2),
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        icon: const ImageIcon(
                          AssetImage('assets/icons/arrow-down.png'),
                        ),
                        dropdownColor: const Color(0xffF0F1F2),
                        borderRadius: BorderRadius.circular(15),
                        isExpanded: true,
                        items: itemsPendidikan
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                            .toList(),
                        hint: const Text(
                          'Pendidikan Terakhir Ibu',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        menuMaxHeight: 300,
                        value: pendidikanIbu,
                        onChanged: (value) {
                          setState(() {
                            pendidikanIbu = value as String;
                            print(pendidikanIbu);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Alamat Orang Tua",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: Color(0xff4B556B),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                      maxLines: 4,
                      controller: alamatortu,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Masukkan Alamat Tinggal',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Wajib Di isi';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Nama Wali",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: Color(0xff4B556B),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                      controller: namawali,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Masukkan Nama Wali',
                      ),
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Wajib Di isi';
                      //   }
                      //   return null;
                      // },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Alamat Wali",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: Color(0xff4B556B),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                      maxLines: 4,
                      controller: alamatwali,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Masukkan Alamat Wali',
                      ),
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Wajib Di isi';
                      //   }
                      //   return null;
                      // },
                    ),
                  ),
                ),
                const Text(
                  "Pekerjaan Wali",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: Color(0xff4B556B),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                      controller: pekerjaanwali,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Masukkan Pekerjaan Wali',
                      ),
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Wajib Di isi';
                      //   }
                      //   return null;
                      // },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Ekstrakulikuler",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: Color(0xff4B556B),
                  ),
                ),
                Container(
                  height: 48,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color(0xffF0F1F2),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        icon: const ImageIcon(
                          AssetImage('assets/icons/arrow-down.png'),
                        ),
                        dropdownColor: const Color(0xffF0F1F2),
                        borderRadius: BorderRadius.circular(15),
                        hint: const Text('Ekstrakulikuler'),
                        items: ekstraList.map((item) {
                          return DropdownMenuItem(
                            value: item['extracurricular_id'].toString(),
                            child:
                                Text(item['extracurricular_name'].toString()),
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          setState(() {
                            valueEkstra = newVal;
                            print(valueEkstra);
                          });
                        },
                        value: valueEkstra,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Unggah Foto",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: Color(0xff4B556B),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                      // controller: textEmail,
                      readOnly: true,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: const Icon(
                            Icons.image,
                            color: Colors.grey,
                          ),
                          hintText:
                              _imageFile == null ? 'pilih foto' : 'ganti foto'),
                      onTap: () {
                        getImage();
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _imageFile == null
                      ? null
                      : Container(
                          height: 160,
                          width: 140,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(_imageFile ?? File('')),
                                fit: BoxFit.cover),
                          ),
                        ),
                ),
                const Text(
                  '*Foto harus background merah dan berseragam putih biru',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.red,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    if (_key.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Container(
                            child: AlertDialog(
                              actions: [
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 85,
                                      width: 85,
                                      child: Image.asset(
                                          'assets/icons/warning-icon.png'),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      child: Text(
                                        'Apakah Anda Yakin Data Yang Diisi sudah benar?',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Poppins',
                                          color: Color(0xff4B556B),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 130,
                                          height: 44,
                                          decoration: BoxDecoration(
                                              color: const Color(0xffFF4238),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                "Batal",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: 'Poppins',
                                                    color: Colors.white),
                                              )),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          width: 130,
                                          height: 44,
                                          decoration: BoxDecoration(
                                              color: const Color(0xff83BC10),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: TextButton(
                                            onPressed: () {
                                              setState(() {
                                                showAlertDialog(context);
                                              });
                                              fungsiPenerimaanSiswa();
                                            },
                                            child: const Text(
                                              "Setuju",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'Poppins',
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      );
                      // Alert(
                      //   context: context,
                      //   type: AlertType.info,
                      //   title: "Sipenla App",
                      //   desc: "Apakah data yang anda masukkan sudah benar?",
                      //   buttons: [
                      //     DialogButton(
                      //       child: InkWell(
                      //         onTap: () {
                      //           setState(() {
                      //             showAlertDialog(context);
                      //           });
                      //           fungsiPenerimaanSiswa();
                      //         },
                      //         child: const Text(
                      //           "Lanjutkan",
                      //           style: TextStyle(
                      //               color: Colors.white, fontSize: 20),
                      //         ),
                      //       ),
                      //       onPressed: () => Navigator.pop(context),
                      //       width: 120,
                      //     )
                      //   ],
                      // ).show();
                    }

                    // fungsiPenerimaanSiswa();
                  },
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
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
                        "Kirim",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            letterSpacing: 1),
                      )),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

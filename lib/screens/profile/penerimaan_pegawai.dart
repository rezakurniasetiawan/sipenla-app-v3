// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/screens/check_userdata.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:siakad_app/services/penerimaan_service.dart';

class DataPenerimaanPegawai extends StatefulWidget {
  const DataPenerimaanPegawai({Key? key}) : super(key: key);

  @override
  State<DataPenerimaanPegawai> createState() => _DataPenerimaanPegawaiState();
}

class _DataPenerimaanPegawaiState extends State<DataPenerimaanPegawai> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  TextEditingController namadepan = TextEditingController();
  TextEditingController namabelakang = TextEditingController();
  TextEditingController nik = TextEditingController();
  TextEditingController nuptk = TextEditingController();
  TextEditingController npsn = TextEditingController();
  TextEditingController tempatlahir = TextEditingController();
  TextEditingController tanggallahir = TextEditingController();
  String? jeniskelamin;
  String? pendidikan;
  String? agamaUser;
  TextEditingController agama = TextEditingController();
  TextEditingController alamattinggal = TextEditingController();
  // TextEditingController riwayatpendidikan = TextEditingController();
  TextEditingController namaibu = TextEditingController();
  TextEditingController alamatortu = TextEditingController();
  // TextEditingController email = TextEditingController();
  TextEditingController jabatan1 = TextEditingController();
  TextEditingController nomorhp = TextEditingController();

  var dropdownvalue;

  final List<String> items = [
    'Laki-Laki',
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

  List Itemlist = [];
  Future getWorkShift() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(baseURL + '/api/admission/getshift'),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body)['data'][0];
      setState(() {
        Itemlist = jsonData;
      });
    }
  }

  void fungsiPenerimaanPegawai() async {
    showAlertDialog(context);
    String? image = _imageFile == null ? null : getStringImage(_imageFile);
    ApiResponse response = await penerimaanPegawai(
        agama: agamaUser.toString(),
        alamatortu: alamatortu.text,
        alamattinggal: alamattinggal.text,
        jabatan1: jabatan1.text,
        jeniskelamin: jeniskelamin.toString(),
        namabelakang: namabelakang.text,
        namadepan: namadepan.text,
        namaibu: namaibu.text,
        // nik: nik.text,
        nuptk: nuptk.text,
        npsn: npsn.text,
        phone: nomorhp.text,
        photoprofile: image,
        riwayatpendidikan: pendidikan.toString(),
        tanggallahir: tanggallahir.text,
        tempatlahir: tempatlahir.text,
        workshiftId: dropdownvalue);
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
    super.initState();
    getWorkShift();
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
                      "Data Pegawai",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff4B556B),
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
                    "FOLUMULIR DATA PEGAWAI",
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
                  height: 15,
                ),
                const Center(
                  child: Text(
                    "BIODATA PEGAWAI",
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
                        hintText: 'Masukkan Nama Belakang',
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
                  "NUPTKS",
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
                      controller: nuptk,
                      maxLength: 16,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Masukkan NUPTKS',
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
                  "NPSN",
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
                      controller: npsn,
                      maxLength: 16,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Masukkan NPSN',
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
                      controller: nomorhp,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Masukkan Nomor Hp',
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
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101));

                              if (pickedDate != null) {
                                // print(pickedDate);
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
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
                          'Pilih Jenis Agama',
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
                  "Riwayat Pendidikan",
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
                          'Riwayat Pendidikan',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        menuMaxHeight: 300,
                        value: pendidikan,
                        onChanged: (value) {
                          setState(() {
                            pendidikan = value as String;
                            print(pendidikan);
                          });
                        },
                      ),
                    ),
                  ),
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
                        hintText: 'Masukkan Alamat Orang Tua',
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
                // const Text(
                //   "Email",
                //   style: TextStyle(
                //     fontSize: 14,
                //     fontWeight: FontWeight.w600,
                //     fontFamily: 'Poppins',
                //     color: Color(0xff4B556B),
                //   ),
                // ),
                // Container(
                //   decoration: BoxDecoration(
                //       color: Colors.grey[100],
                //       borderRadius: BorderRadius.circular(12)),
                //   child: Padding(
                //     padding: const EdgeInsets.only(left: 10),
                //     child: TextFormField(
                //       // controller: agama,
                //       decoration: const InputDecoration(
                //         border: InputBorder.none,
                //         hintText: 'Masukkan Email',
                //       ),
                //       validator: (value) {
                //         if (value == null || value.isEmpty) {
                //           return 'Wajib Di isi';
                //         }
                //         return null;
                //       },
                //     ),
                //   ),
                // ),
                const Text(
                  "Jabatan 1",
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
                      controller: jabatan1,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Masukkan Jabatan 1',
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
                const Text(
                  "Shift Kerja",
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
                      child: DropdownButton(
                        icon: const ImageIcon(
                          AssetImage('assets/icons/arrow-down.png'),
                        ),
                        dropdownColor: const Color(0xffF0F1F2),
                        borderRadius: BorderRadius.circular(15),
                        hint: const Text('Shift Kerja'),
                        items: Itemlist.map((item) {
                          return DropdownMenuItem(
                            value: item['workshift_id'].toString(),
                            child: Text(item['shift_name'].toString()),
                          );
                        }).toList(),
                        menuMaxHeight: 250,
                        onChanged: (newVal) {
                          setState(() {
                            dropdownvalue = newVal;
                            print(dropdownvalue);
                          });
                        },
                        value: dropdownvalue,
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
                                              fungsiPenerimaanPegawai();
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
                      //           fungsiPenerimaanPegawai();
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
                        "Simpan",
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

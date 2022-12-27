// ignore_for_file: avoid_print

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/screens/check_userdata.dart';
import 'package:siakad_app/services/auth_service.dart';

class IzinTugasDinas extends StatefulWidget {
  const IzinTugasDinas({Key? key}) : super(key: key);

  @override
  State<IzinTugasDinas> createState() => _IzinTugasDinasState();
}

class _IzinTugasDinasState extends State<IzinTugasDinas> {
  String firstName = '';
  String lastName = '';
  String nik = '';
  String npsn = '';

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      firstName = preferences.getString("first_name")!;
      lastName = preferences.getString("last_name")!;
      nik = preferences.getString("nik")!;
      npsn = preferences.getString("npsn")!;
      namalengkap.text = firstName + ' ' + lastName;
      textNik.text = nik;
      textNpsn.text = npsn;
    });
  }

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController namalengkap = TextEditingController();
  TextEditingController textNik = TextEditingController();
  TextEditingController textNpsn = TextEditingController();
  TextEditingController tanggalpengajuan = TextEditingController();
  TextEditingController tanggalMulai = TextEditingController();
  TextEditingController tanggalBerakhir = TextEditingController();
  // TextEditingController jam = TextEditingController();
  TextEditingController keterangantugas = TextEditingController();
  TextEditingController pekerjaanditinggalkan = TextEditingController();
  TextEditingController tujuan = TextEditingController();

  bool _loading = false;

  bool waktumulai = false;
  bool waktuakhir = false;
  DateTime? _dateTimeAwal;
  String? waktu;

  String? _nameFile;
  // ignore: unused_field
  String? _filePath;

  List<PlatformFile>? _files;

  void fungsiPermohonanTugasDinas() async {
    showAlertDialog(context);
    String token = await getToken();
    Map<String, String> headers = {
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    };
    var uri = Uri.parse(baseURL + '/api/attendances/addduty');
    var request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath(
        'attachment', _files!.first.path.toString()));

    request.headers.addAll(headers);
    request.fields['duty_from_date'] = tanggalMulai.text;
    request.fields['duty_to_date'] = tanggalBerakhir.text;
    request.fields['time'] = waktu.toString();
    request.fields['place'] = keterangantugas.text;
    request.fields['abandoned_job'] = pekerjaanditinggalkan.text;
    request.fields['purpose'] = tujuan.text;
    var response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Permohonan Tugas Dinas Berhasil diajukan')));
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const CheckUserData()));
    } else if (response.statusCode == 400) {
      print(response.request);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Ada Kesalahan')));
      setState(() {
        _loading = !_loading;
      });
      Navigator.pop(context);
    }
  }

  void ambilFile() async {
    _files = (await FilePicker.platform.pickFiles(
            type: FileType.any, allowMultiple: false, allowedExtensions: null))!
        .files;

    setState(() {
      _nameFile = _files!.first.name;
    });

    print('Loaded file path is : ${_files!.first.path}');
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

  // void fungsiPermohonanTugasDinas() async {
  //   showAlertDialog(context);
  //   ApiResponse response = await permohonanTugasDinas(
  //       tanggalmulai: tanggalMulai.text,
  //       tanggalakhir: tanggalBerakhir.text,
  //       dokument: _files!.first.path.toString(),
  //       jam: jam.text,
  //       keterangantugas: keterangantugas.text,
  //       pekerjaanditinggalkan: pekerjaanditinggalkan.text,
  //       tujuan: tujuan.text);
  //   if (response.error == null) {
  //     Navigator.pop(context);
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text('Permohonan Tugas Dinas Berhasil diajukan')));
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => CheckUserData()));
  //   } else {
  //     print(response.error);
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(const SnackBar(content: Text('Ada Kesalahan')));
  //     setState(() {
  //       _loading = !_loading;
  //     });
  //     Navigator.pop(context);
  //   }
  // }

  @override
  void initState() {
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Tugas Dinas",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                      readOnly: true,
                      controller: namalengkap,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        // hintText: 'Email',
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "NUPTK / ID Pegawai",
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
                      readOnly: true,
                      controller: textNpsn,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        // hintText: 'Email',
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // const Text(
                //   "NIK",
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
                //       readOnly: true,
                //       controller: textNik,
                //       decoration: const InputDecoration(
                //         border: InputBorder.none,
                //         // hintText: 'Email',
                //       ),
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                // const Text(
                //   "Tanggal Pengajuan",
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
                //       controller: tanggalpengajuan,
                //       readOnly: true,
                //       decoration: const InputDecoration(
                //         border: InputBorder.none,
                //         hintText: 'dd/mm/yyyy',
                //       ),
                //       onTap: () async {
                //         DateTime? pickedDate1 = await showDatePicker(
                //             context: context,
                //             initialDate: DateTime.now(),
                //             firstDate: DateTime(2000),
                //             lastDate: DateTime(2101));

                //         if (pickedDate1 != null) {
                //           String formattedDate1 =
                //               DateFormat('yyyy-MM-dd').format(pickedDate1);
                //           print(formattedDate1);

                //           setState(() {
                //             tanggalpengajuan.text = formattedDate1;
                //           });
                //         } else {
                //           print("Date is not selected");
                //         }
                //       },
                //       // validator: (value) {
                //       //   if (value == null || value.isEmpty) {
                //       //     return 'Wajib Di isi';
                //       //   }
                //       //   return null;
                //       // },
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Tanggal Mulai",
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
                      controller: tanggalMulai,
                      readOnly: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: ImageIcon(
                            AssetImage('assets/icons/calendar_month.png')),
                        hintText: 'yyyy-mm-dd',
                      ),
                      onTap: () async {
                        DateTime? pickedDate2 = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101));

                        if (pickedDate2 != null) {
                          String formattedDate2 =
                              DateFormat('yyyy-MM-dd').format(pickedDate2);
                          print(formattedDate2);

                          setState(() {
                            tanggalMulai.text = formattedDate2;
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
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Tanggal Berakhir",
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
                      controller: tanggalBerakhir,
                      readOnly: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: ImageIcon(
                            AssetImage('assets/icons/calendar_month.png')),
                        hintText: 'yyyy-mm-dd',
                      ),
                      onTap: () async {
                        DateTime? pickedDate3 = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101));

                        if (pickedDate3 != null) {
                          String formattedDate3 =
                              DateFormat('yyyy-MM-dd').format(pickedDate3);
                          print(formattedDate3);

                          setState(() {
                            tanggalBerakhir.text = formattedDate3;
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
                // SizedBox(
                //   height: 10,
                // ),
                // Text(
                //   "Lama Hari",
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
                //       // controller: textEmail,
                //       decoration: InputDecoration(
                //         border: InputBorder.none,
                //         // hintText: 'Email',
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
                  "Jam",
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
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _dateTimeAwal == null
                              ? 'Jam'
                              : _dateTimeAwal!.hour.toString() +
                                  ' :' +
                                  _dateTimeAwal!.minute.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        waktumulai == false
                            ? InkWell(
                                onTap: () {
                                  setState(() {
                                    waktumulai = true;
                                  });
                                },
                                child: const SizedBox(
                                  height: 18,
                                  child: ImageIcon(
                                    AssetImage('assets/icons/oclock.png'),
                                  ),
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  setState(() {
                                    waktumulai = false;
                                  });
                                },
                                child: const SizedBox(
                                  height: 18,
                                  child: ImageIcon(
                                    AssetImage('assets/icons/oclock.png'),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                waktumulai == false
                    ? const SizedBox()
                    : TimePickerSpinner(
                        time: _dateTimeAwal,
                        is24HourMode: true,
                        normalTextStyle: const TextStyle(
                          fontSize: 14,
                          color: Color(0xff323337),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                        ),
                        highlightedTextStyle: const TextStyle(
                          fontSize: 20,
                          color: Color(0xff2E447C),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                        ),
                        spacing: 50,
                        isShowSeconds: false,
                        itemHeight: 60,
                        isForce2Digits: true,
                        minutesInterval: 1,
                        onTimeChange: (time) {
                          setState(() {
                            _dateTimeAwal = time;
                            String formattedTime =
                                DateFormat('HH:mm:ss').format(time);
                            waktu = formattedTime;
                            print(formattedTime);
                          });
                        },
                      ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Tempat",
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
                      controller: tujuan,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        // hintText: 'Email',
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
                  "Keterangan Tugas",
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
                      controller: keterangantugas,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        // hintText: 'Email',
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
                  "Upload Dokumen",
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
                            Icons.attachment,
                            color: Colors.grey,
                          ),
                          hintText: _nameFile == null
                              ? 'Pilih Dokumen'
                              : '$_nameFile'),
                      onTap: () {
                        ambilFile();
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Pekerjaan Yang Ditinggalkan",
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
                      controller: pekerjaanditinggalkan,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        // hintText: 'Email',
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
                  height: 20,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      if (_key.currentState!.validate()) {
                        setState(() {
                          showAlertDialog(context);
                        });
                        fungsiPermohonanTugasDinas();
                      }
                    },
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 45,
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
                          "Simpan",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              letterSpacing: 1),
                        )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

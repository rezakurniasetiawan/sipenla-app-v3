import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/screens/check_userdata.dart';
import 'package:siakad_app/services/absensi_service.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:http/http.dart' as http;

class IzinCutiPegawai extends StatefulWidget {
  const IzinCutiPegawai({Key? key}) : super(key: key);

  @override
  State<IzinCutiPegawai> createState() => _IzinCutiPegawaiState();
}

class _IzinCutiPegawaiState extends State<IzinCutiPegawai> {
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
  TextEditingController tanggalPengajuan = TextEditingController();
  TextEditingController tanggalMulai = TextEditingController();
  TextEditingController tanggalBerakhir = TextEditingController();
  TextEditingController keterangancuti = TextEditingController();
  TextEditingController pekerjaanditinggalkan = TextEditingController();

  bool _loading = false;
  // ignore: prefer_typing_uninitialized_variables
  var dropdownvalue;

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

  void fungsiPermohonanCuti() async {
    showAlertDialog(context);
    ApiResponse response = await permohonanCuti(
        jeniscuti: dropdownvalue,
        keterangancuti: keterangancuti.text,
        pekerjaanditinggalkan: pekerjaanditinggalkan.text,
        tanggalmulai: tanggalMulai.text,
        tanggalakhir: tanggalBerakhir.text);
    if (response.error == null) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Permohonan Cuti Berhasil diajukan')));
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const CheckUserData()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Ada Kesalahan')));
      setState(() {
        _loading = !_loading;
      });
      Navigator.pop(context);
    }
  }

  // ignore: non_constant_identifier_names
  List Itemlist = [];
  int? kuotaku;
  Future getJenisCuti() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(baseURL + '/api/attendances/gettype'),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body)['data']['leave_type'];
      var jsonData2 = json.decode(response.body)['data']['leave_quota'];
      setState(() {
        Itemlist = jsonData;
        kuotaku = jsonData2;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPref();
    getJenisCuti();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Izin / Cuti",
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
                  "Jenis Cuti",
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
                        hint: const Text('Pilih jenis cuti'),
                        items: Itemlist.map((item) {
                          return DropdownMenuItem(
                            value: item['leave_type_id'].toString(),
                            child: Text(item['leave_type_name'].toString()),
                          );
                        }).toList(),
                        menuMaxHeight: 250,
                        onChanged: (newVal) {
                          setState(() {
                            dropdownvalue = newVal;
                            // ignore: avoid_print
                            print(dropdownvalue);
                          });
                        },
                        value: dropdownvalue,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
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
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                      controller: namalengkap,
                      readOnly: true,
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
                      controller: textNpsn,
                      readOnly: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        // hintText: 'Email',
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
                // const SizedBox(
                //   height: 10,
                // ),
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
                //       validator: (value) {
                //         if (value == null || value.isEmpty) {
                //           return 'Wajib Di isi';
                //         }
                //         return null;
                //       },
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Kuota Cuti Tahunan",
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
                      // controller: kuotaCuti,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '$kuotaku',
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
                //       controller: tanggalPengajuan,
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
                //           // ignore: avoid_print
                //           print(pickedDate1);
                //           String formattedDate1 =
                //               DateFormat('yyyy-MM-dd').format(pickedDate1);
                //           // ignore: avoid_print
                //           print(formattedDate1);

                //           setState(() {
                //             tanggalPengajuan.text = formattedDate1;
                //           });
                //         } else {
                //           // ignore: avoid_print
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
                          // ignore: avoid_print
                          print(pickedDate2);
                          String formattedDate2 =
                              DateFormat('yyyy-MM-dd').format(pickedDate2);
                          // ignore: avoid_print
                          print(formattedDate2);

                          setState(() {
                            tanggalMulai.text = formattedDate2;
                          });
                        } else {
                          // ignore: avoid_print
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
                          // ignore: avoid_print
                          print(pickedDate3);
                          String formattedDate3 =
                              DateFormat('yyyy-MM-dd').format(pickedDate3);
                          // ignore: avoid_print
                          print(formattedDate3);

                          setState(() {
                            tanggalBerakhir.text = formattedDate3;
                          });
                        } else {
                          // ignore: avoid_print
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
                // const SizedBox(
                //   height: 10,
                // ),
                // const Text(
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
                //       decoration: const InputDecoration(
                //         border: InputBorder.none,
                //         // hintText: 'Email',
                //       ),
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
                  "Keterangan Cuti",
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
                      controller: keterangancuti,
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
                      if (dropdownvalue == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Jenis Cuti Wajib di isi')));
                      } else if (_key.currentState!.validate()) {
                        setState(() {
                          showAlertDialog(context);
                        });
                        fungsiPermohonanCuti();
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
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

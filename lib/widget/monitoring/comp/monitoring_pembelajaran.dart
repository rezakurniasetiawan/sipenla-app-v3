import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:siakad_app/widget/monitoring/comp/absen_monitoring_pembelajaran.dart';

class MonitoringPembelajaran extends StatefulWidget {
  const MonitoringPembelajaran({Key? key, required this.imageTeacher})
      : super(key: key);

  final String imageTeacher;

  @override
  State<MonitoringPembelajaran> createState() => _MonitoringPembelajaranState();
}

class _MonitoringPembelajaranState extends State<MonitoringPembelajaran> {
  final String hari = DateFormat('dd').format(DateTime.now());
  final String bulan = DateFormat('MMMM').format(DateTime.now());
  final String tahun = DateFormat('yyyy').format(DateTime.now());
  final String waktu = DateFormat('KK : mm : ss').format(DateTime.now());
  // ignore: prefer_typing_uninitialized_variables
  var valueMapel;
  // ignore: prefer_typing_uninitialized_variables
  var valueKelas;

  String mapelName = '';
  String kelasName = '';

  List mapelList = [];
  List kelasList = [];

  Future getMapel() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(baseURL + '/api/monitoring/getsubject'),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body)['data'];
      setState(() {
        mapelList = jsonData;
      });
    }
  }

  Future getKelas() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(baseURL + '/api/monitoring/getgrade'),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body)['data'];
      setState(() {
        kelasList = jsonData;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getMapel();
    getKelas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Monitoring Pembelajaran',
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
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     SizedBox(
              //         height: 70,
              //         width: 70,
              //         child: CachedNetworkImage(
              //           imageUrl: widget.imageTeacher,
              //           fit: BoxFit.cover,
              //           imageBuilder: (context, imageProvider) => Container(
              //             width: 70.0,
              //             height: 70.0,
              //             decoration: BoxDecoration(
              //               shape: BoxShape.circle,
              //               image: DecorationImage(
              //                   image: imageProvider, fit: BoxFit.cover),
              //             ),
              //           ),
              //           placeholder: (context, url) => Shimmer(
              //               child: Container(
              //                 decoration: BoxDecoration(
              //                   color: Colors.grey,
              //                   borderRadius: BorderRadius.circular(50),
              //                 ),
              //               ),
              //               gradient: const LinearGradient(stops: [
              //                 0.2,
              //                 0.5,
              //                 0.6
              //               ], colors: [
              //                 Colors.grey,
              //                 Colors.white12,
              //                 Colors.grey,
              //               ])),
              //           errorWidget: (context, url, error) =>
              //               const Icon(Icons.error),
              //         )),
              //     const SizedBox(
              //       width: 10,
              //     ),
              //     Column(
              //       children: [
              //         Text(
              //           hari + ' ' + bulan + ' ' + tahun,
              //           style: const TextStyle(
              //             fontSize: 16,
              //             color: Color(0xff4B556B),
              //             fontFamily: 'Poppins',
              //             fontWeight: FontWeight.w700,
              //           ),
              //         ),
              //         const SizedBox(
              //           height: 1,
              //         ),
              //         Container(
              //           height: 2,
              //           width: 120,
              //           color: const Color(0xff4B556B),
              //         ),
              //         const SizedBox(
              //           height: 1,
              //         ),
              //         Text(
              //           waktu,
              //           style: const TextStyle(
              //             fontSize: 16,
              //             color: Color(0xff4B556B),
              //             fontFamily: 'Poppins',
              //             fontWeight: FontWeight.w700,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),

              Container(
                height: 48,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color(0xffF0F1F2),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      icon: const ImageIcon(
                        AssetImage('assets/icons/arrow-down.png'),
                      ),
                      dropdownColor: const Color(0xffF0F1F2),
                      borderRadius: BorderRadius.circular(15),
                      hint: const Text('Mata Pelajaran'),
                      items: mapelList.map((item) {
                        return DropdownMenuItem(
                          value: item['subject_id'].toString(),
                          child: Text(item['subject_name'].toString()),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          valueMapel = newVal;
                          // ignore: avoid_print
                          print(valueMapel);
                        });
                      },
                      value: valueMapel,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 48,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color(0xffF0F1F2),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      icon: const ImageIcon(
                        AssetImage('assets/icons/arrow-down.png'),
                      ),
                      dropdownColor: const Color(0xffF0F1F2),
                      borderRadius: BorderRadius.circular(15),
                      hint: const Text('Kelas'),
                      items: kelasList.map((item) {
                        return DropdownMenuItem(
                          value: item['grade_id'].toString(),
                          child: Text(
                            item['grade_name'].toString(),
                          ),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          valueKelas = newVal;
                          // ignore: avoid_print
                          print(valueKelas);
                        });
                      },
                      value: valueKelas,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  if (valueMapel == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Mata Pelajaran tidak boleh kosong')));
                  } else if (valueKelas == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Kelas tidak boleh kosong')));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AbsenMonitoringPembelajaran(
                                  mapelId: int.parse(valueMapel),
                                  kelasId: int.parse(valueKelas),
                                )));
                  }
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
    );
  }
}

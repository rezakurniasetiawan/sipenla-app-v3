import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:siakad_app/services/auth_service.dart';

import '../../../constan.dart';
import 'input_penilaian_ekstra.dart';

class PilihPenilaianEkstra extends StatefulWidget {
  const PilihPenilaianEkstra({Key? key, required this.idEkstraPembina, required this.ekstraPembinaName})
      : super(key: key);

  final int idEkstraPembina;
  final String ekstraPembinaName;

  @override
  State<PilihPenilaianEkstra> createState() => _PilihPenilaianEkstraState();
}

class _PilihPenilaianEkstraState extends State<PilihPenilaianEkstra> {
  var valueTahunAkademikk;
  var valueSemester;

  List tahunAkademikList = [];
  List semesterlist = [];

  Future getTahunAkademik() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(baseURL + '/api/assessment/getacademic'),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body)['data'];
      setState(() {
        tahunAkademikList = jsonData;
      });
    }
  }

  Future getSemester() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(baseURL + '/api/assessment/getsemester'),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body)['data'];
      setState(() {
        semesterlist = jsonData;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getTahunAkademik();
    getSemester();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Penilaian",
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
        child: Column(
          children: [
            const SizedBox(
              height: 10,
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
                    hint: const Text('Tahun Ajaran'),
                    items: tahunAkademikList.map((item) {
                      return DropdownMenuItem(
                        value: item['academic_year_id'].toString(),
                        child: Text(item['academic_year'].toString()),
                      );
                    }).toList(),
                    onChanged: (newVal) {
                      setState(() {
                        valueTahunAkademikk = newVal;
                        print(valueTahunAkademikk);
                      });
                    },
                    value: valueTahunAkademikk,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
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
                    hint: const Text('Semester'),
                    items: semesterlist.map((item) {
                      return DropdownMenuItem(
                        value: item['semester_id'].toString(),
                        child: Text(item['semester_name'].toString()),
                      );
                    }).toList(),
                    onChanged: (newVal) {
                      setState(() {
                        valueSemester = newVal;
                        print(valueSemester);
                      });
                    },
                    value: valueSemester,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                if (valueSemester == null) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Semester tidak boleh kosong')));
                } else if (valueTahunAkademikk == null) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Tahun Ajaran tidak boleh kosong')));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InputPenilaianEkstra(
                                idAkademik: valueTahunAkademikk,
                                idSemester: valueSemester,
                                idEkstraPembina: widget.idEkstraPembina, nameekstraPembina: widget.ekstraPembinaName,
                              )));
                }
              },
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 45,
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
                    "Lanjutkan",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
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
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/fasilitas_model.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:siakad_app/services/fasilitas_service.dart';
import 'package:http/http.dart' as http;

class DataFasilitasDispen extends StatefulWidget {
  const DataFasilitasDispen({Key? key}) : super(key: key);

  @override
  State<DataFasilitasDispen> createState() => _DataFasilitasDispenState();
}

class _DataFasilitasDispenState extends State<DataFasilitasDispen> {
  static int _len = 50;
  List<bool> isChecked1 = List.generate(_len, (index) => false);
  List<bool> isChecked2 = List.generate(_len, (index) => false);

  MappingFasilitasDispenModel mappingFasilitasDispenModel =
      MappingFasilitasDispenModel(books: []);

  bool _loading = true;
  List<dynamic> _FasilitasList = [];

  Future<void> fungsiGetFasilitasAll() async {
    ApiResponse response = await getFasilitasDispenAll();
    if (response.error == null) {
      setState(() {
        _FasilitasList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const GetStartedScreen()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
      ));
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

  void send() async {
    showAlertDialog(context);
    String token = await getToken();
    var response = await http.post(
      Uri.parse(baseURL + '/api/facility/updatediknas'),
      headers: {
        "Content-type": "application/json",
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
      body: json.encode(mappingFasilitasDispenModel.toJson()),
    );
    print(response.body);
    if (response.statusCode == 200) {
      print('OKe');
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Berhasil Mengupdate Status Fasilitas')));
      setState(() {
        fungsiGetFasilitasAll();
      });
    } else if (response.statusCode == 400) {
      String respon = json.decode(response.body)['meta']['message'];
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${respon}')));
    }
  }

  @override
  void initState() {
    super.initState();
    fungsiGetFasilitasAll();
    mappingFasilitasDispenModel.books = <Book>[];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Data Fasilitas",
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
      body: Column(
        children: [
          const Center(
            child: Text(
              "Bulan Januari",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff4B556B),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Center(
            child: Text(
              "2022",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff4B556B),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: mappingFasilitasDispenModel.books.length,
                itemBuilder: (BuildContext context, int index) => Column(
                      children: <Widget>[
                        Text(mappingFasilitasDispenModel.books[index].facilityId
                            .toString()),
                        Text(mappingFasilitasDispenModel.books[index].status),
                        const SizedBox(
                          height: 30,
                        )
                      ],
                    )),
          ),
          _loading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blueAccent,
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: _FasilitasList.length,
                    itemBuilder: (BuildContext context, int index) {
                      DispenFasilitasModel dispenFasilitasModel =
                          _FasilitasList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            Container(
                              height: 180,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xff4B556B),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          width: 130,
                                          child: Text(
                                            "Kode Fasilitas",
                                            style: TextStyle(
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
                                            dispenFasilitasModel.facilityCode,
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
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          width: 130,
                                          child: Text(
                                            "Nama Fasilitas",
                                            style: TextStyle(
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
                                            dispenFasilitasModel.facilityName,
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
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          width: 130,
                                          child: Text(
                                            "Jumlah Fasilitas",
                                            style: TextStyle(
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
                                            dispenFasilitasModel
                                                .numberOfFacility,
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
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          width: 130,
                                          child: Text(
                                            "Status",
                                            style: TextStyle(
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
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 30,
                                                  height: 30,
                                                  child: Checkbox(
                                                    onChanged: (checked) {
                                                      setState(
                                                        () {
                                                          isChecked1[index] =
                                                              checked!;
                                                          if (isChecked1[
                                                                  index] ==
                                                              true) {
                                                            mappingFasilitasDispenModel
                                                                .books
                                                                .add(Book(
                                                                    facilityId:
                                                                        dispenFasilitasModel
                                                                            .facilityId,
                                                                    status:
                                                                        'fcl'));
                                                          } else {
                                                            isChecked2[index] =
                                                                false;
                                                            if (mappingFasilitasDispenModel
                                                                .books
                                                                .any((element) =>
                                                                    element
                                                                        .status ==
                                                                    'fcl')) {
                                                              mappingFasilitasDispenModel
                                                                  .books
                                                                  .removeWhere((element) =>
                                                                      element
                                                                          .facilityId ==
                                                                      dispenFasilitasModel
                                                                          .facilityId);
                                                            }
                                                          }
                                                        },
                                                      );
                                                    },
                                                    value: isChecked1[index],
                                                  ),
                                                ),
                                                const Text(
                                                  "Layak",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'Poppins',
                                                    color: Color(0xff2E447C),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 30,
                                                  height: 30,
                                                  child: Checkbox(
                                                    onChanged: (checked) {
                                                      setState(
                                                        () {
                                                          isChecked2[index] =
                                                              checked!;
                                                          if (isChecked2[
                                                                  index] ==
                                                              true) {
                                                            mappingFasilitasDispenModel
                                                                .books
                                                                .add(Book(
                                                                    facilityId:
                                                                        dispenFasilitasModel
                                                                            .facilityId,
                                                                    status:
                                                                        'ftl'));
                                                          } else {
                                                            isChecked1[index] =
                                                                false;
                                                            if (mappingFasilitasDispenModel
                                                                .books
                                                                .any((element) =>
                                                                    element
                                                                        .status ==
                                                                    'ftl')) {
                                                              mappingFasilitasDispenModel
                                                                  .books
                                                                  .removeWhere((element) =>
                                                                      element
                                                                          .facilityId ==
                                                                      dispenFasilitasModel
                                                                          .facilityId);
                                                            }
                                                          }
                                                        },
                                                      );
                                                    },
                                                    value: isChecked2[index],
                                                  ),
                                                ),
                                                const Text(
                                                  "Tidak Layak",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'Poppins',
                                                    color: Color(0xff2E447C),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: GestureDetector(
              onTap: () {
                send();
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
                    "Selesai",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      color: Colors.white,
                    ),
                  )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

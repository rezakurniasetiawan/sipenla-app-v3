// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/fasilitas_model.dart';
import 'package:http/http.dart' as http;
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:siakad_app/services/fasilitas_service.dart';

class MapPeminjamanFasilitas extends StatefulWidget {
  const MapPeminjamanFasilitas({
    Key? key,
    required this.idFas,
    required this.jumlahFas,
    required this.tanggalakhir,
    required this.tanggalawal,
    required this.nameFas,
    required this.codeFas,
    required this.imageFas,
  }) : super(key: key);

  final int idFas, jumlahFas;
  final String tanggalawal, tanggalakhir, nameFas, codeFas, imageFas;

  @override
  State<MapPeminjamanFasilitas> createState() => _MapPeminjamanFasilitasState();
}

class _MapPeminjamanFasilitasState extends State<MapPeminjamanFasilitas> {
  TextEditingController code = TextEditingController();

  TextEditingController idFas = TextEditingController();
  TextEditingController jumlahFas = TextEditingController();
  TextEditingController tanggalakhir = TextEditingController();
  TextEditingController tanggalawal = TextEditingController();

  TextEditingController nameFas = TextEditingController();
  TextEditingController codeFas = TextEditingController();
  String imageFas = '';

  PengajuanFasilitasModel pengajuanFasilitasModel =
      PengajuanFasilitasModel(books: []);

  PengajuanFasilitasMappingModel pengajuanFasilitasMappingModel =
      PengajuanFasilitasMappingModel(books: []);

  FasilitasModel? fasilitasModel;
  bool loading = true;

  var valueFasilitas;
  List fasilitasllist = [];

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

  void fungsiSeacrchFasilitas() async {
    showAlertDialog(context);
    ApiResponse response = await searchFasilitas(code: code.text);
    if (response.error == null) {
      setState(() {
        fasilitasModel = response.data as FasilitasModel;
        loading = false;
        valueFasilitas = fasilitasModel!.facilityId.toString();
        fungsiGetFasilitasById();
        Navigator.pop(context);
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

  void fungsiGetFasilitasById() async {
    showAlertDialog(context);
    ApiResponse response =
        await getFasilitasbyId(idFas: valueFasilitas.toString());
    if (response.error == null) {
      setState(() {
        fasilitasModel = response.data as FasilitasModel;
        nameFas.text = fasilitasModel!.facilityName;
        codeFas.text = fasilitasModel!.facilityCode;
        imageFas = fasilitasModel!.image;
        print(fasilitasModel!.image);
        Navigator.pop(context);
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

  Future getFasilitas() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(baseURL + '/api/facility/getfacility'),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body)['data'];
      setState(() {
        fasilitasllist = jsonData;
      });
    }
  }

  void mappingData() {
    print(idFas.text);
    pengajuanFasilitasModel.books.add(Bookss(
        facilityId: int.parse(idFas.text),
        totalFacility: int.parse(jumlahFas.text),
        fromDate: int.parse(tanggalawal.text),
        toDate: int.parse(tanggalakhir.text)));
    pengajuanFasilitasMappingModel.books.add(Booksss(
        facilityId: int.parse(idFas.text),
        totalFacility: int.parse(jumlahFas.text),
        fromDate: int.parse(tanggalawal.text),
        toDate: int.parse(tanggalakhir.text),
        codeFas: codeFas.text,
        nameFas: nameFas.text,
        imageFas: imageFas));

    setState(() {
      idFas.clear();
      valueFasilitas = null;
      jumlahFas.clear();
      tanggalakhir.clear();
      codeFas.clear();
      nameFas.clear();
      imageFas = '';
    });
  }

  void send() async {
    showAlertDialog(context);
    String token = await getToken();
    var response = await http.post(
      Uri.parse(baseURL + '/api/facility/createloan'),
      headers: {
        "Content-type": "application/json",
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
      body: json.encode(pengajuanFasilitasModel.toJson()),
    );
    print(response.body);
    print(response.statusCode);
    print(json.encode(pengajuanFasilitasModel.toJson()));

    if (response.statusCode == 200) {
      print('OKe');
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Berhasil Melakukan Pengajuan Fasilitas')));
      Navigator.pop(context);
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
    idFas.text = widget.idFas.toString();
    jumlahFas.text = widget.jumlahFas.toString();
    tanggalakhir.text = widget.tanggalakhir;
    tanggalawal.text = widget.tanggalawal;
    nameFas.text = widget.nameFas;
    codeFas.text = widget.codeFas;
    imageFas = widget.imageFas;
    pengajuanFasilitasModel.books = <Bookss>[];
    pengajuanFasilitasMappingModel.books = <Booksss>[];
    mappingData();
    getFasilitas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Peminjaman Fasilitas",
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
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: pengajuanFasilitasModel.books.length,
          //     itemBuilder: (BuildContext context, int index) => Column(
          //       children: <Widget>[
          //         Text(pengajuanFasilitasModel.books[index].facilityId
          //             .toString()),
          //         Text(pengajuanFasilitasModel.books[index].totalFacility
          //             .toString()),
          //         Text(
          //             pengajuanFasilitasModel.books[index].fromDate.toString()),
          //         Text(pengajuanFasilitasModel.books[index].toDate.toString()),
          //         TextButton(
          //             onPressed: () {
          //               setState(() {
          //                 pengajuanFasilitasMappingModel.books.removeWhere(
          //                     (element) =>
          //                         element.facilityId ==
          //                         pengajuanFasilitasModel
          //                             .books[index].facilityId);
          //                 pengajuanFasilitasModel.books.removeWhere((element) =>
          //                     element.facilityId ==
          //                     pengajuanFasilitasModel.books[index].facilityId);
          //                 print('Hapus Sukses');
          //               });
          //             },
          //             child: Text('Hapus'))
          //       ],
          //     ),
          //   ),
          // ),
          Expanded(
            child: ListView.builder(
              itemCount: pengajuanFasilitasMappingModel.books.length,
              itemBuilder: (BuildContext context, int index) => Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 83,
                          height: 116,
                          child: CachedNetworkImage(
                            imageUrl: pengajuanFasilitasMappingModel
                                .books[index].imageFas,
                            fit: BoxFit.cover,
                            imageBuilder: (context, imageProvider) => Container(
                              width: 83.0,
                              height: 116.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            placeholder: (context, url) => Shimmer(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(12),
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
                                ])),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Kode Fasilitas',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff4B556B),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                pengajuanFasilitasMappingModel
                                    .books[index].codeFas,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Color(0xff4B556B),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                'Nama Fasilitas',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff4B556B),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                pengajuanFasilitasMappingModel
                                    .books[index].nameFas,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Color(0xff4B556B),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                'Jumlah',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff4B556B),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                pengajuanFasilitasMappingModel
                                    .books[index].totalFacility
                                    .toString(),
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Color(0xff4B556B),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              pengajuanFasilitasModel.books.removeWhere(
                                  (element) =>
                                      element.facilityId ==
                                      pengajuanFasilitasMappingModel
                                          .books[index].facilityId);
                              pengajuanFasilitasMappingModel.books.removeWhere(
                                  (element) =>
                                      element.facilityId ==
                                      pengajuanFasilitasMappingModel
                                          .books[index].facilityId);
                              print('Hapus Sukses');
                            });
                            Navigator.pop(context);
                          },
                          icon: const ImageIcon(
                            AssetImage(
                              "assets/icons/delete-news.png",
                            ),
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      // isDismissible: false,
                      builder: (context) {
                        return SizedBox(
                          height: 800,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(Icons.arrow_back)),
                                  const Text(
                                    "Peminjaman Fasilitas",
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
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Kode Fasilitas",
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
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: TextField(
                                          controller: code,
                                          textInputAction: TextInputAction.go,
                                          onSubmitted: (value) {
                                            fungsiSeacrchFasilitas();
                                            FocusScope.of(context).nextFocus();
                                          },
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Pencarian',
                                            suffixIcon: Icon(Icons.search),
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
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            icon: const ImageIcon(
                                              AssetImage(
                                                  'assets/icons/arrow-down.png'),
                                            ),
                                            dropdownColor:
                                                const Color(0xffF0F1F2),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            hint: const Text('Fasilitas'),
                                            items: fasilitasllist.map((item) {
                                              return DropdownMenuItem(
                                                value: item['facility_id']
                                                    .toString(),
                                                child: Text(
                                                    item['facility_name']
                                                        .toString()),
                                              );
                                            }).toList(),
                                            onChanged: (newVal) {
                                              setState(() {
                                                valueFasilitas = newVal;
                                                fungsiGetFasilitasById();
                                                FocusScope.of(context)
                                                    .nextFocus();
                                                print(valueFasilitas);
                                              });
                                            },
                                            value: valueFasilitas,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Jumlah Fasilitas",
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
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: TextFormField(
                                          controller: jumlahFas,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText:
                                                'Masukkan Jumlah Fasilitas',
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Wajib Di isi';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      "Tanggal Selesai Pinjam",
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
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: TextFormField(
                                          controller: tanggalakhir,
                                          readOnly: true,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'dd/mm/yyyy',
                                          ),
                                          onTap: () async {
                                            DateTime? pickedDate =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2000),
                                                    lastDate: DateTime(2101));

                                            if (pickedDate != null) {
                                              // print(pickedDate);
                                              String formattedDate =
                                                  DateFormat('yyyyMMdd')
                                                      .format(pickedDate);
                                              print(formattedDate);

                                              setState(() {
                                                tanggalakhir.text =
                                                    formattedDate;
                                              });
                                            } else {
                                              print("Date is not selected");
                                            }
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.43,
                                            height: 45,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: const Color(0xff2E447C),
                                              ),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                "Batal",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Poppins',
                                                    color: Color(0xff2E447C),
                                                    letterSpacing: 1),
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            if (valueFasilitas == null) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'Fasilitas Tidak Boleh Kosong')));
                                            } else if (jumlahFas.text == '') {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'Jumlah Tidak Boleh Kosong')));
                                            } else if (tanggalakhir.text ==
                                                '') {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'Tanggal Tidak Boleh Kosong')));
                                            } else {
                                              idFas.text =
                                                  valueFasilitas.toString();
                                              mappingData();
                                              Navigator.pop(context);
                                            }
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.43,
                                            height: 45,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              gradient: const LinearGradient(
                                                begin:
                                                    FractionalOffset.centerLeft,
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
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.43,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xff2E447C),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "Tambah Fasilitas",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                              color: Color(0xff2E447C),
                              letterSpacing: 1),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    send();
                  },
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.43,
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
                        "Pinjam",
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

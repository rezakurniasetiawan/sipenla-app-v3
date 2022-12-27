import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../constan.dart';
import '../../../../models/api_response_model.dart';
import '../../../../screens/started_screen.dart';
import '../../../../services/auth_service.dart';
import '../../../../services/perpustakaan/pengguna_perpus_service.dart';

class SumbangBukuPengguna extends StatefulWidget {
  const SumbangBukuPengguna({Key? key}) : super(key: key);

  @override
  State<SumbangBukuPengguna> createState() => _SumbangBukuPenggunaState();
}

class _SumbangBukuPenggunaState extends State<SumbangBukuPengguna> {
  TextEditingController namabuku = TextEditingController();
  TextEditingController hargabuku = TextEditingController();
  TextEditingController pengarang = TextEditingController();
  TextEditingController tahun = TextEditingController();
  TextEditingController jumlah = TextEditingController();

  File? _imageFile;
  final _picker = ImagePicker();
  bool _loading = true;
  DateTime _selected = DateTime.now();
  DateTime? trueselected;
  Future getImage() async {
    // ignore: deprecated_member_use
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

  void fungsiSumbangBuku() async {
    showAlertDialog(context);
    String? image = _imageFile == null ? null : getStringImage(_imageFile);
    ApiResponse response = await createSumbangBuku(
        bookcreator: pengarang.text,
        bookimage: image,
        bookname: namabuku.text,
        bookprice: hargabuku.text,
        bookyear: tahun.text,
        numberofbook: jumlah.text);
    if (response.error == null) {
      print("Create Suskses");
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Berhasil Sumbang Buku')));
      setState(() {
        Navigator.pop(context, 'refresh');
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
          .showSnackBar(const SnackBar(content: Text('Ada Kesalahan')));
      setState(() {
        _loading = !_loading;
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Sumbang Buku",
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
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Nama Buku",
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
                            child: TextField(
                              controller: namabuku,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Masukkan Nama Buku',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Harga Buku",
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
                            child: TextField(
                              controller: hargabuku,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Masukkan Harga Buku',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Pengarang",
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
                              controller: pengarang,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Masukkan Pengarang Buku',
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
                          "Tahun BUku",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                            color: Color(0xff4B556B),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Pilih Tahun"),
                                  content: Container(
                                    width: 300,
                                    height: 300,
                                    child: YearPicker(
                                      firstDate: DateTime(
                                          DateTime.now().year - 100, 1),
                                      lastDate: DateTime(
                                          DateTime.now().year + 100, 1),
                                      // initialDate: DateTime.now(),
                                      selectedDate: trueselected == null
                                          ? _selected
                                          : trueselected!,
                                      onChanged: (DateTime dateTime) {
                                        // close the dialog when year is selected.
                                        print(dateTime.year);
                                        setState(() {
                                          trueselected = dateTime;
                                          tahun.text = dateTime.year.toString();
                                        });
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            height: 48,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: const Color(0xffF0F1F2),
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    tahun.text == '' ? 'yyyy' : tahun.text,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 18,
                                    child: ImageIcon(
                                      AssetImage(
                                          'assets/icons/calendar_month.png'),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Jumlah BUku",
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
                              controller: jumlah,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Masukkan Jumlah Buku',
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
                          "Unggah Foto",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                            color: Color(0xff4B556B),
                          ),
                        ),
                        SizedBox(
                          height: 185,
                          width: MediaQuery.of(context).size.width,
                          child: Stack(
                            fit: StackFit.expand,
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: 185,
                                height: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey[100],
                                  image: _imageFile == null
                                      ? const DecorationImage(
                                          image: AssetImage(
                                              'assets/image/image-not-available.jpg'),
                                          fit: BoxFit.cover)
                                      : DecorationImage(
                                          image:
                                              FileImage(_imageFile ?? File('')),
                                          fit: BoxFit.cover),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: -10,
                                child: InkWell(
                                  onTap: () {
                                    getImage();
                                  },
                                  child: SizedBox(
                                    height: 43,
                                    width: 43,
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Image.asset(
                                          'assets/icons/add-news.png'),
                                    ),
                                    // child: FlatButton(
                                    //   shape: RoundedRectangleBorder(
                                    //     borderRadius: BorderRadius.circular(50),
                                    //     side: const BorderSide(
                                    //         color: Colors.white, width: 2),
                                    //   ),
                                    //   // color: const Color(0xff3774C3),
                                    //   onPressed: () {
                                    //     getImage();
                                    //   },
                                    //   child: Image.asset(
                                    //     'assets/icons/add-news.png',
                                    //     color: Colors.white,
                                    //   ),
                                    // ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: GestureDetector(
                onTap: () {
                  // if (valueFasilitas == null) {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //       const SnackBar(
                  //           content: Text('Fasilitas Tidak Boleh Kosong')));
                  // } else if (jumlah.text == '') {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //       const SnackBar(
                  //           content: Text('Jumlah Tidak Boleh Kosong')));
                  // } else if (tanggal.text == '') {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //       const SnackBar(
                  //           content: Text('Tanggal Tidak Boleh Kosong')));
                  // } else {
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => MapPeminjamanFasilitas(
                  //                 idFas: int.parse(valueFasilitas),
                  //                 jumlahFas: int.parse(jumlah.text),
                  //                 tanggalakhir: tanggal.text,
                  //                 tanggalawal: datenow,
                  //                 codeFas: codeFas.text,
                  //                 nameFas: nameFas.text,
                  //                 imageFas: imageFas,
                  //               )));
                  // }
                  fungsiSumbangBuku();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
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
          ],
        ));
  }
}

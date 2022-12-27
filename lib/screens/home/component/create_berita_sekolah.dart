// ignore_for_file: unnecessary_new, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/screens/tab_screen.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:siakad_app/services/news_school_service.dart';

class CreateBeritaSekolah extends StatefulWidget {
  const CreateBeritaSekolah({Key? key}) : super(key: key);

  @override
  State<CreateBeritaSekolah> createState() => _CreateBeritaSekolahState();
}

class _CreateBeritaSekolahState extends State<CreateBeritaSekolah> {
  bool _loading = false;
  bool isChecked = false;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController textTitle = TextEditingController();
  TextEditingController textDesc = TextEditingController();

  File? _imageFile;
  final _picker = ImagePicker();

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
      content: new Row(
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

  check() {
    final form = _key.currentState!;
    // ignore: unnecessary_null_comparison
    if (_imageFile == null || textTitle.text == null || textDesc.text == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Harus di isi semua')));
    } else {
      if (form.validate()) {
        form.save();
        fungsiCreateNews();
      }
    }
  }

  void fungsiCreateNews() async {
    showAlertDialog(context);
    String? image = _imageFile == null ? null : getStringImage(_imageFile);
    ApiResponse response = await createNews(
        title: textTitle.text, image: image, content: textDesc.text);
    if (response.error == null) {
      print("Upload Suskses");
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Berhasil Menambahkan Berita Sekolah')));
      setState(() {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const TabScreen()));
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Berita Dan Pengumuman",
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
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Unggah Foto",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: Color(0xff4B556B),
                  ),
                ),
                const SizedBox(
                  height: 10,
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
                                  image: FileImage(_imageFile ?? File('')),
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
                              child: Image.asset('assets/icons/add-news.png'),
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
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Judul",
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
                      controller: textTitle,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        // hintText: 'Masukkan NIK',
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Deskripsi",
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
                      maxLines: 8,
                      controller: textDesc,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Text(
                      "Landing Page :",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    SizedBox(
                      width: 25,
                      child: Checkbox(
                          value: isChecked,
                          onChanged: (value) {
                            isChecked = !isChecked;
                            setState(() {});
                          }),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      check();
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

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constan.dart';
import '../../../models/api_response_model.dart';
import '../../../models/perpustakaan/pegawai_perpus_model.dart';
import '../../../screens/started_screen.dart';
import '../../../services/auth_service.dart';
import '../../../services/perpustakaan/data_buku_service.dart';

class EditBukuPerpus extends StatefulWidget {
  const EditBukuPerpus({Key? key, required this.dataBukuPerpusModel})
      : super(key: key);

  final DataBukuPerpusModel dataBukuPerpusModel;

  @override
  State<EditBukuPerpus> createState() => _EditBukuPerpusState();
}

class _EditBukuPerpusState extends State<EditBukuPerpus> {
  bool _loading = true;
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

  TextEditingController namabuku = TextEditingController();
  TextEditingController hargabuku = TextEditingController();
  TextEditingController pengarang = TextEditingController();
  TextEditingController tahun = TextEditingController();
  TextEditingController jumlah = TextEditingController();

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

  void fungsiUpdateBuku(int idBook) async {
    showAlertDialog(context);
    String? image = _imageFile == null ? null : getStringImage(_imageFile);
    ApiResponse response = await updateBookPerpus(
        idbook: idBook.toString(),
        bookcreator: pengarang.text,
        bookimage: image,
        bookname: namabuku.text,
        bookprice: hargabuku.text,
        bookyear: tahun.text,
        numberofbook: jumlah.text);
    if (response.error == null) {
      print("Delete Suskses");
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Berhasil Menghapus Buku')));
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
  void initState() {
    super.initState();
    namabuku.text = widget.dataBukuPerpusModel.bookName;
    hargabuku.text = widget.dataBukuPerpusModel.bookPrice;
    pengarang.text = widget.dataBukuPerpusModel.bookCreator;
    tahun.text = widget.dataBukuPerpusModel.bookYear;
    jumlah.text = widget.dataBukuPerpusModel.numberOfBook;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Edit Buku",
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
                  child: TextFormField(
                    controller: namabuku,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Masukkan Nama Buku',
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
                  child: TextFormField(
                    controller: hargabuku,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Masukkan Harga Buku',
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
                "Tahun Buku",
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
                    controller: tahun,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Masukkan Tahun Buku',
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
                "Jumlah Buku",
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
              Center(
                child: SizedBox(
                  height: 185,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.none,
                    children: [
                      SizedBox(
                          width: 185,
                          height: MediaQuery.of(context).size.width,
                          // decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(16),
                          //     image: _imageFile == null
                          //         ? widget.newsModel.newsImage != null
                          //             ? DecorationImage(
                          //                 image: NetworkImage(
                          //                     '${widget.newsModel.newsImage}'),
                          //                 fit: BoxFit.cover)
                          //             : const DecorationImage(
                          //                 image: AssetImage(
                          //                     "assets/image/image-not-available.jpg"),
                          //                 fit: BoxFit.cover)
                          //         : DecorationImage(
                          //             image: FileImage(_imageFile ?? File('')),
                          //             fit: BoxFit.cover),
                          //     color: Colors.redAccent),
                          child: _imageFile == null
                              ? widget.dataBukuPerpusModel.image != null
                                  ? CachedNetworkImage(
                                      imageUrl:
                                          widget.dataBukuPerpusModel.image,
                                      fit: BoxFit.cover,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        width: 75.0,
                                        height: 75.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      placeholder: (context, url) => Shimmer(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                          ),
                                          gradient:
                                              const LinearGradient(stops: [
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
                                    )
                                  : Container(
                                      height: 185,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          image: const DecorationImage(
                                              image: AssetImage(
                                                  "assets/image/image-not-available.jpg"),
                                              fit: BoxFit.cover)),
                                    )
                              : Container(
                                  height: 185,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    image: DecorationImage(
                                        image:
                                            FileImage(_imageFile ?? File('')),
                                        fit: BoxFit.cover),
                                  ),
                                )),
                      Positioned(
                        bottom: 0,
                        right: -10,
                        child: InkWell(
                          onTap: () {
                            getImage();
                          },
                          child: Container(
                            height: 43,
                            width: 43,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: const Color(0xff3774C3),
                                border:
                                    Border.all(color: Colors.white, width: 2)),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset(
                                'assets/icons/edit_admin.png',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
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
                  ),
                  GestureDetector(
                    onTap: () {
                      fungsiUpdateBuku(widget.dataBukuPerpusModel.bookId);
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

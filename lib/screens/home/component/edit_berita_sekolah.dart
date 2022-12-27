// ignore_for_file: deprecated_member_use, unused_field, prefer_const_constructors, unnecessary_null_comparison

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/news_school_model.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/screens/tab_screen.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:siakad_app/services/news_school_service.dart';

class EditBeritaSekolah extends StatefulWidget {
  const EditBeritaSekolah({Key? key, required this.newsModel})
      : super(key: key);

  final NewsModel newsModel;

  @override
  State<EditBeritaSekolah> createState() => _EditBeritaSekolahState();
}

class _EditBeritaSekolahState extends State<EditBeritaSekolah> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController textTitle = TextEditingController();
  TextEditingController textDesc = TextEditingController();

  bool loading = true;
  File? _imageFile;
  final _picker = ImagePicker();

  Future getImage() async {
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

  //update profile
  void fungsiUpdateNews(int newsId) async {
    showAlertDialog(context);
    ApiResponse response = await updateNews(
        newsId, textTitle.text, textDesc.text, getStringImage(_imageFile));
    if (response.error == null) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Berhasil Edit Berita Sekolah')));
      setState(() {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const TabScreen()));
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => GetStartedScreen()),
                (route) => false)
          });
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  @override
  void initState() {
    if (widget.newsModel.newsTitle != null) {
      textTitle.text = widget.newsModel.newsTitle;
    }
    if (widget.newsModel.newsContent != null) {
      textDesc.text = widget.newsModel.newsContent;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Edit Berita Sekolah",
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
              // Container(
              //   width: MediaQuery.of(context).size.width,
              //   height: 185,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(16),
              //       image: _imageFile == null
              //           ? widget.newsModel.newsImage != null
              //               ? DecorationImage(
              //                   image: NetworkImage(widget.newsModel.newsImage),
              //                   fit: BoxFit.cover)
              //               : null
              //           : DecorationImage(
              //               image: FileImage(_imageFile ?? File('')),
              //               fit: BoxFit.cover),
              //       color: Colors.redAccent),

              // ),
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
                              ? widget.newsModel.newsImage != null
                                  ? CachedNetworkImage(
                                      imageUrl: widget.newsModel.newsImage,
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
                            // FlatButton(
                            //   shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(50),
                            //     side: const BorderSide(
                            //         color: Colors.white, width: 2),
                            //   ),
                            //   color: const Color(0xff3774C3),
                            //   onPressed: () {
                            //     getImage();
                            //   },
                            //   child: Image.asset(
                            //     'assets/icons/edit_admin.png',
                            //     color: Colors.white,
                            //   ),
                            // ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      // hintText: 'Masukkan NIK',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
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
                    maxLines: 10,
                    controller: textDesc,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    // if (_key.currentState!.validate()) {
                    //   setState(() {
                    //     showAlertDialog(context);
                    //   });
                    //   fungsiUpdateNews();
                    // }
                    fungsiUpdateNews(widget.newsModel.newsId);
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
    );
  }
}

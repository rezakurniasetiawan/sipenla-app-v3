// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/news_school_model.dart';
import 'package:siakad_app/screens/home/component/detail_berita.dart';
import 'package:siakad_app/screens/home/component/edit_berita_sekolah.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/screens/tab_screen.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:siakad_app/services/news_school_service.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class BeritaSekolahHome extends StatefulWidget {
  const BeritaSekolahHome({
    Key? key,
    required this.role,
  }) : super(key: key);

  final String role;

  @override
  State<BeritaSekolahHome> createState() => _BeritaSekolahHomeState();
}

class _BeritaSekolahHomeState extends State<BeritaSekolahHome> {
  bool _loading = true;
  List<dynamic> _postList = [];
  int currentpage = 1;

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

  // get all posts
  Future<void> retrievePosts() async {
    print("object");
    ApiResponse response = await getPosts(currentpage);
    if (response.error == null) {
      setState(() {
        _postList = response.data as List<dynamic>;
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

  void fungsiDeleteNews(int newsId) async {
    showAlertDialog(context);
    ApiResponse response = await deleteNews(newsId);
    if (response.error == null) {
      print("Delete Suskses");
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Berhasil Menghapus Berita Sekolah')));
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
  void initState() {
    retrievePosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SkeletonNews(),
                SkeletonNews(),
                SkeletonNews(),
                SkeletonNews(),
              ],
            ),
          )
        : SizedBox(
            height: 800,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _postList.length,
                itemBuilder: (BuildContext context, int index) {
                  NewsModel newsModel = _postList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailBerita(
                            newsModel: newsModel,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (widget.role == 'admin')
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      child: Text(
                                        newsModel.newsTitle,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Poppins',
                                            color: Colors.black),
                                      ),
                                    ),
                                    Expanded(
                                        child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Alert(
                                                context: context,
                                                type: AlertType.success,
                                                desc:
                                                    "Apakah anda yakin menghapus berita ini?",
                                                buttons: [
                                                  DialogButton(
                                                    color: Colors.red,
                                                    child: InkWell(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        "Batal",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20),
                                                      ),
                                                    ),
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    width: 120,
                                                  ),
                                                  DialogButton(
                                                    color: Colors.green,
                                                    child: InkWell(
                                                      onTap: () {
                                                        fungsiDeleteNews(
                                                            newsModel.newsId);
                                                        print(newsModel.newsId);
                                                      },
                                                      child: const Text(
                                                        "Setuju",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20),
                                                      ),
                                                    ),
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    width: 120,
                                                  )
                                                ],
                                              ).show();
                                            },
                                            child: SizedBox(
                                              height: 25,
                                              child: Image.asset(
                                                  'assets/icons/delete-news.png'),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditBeritaSekolah(
                                                            newsModel:
                                                                newsModel,
                                                          )));
                                            },
                                            child: SizedBox(
                                              height: 25,
                                              child: Image.asset(
                                                  'assets/icons/edit_admin.png'),
                                            ),
                                          )
                                        ],
                                      ),
                                    ))
                                  ],
                                )
                              : Text(
                                  newsModel.newsTitle,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Poppins',
                                      color: Colors.black),
                                ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                              height: 185,
                              width: MediaQuery.of(context).size.width,
                              // decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(16),
                              //     image: DecorationImage(
                              //         image:
                              //             AssetImage("assets/image/berita1.png"),
                              //         fit: BoxFit.cover)),
                              child: newsModel.newsImage != null
                                  ? CachedNetworkImage(
                                      imageUrl: newsModel.newsImage,
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
                                    )),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          );
  }
}

class SkeletonNews extends StatelessWidget {
  const SkeletonNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer(
          child: Container(
            width: 200,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          gradient: const LinearGradient(
            stops: [0.2, 0.5, 0.6],
            colors: [
              Colors.black12,
              Colors.white12,
              Colors.black12,
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Shimmer(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          gradient: const LinearGradient(
            stops: [0.2, 0.5, 0.6],
            colors: [
              Colors.black12,
              Colors.white12,
              Colors.black12,
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}

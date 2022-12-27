// ignore_for_file: avoid_print, unnecessary_new, unused_element

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shimmer/shimmer.dart';
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/news_school_model.dart';
import 'package:siakad_app/screens/home/component/detail_berita.dart';
import 'package:siakad_app/screens/home/component/edit_berita_sekolah.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:siakad_app/services/news_school_service.dart';

class BeritaSekolah extends StatefulWidget {
  const BeritaSekolah({Key? key, required this.role}) : super(key: key);

  final String role;

  @override
  State<BeritaSekolah> createState() => _BeritaSekolahState();
}

class _BeritaSekolahState extends State<BeritaSekolah> {
  List<dynamic> _postList = [];
  int userId = 0;
  bool _loading = true;

  int currentpage = 1;
  int lastpage = 0;

  // get all posts
  Future<void> retrievePosts() async {
    userId = await getUserId();
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
        retrievePosts();
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

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          const CircularProgressIndicator(
            color: Colors.blue,
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

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    print(currentpage);
    await Future.delayed(const Duration(milliseconds: 1000));

    refreshController.refreshCompleted();
  }

  void _onLoading() async {
    print("Dataku Loading");
    print(currentpage);
    // showAlertDialog(context);
    await Future.delayed(const Duration(milliseconds: 1000));
    // userId = await getUserId();
    currentpage++;
    ApiResponse response = await getPosts(currentpage);

    if (response.error == null) {
      if (currentpage == lastpage) {
        print("Terbaru");
      } else {
        setState(() {
          _postList.addAll(response.data as List<dynamic>);
          _loading = _loading ? !_loading : _loading;
          // Navigator.pop(context);
        });
      }
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
    refreshController.loadComplete();
  }

  @override
  void initState() {
    retrievePosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Color(0xff4B556B),
        ),
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blueAccent,
              ),
            )
          : SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: SmartRefresher(
                controller: refreshController,
                enablePullDown: false,
                enablePullUp: true,

                onLoading: _onLoading,
                // onRefresh: _onRefresh,
                child: ListView.builder(
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
                          padding: const EdgeInsets.only(
                              top: 20, left: 15, right: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              (widget.role == 'admin')
                                  ? Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.25,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Alert(
                                                    context: context,
                                                    type: AlertType.info,
                                                    title: "Sipenla App",
                                                    desc:
                                                        "Apakah anda ingin menghapus berita ini?",
                                                    buttons: [
                                                      DialogButton(
                                                        child: InkWell(
                                                          onTap: () {
                                                            fungsiDeleteNews(
                                                                newsModel
                                                                    .newsId);
                                                            print(newsModel
                                                                .newsId);
                                                          },
                                                          child: const Text(
                                                            "Hapus",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20),
                                                          ),
                                                        ),
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
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
                                        imageBuilder:
                                            (context, imageProvider) =>
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
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            image: const DecorationImage(
                                                image: AssetImage(
                                                    "assets/image/image-not-available.jpg"),
                                                fit: BoxFit.cover)),
                                      ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                newsModel.newsContent,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
    );
  }
}

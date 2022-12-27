import 'package:flutter/material.dart';
import 'package:siakad_app/services/perpustakaan/data_buku_service.dart';
import 'package:siakad_app/widget/perpustakaan/comp/detail_buku_perpus.dart';
import 'package:siakad_app/widget/perpustakaan/comp/edit_buku_perpus.dart';
import 'package:siakad_app/widget/perpustakaan/comp/tambah_buku_perpus.dart';

import '../../../constan.dart';
import '../../../models/api_response_model.dart';
import '../../../models/perpustakaan/pegawai_perpus_model.dart';
import '../../../screens/started_screen.dart';
import '../../../services/auth_service.dart';

class DataBukuPerpus extends StatefulWidget {
  const DataBukuPerpus({Key? key}) : super(key: key);

  @override
  State<DataBukuPerpus> createState() => _DataBukuPerpusState();
}

class _DataBukuPerpusState extends State<DataBukuPerpus> {
  bool _loading = true;
  List<dynamic> bookPerpusList = [];

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

  Future<void> fungsiGetBookPerpus() async {
    ApiResponse response = await getBookPerpus();
    if (response.error == null) {
      setState(() {
        bookPerpusList = response.data as List<dynamic>;
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

  void fungsiDeleteBuku(int idBook) async {
    showAlertDialog(context);
    ApiResponse response = await deleteBookPerpus(idbook: idBook.toString());
    if (response.error == null) {
      print("Delete Suskses");
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Berhasil Menghapus Buku')));
      setState(() {
        fungsiGetBookPerpus();
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
    fungsiGetBookPerpus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Data Buku",
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
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () async {
              String refresh = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TambahBukuPerpus()));
              if (refresh == 'refresh') {
                fungsiGetBookPerpus();
              }
            },
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border:
                        Border.all(width: 2, color: const Color(0xff2E447C))),
                child: const Center(
                    child: Text(
                  "Tambah Buku",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: Color(0xff2E447C),
                      letterSpacing: 1),
                )),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          _loading
              ? const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.blueAccent,
                    ),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                      itemCount: bookPerpusList.length,
                      itemBuilder: (BuildContext context, int index) {
                        DataBukuPerpusModel dataBukuPerpusModel =
                            bookPerpusList[index];
                        return ItemFasilitas(
                          code: dataBukuPerpusModel.bookCode,
                          delete: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Container(
                                  child: AlertDialog(
                                    actions: [
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: 85,
                                            width: 85,
                                            child: Image.asset(
                                                'assets/icons/warning-icon.png'),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Text(
                                              'Apakah Anda Yakin Ingin Menghapus Data Ini?',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Poppins',
                                                color: Color(0xff4B556B),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 130,
                                                height: 44,
                                                decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xffFF4238),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text(
                                                      "Batal",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white),
                                                    )),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                width: 130,
                                                height: 44,
                                                decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xff83BC10),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: TextButton(
                                                  onPressed: () {
                                                    fungsiDeleteBuku(
                                                        dataBukuPerpusModel
                                                            .bookId);
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text(
                                                    "Setuju",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily: 'Poppins',
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          jumlah: dataBukuPerpusModel.numberOfBook,
                          pengarang: dataBukuPerpusModel.bookCreator,
                          name: dataBukuPerpusModel.bookName,
                          tahun: dataBukuPerpusModel.bookYear,
                          update: () async {
                            String refresh = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditBukuPerpus(
                                          dataBukuPerpusModel:
                                              dataBukuPerpusModel,
                                        )));
                            if (refresh == 'refresh') {
                              fungsiGetBookPerpus();
                            }
                          },
                          view: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailBukuPerpus(
                                          dataBukuPerpusModel:
                                              dataBukuPerpusModel,
                                        )));
                          },
                        );
                      }),
                ),
        ],
      ),
    );
  }
}

class ItemFasilitas extends StatelessWidget {
  const ItemFasilitas({
    Key? key,
    required this.code,
    required this.name,
    required this.jumlah,
    required this.pengarang,
    required this.tahun,
    required this.delete,
    required this.view,
    required this.update,
  }) : super(key: key);

  final String code, name, jumlah, pengarang, tahun;
  final VoidCallback delete, view, update;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, top: 15, left: 15),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 130,
                          child: Text(
                            "Kode Buku",
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
                            code,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 130,
                          child: Text(
                            "Nama Buku",
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
                            name,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 130,
                          child: Text(
                            "Jumlah Buku",
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
                            jumlah,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 130,
                          child: Text(
                            "Pengarang",
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
                            pengarang,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 130,
                          child: Text(
                            "Tahun",
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
                            tahun,
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
                  ],
                ),
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: update,
                    icon: const ImageIcon(
                        AssetImage(
                          "assets/icons/edit_admin.png",
                        ),
                        color: Color(0xff4B556B)),
                  ),
                  IconButton(
                    onPressed: delete,
                    icon: const ImageIcon(
                      AssetImage(
                        "assets/icons/delete-news.png",
                      ),
                      color: Colors.red,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: view,
            child: Center(
              child: Container(
                width: 100,
                height: 27,
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
                  "Lihat",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: Colors.white,
                  ),
                )),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: const Color(0xff4B556B))
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/fasilitas_model.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/screens/tab_screen.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:siakad_app/services/fasilitas_service.dart';
import 'package:siakad_app/widget/fasilitas/comp/detail_fasilitas.dart';
import 'package:siakad_app/widget/fasilitas/comp/tambah_fasilitas.dart';
import 'package:siakad_app/widget/fasilitas/comp/update_fasilitas.dart';

class DataFasilitas extends StatefulWidget {
  const DataFasilitas({Key? key}) : super(key: key);

  @override
  State<DataFasilitas> createState() => _DataFasilitasState();
}

class _DataFasilitasState extends State<DataFasilitas> {
  bool _loading = true;
  List<dynamic> _FasilitasList = [];

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

  Future<void> fungsiGetFasilitasAll() async {
    ApiResponse response = await getFasilitasAll();
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

  void fungsiDeleteFasilitas(int fasId) async {
    showAlertDialog(context);
    ApiResponse response = await deleteFasilitas(idFas: fasId);
    if (response.error == null) {
      print("Delete Suskses");
      Navigator.pop(context);
      setState(() {
        fungsiGetFasilitasAll();
      });
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Berhasil Menghapus Fasilitas')));
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
    fungsiGetFasilitasAll();
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
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () async {
              String refresh = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TambahFasilitas()));
              if (refresh == 'refresh') {
                fungsiGetFasilitasAll();
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
                  "Tambah Fasilitas",
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
                  child: RefreshIndicator(
                    onRefresh: () => fungsiGetFasilitasAll(),
                    child: ListView.builder(
                      itemCount: _FasilitasList.length,
                      itemBuilder: (BuildContext context, int index) {
                        FasilitasModel fasilitasModel = _FasilitasList[index];
                        return ItemFasilitas(
                          code: fasilitasModel.facilityCode,
                          jumlah: fasilitasModel.numberOfFacility,
                          name: fasilitasModel.facilityName,
                          ket: fasilitasModel.status,
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
                                                    fungsiDeleteFasilitas(
                                                        fasilitasModel
                                                            .facilityId);
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
                          view: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailFasilitas(
                                          fasilitasModel: fasilitasModel,
                                        )));
                          },
                          update: () async {
                            String refresh = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateFasilitas(
                                          fasilitasModel: fasilitasModel,
                                        )));
                            if (refresh == 'refresh') {
                              print('Berhasil Reffresh');
                              fungsiGetFasilitasAll();
                            }
                          },
                        );
                      },
                    ),
                  ),
                )
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
    required this.ket,
    required this.delete,
    required this.view,
    required this.update,
  }) : super(key: key);

  final String code, name, jumlah, ket;
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
                            "Keterangan",
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
                            ket,
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

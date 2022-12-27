import 'package:flutter/material.dart';
import 'package:siakad_app/services/kantin_services.dart';
import 'package:siakad_app/widget/kantin/manajemen-kantin/tambah_kantin.dart';

import '../../../constan.dart';
import '../../../models/api_response_model.dart';
import '../../../models/kantin_model.dart';
import '../../../screens/started_screen.dart';
import '../../../services/auth_service.dart';

class ManajemenKantin extends StatefulWidget {
  const ManajemenKantin({Key? key}) : super(key: key);

  @override
  State<ManajemenKantin> createState() => ManajemenKantinState();
}

class ManajemenKantinState extends State<ManajemenKantin> {
  bool _loading = true;
  List<dynamic> merchantList = [];

  Future<void> fungsiGetMerchant() async {
    ApiResponse response = await getMerchants();
    if (response.error == null) {
      setState(() {
        merchantList = response.data as List<dynamic>;
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

  @override
  void initState() {
    super.initState();
    fungsiGetMerchant();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Manajemen Kantin",
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
                      builder: (context) => const TambahKantin()));
              if (refresh == 'refresh') {
                fungsiGetMerchant();
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
                  "Tambah Kantin",
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
                      itemCount: merchantList.length,
                      itemBuilder: (BuildContext context, int index) {
                        ListMerchantModel listMerchantModel =
                            merchantList[index];
                        return ItemManajemenKantin(
                          codeMerchant: listMerchantModel.kodeKantin,
                          namaMerchant: listMerchantModel.namaKantin,
                          penjaga: listMerchantModel.firstName +
                              ' ' +
                              listMerchantModel.lastName,
                        );
                      }),
                )
          // _loading
          //     ? const Expanded(
          //         child: Center(
          //           child: CircularProgressIndicator(
          //             color: Colors.blueAccent,
          //           ),
          //         ),
          //       )
          //     : Expanded(
          //         child: ListView.builder(
          //             itemCount: bookPerpusList.length,
          //             itemBuilder: (BuildContext context, int index) {
          //               ManajemenTagihanModel manajemenTagihanModel =
          //                   bookPerpusList[index];
          //               String tanggal1 = DateFormat('dd-MM-yyyy')
          //                   .format(manajemenTagihanModel.fromDate);
          //               String tanggal2 = DateFormat('dd-MM-yyyy')
          //                   .format(manajemenTagihanModel.toDate);
          //               return ItemFasilitas(
          //                 namatagihan: manajemenTagihanModel.eventName,
          //                 tanggalAkhir: tanggal2,
          //                 tanggalMulai: tanggal1,
          //                 totalTagihan: FormatCurrency.convertToIdr(
          //                     manajemenTagihanModel.totalPrice, 0),
          //               );
          //             }),
          //       ),
        ],
      ),
    );
  }
}

class ItemManajemenKantin extends StatelessWidget {
  const ItemManajemenKantin({
    Key? key,
    required this.namaMerchant,
    required this.penjaga,
    required this.codeMerchant,
  }) : super(key: key);

  final String namaMerchant, penjaga, codeMerchant;

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
                            "Nama Kantin",
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
                            namaMerchant,
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
                            "Kode Kantin",
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
                            codeMerchant,
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
                            "Nama Penjaga",
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
                            penjaga,
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
            ],
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

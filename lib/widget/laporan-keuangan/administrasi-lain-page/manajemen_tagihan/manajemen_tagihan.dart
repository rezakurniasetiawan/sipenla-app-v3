import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:siakad_app/widget/laporan-keuangan/administrasi-lain-page/manajemen_tagihan/tambah_manajemen_tagihan.dart';

import '../../../../constan.dart';
import '../../../../models/api_response_model.dart';
import '../../../../models/laporan_keuangan_models.dart';
import '../../../../screens/started_screen.dart';
import '../../../../services/auth_service.dart';
import '../../../../services/laporan_keuangan_service.dart';
import '../../isi-saldo-page/isi-saldo/isi_saldo.dart';

class ManajemenTaighan extends StatefulWidget {
  const ManajemenTaighan({Key? key}) : super(key: key);

  @override
  State<ManajemenTaighan> createState() => _ManajemenTaighanState();
}

class _ManajemenTaighanState extends State<ManajemenTaighan> {
  bool _loading = true;
  List<dynamic> bookPerpusList = [];

  Future<void> fungsigetManajemenTagihan() async {
    ApiResponse response = await getManajemenTagihan();
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

  @override
  void initState() {
    super.initState();
    fungsigetManajemenTagihan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Manajemen Tagihan",
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
                      builder: (context) => const TambahManajemenTagihan()));
              if (refresh == 'refresh') {
                fungsigetManajemenTagihan();
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
                  "Tambah Tagihan",
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
                        ManajemenTagihanModel manajemenTagihanModel =
                            bookPerpusList[index];
                        String tanggal1 = DateFormat('dd-MM-yyyy')
                            .format(manajemenTagihanModel.fromDate);
                        String tanggal2 = DateFormat('dd-MM-yyyy')
                            .format(manajemenTagihanModel.toDate);
                        return ItemFasilitas(
                          namatagihan: manajemenTagihanModel.eventName,
                          tanggalAkhir: tanggal2,
                          tanggalMulai: tanggal1,
                          totalTagihan: FormatCurrency.convertToIdr(
                              manajemenTagihanModel.totalPrice, 0),
                        );
                      }),
                ),
        ],
      ),
    );
  }
}

// Nama Tagihan
// Total Tagihan
// Tanggal Mulai
// Tanggal AKhir

class ItemFasilitas extends StatelessWidget {
  const ItemFasilitas({
    Key? key,
    required this.namatagihan,
    required this.totalTagihan,
    required this.tanggalMulai,
    required this.tanggalAkhir,
  }) : super(key: key);

  final String namatagihan, totalTagihan, tanggalMulai, tanggalAkhir;

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
                            "Nama Tagihan",
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
                            namatagihan,
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
                            "Total Tagihan",
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
                            totalTagihan,
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
                            "Tanggal Mulai",
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
                            tanggalMulai,
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
                            "Tanggal Akhir",
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
                            tanggalAkhir,
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

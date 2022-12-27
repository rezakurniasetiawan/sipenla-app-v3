import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../constan.dart';
import '../../../../models/api_response_model.dart';
import '../../../../models/laporan_keuangan_models.dart';
import '../../../../screens/started_screen.dart';
import '../../../../services/auth_service.dart';
import '../../../../services/laporan_keuangan_service.dart';
import '../../isi-saldo-page/isi-saldo/isi_saldo.dart';
import 'konfirmasi_pembayaran_adm.dart';

class TagihanAdministrasi extends StatefulWidget {
  const TagihanAdministrasi({Key? key}) : super(key: key);

  @override
  State<TagihanAdministrasi> createState() => _TagihanAdministrasiState();
}

class _TagihanAdministrasiState extends State<TagihanAdministrasi> {
  bool _loading = true;
  List<dynamic> bookPerpusList = [];

  Future<void> fungsigetManajemenTagihan() async {
    ApiResponse response = await getTagihanAdmUser();
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
          'Tagihan Administrasi',
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              'Tagihan Saya',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xff4B556B),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),
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
                            .format(manajemenTagihanModel.toDate);
                        String bulan = DateFormat('MM')
                            .format(manajemenTagihanModel.toDate);
                        return ItemListTagihanAdministrasi(
                          title: manajemenTagihanModel.eventName,
                          date: tanggal1,
                          total: FormatCurrency.convertToIdr(
                              manajemenTagihanModel.totalPrice, 0),
                          ontaps: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        KonfirmasiPembayaranAdm(
                                          total: manajemenTagihanModel
                                              .totalPrice
                                              .toString(),
                                          todate: tanggal1,
                                          bulan: bulan,
                                        )));
                          },
                        );
                      }))
        ],
      ),
    );
  }
}

class ItemListTagihanAdministrasi extends StatelessWidget {
  const ItemListTagihanAdministrasi(
      {Key? key,
      required this.title,
      required this.date,
      required this.total,
      required this.ontaps})
      : super(key: key);

  final String title, date, total;
  final VoidCallback ontaps;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: const Color(0xff4B556B),
                ),
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/icons/adm-lain2.png'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: ontaps,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 155,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xff4B556B),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  const Text(
                                    "Administrasi Lain - Lain",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff4B556B),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  const Text(
                                    "Jatuh Tempo",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff4B556B),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    date,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff4B556B),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      total,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff4B556B),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 25,
                                  child: Image.asset(
                                      'assets/icons/arrow-right.png'),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:siakad_app/widget/laporan-keuangan/spp-page/tagihan-spp/konfirmasi_pembayaran.dart';
import '../../../../constan.dart';
import '../../../../models/api_response_model.dart';
import '../../../../models/laporan_keuangan_models.dart';
import '../../../../screens/started_screen.dart';
import '../../../../services/auth_service.dart';
import '../../../../services/laporan_keuangan_service.dart';
import '../../isi-saldo-page/isi-saldo/isi_saldo.dart';

class TagihanSpp extends StatefulWidget {
  const TagihanSpp({Key? key}) : super(key: key);

  @override
  State<TagihanSpp> createState() => _TagihanSppState();
}

class _TagihanSppState extends State<TagihanSpp> {
  bool _loading = true;
  List<dynamic> bookPerpusList = [];

  Future<void> fungsigetManajemenTagihan() async {
    ApiResponse response = await getManajemenSppUser();
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
          'Tagihan SPP',
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
                        ManajemenSppModel manajemenSppModel =
                            bookPerpusList[index];
                        String tanggal1 = DateFormat('dd-MM-yyyy')
                            .format(manajemenSppModel.fromDate);
                        String tanggal2 = DateFormat('dd-MM-yyyy')
                            .format(manajemenSppModel.toDate);
                        return ItemListTagihanSpp(
                          bulan: manajemenSppModel.mount,
                          press: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        KonfirmasiPembayaranSpp(
                                          total: manajemenSppModel.totalPrice
                                              .toString(),
                                          bulan: tanggal2,
                                          toDate: tanggal1,
                                        )));
                          },
                          tanggal: tanggal2,
                          total: FormatCurrency.convertToIdr(
                              manajemenSppModel.totalPrice, 0),
                        );
                      }),
                ),
        ],
      ),
    );
  }
}

class ItemListTagihanSpp extends StatelessWidget {
  const ItemListTagihanSpp(
      {Key? key,
      required this.bulan,
      required this.tanggal,
      required this.total,
      required this.press})
      : super(key: key);

  final String bulan, tanggal, total;
  final VoidCallback press;

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
                    child: Image.asset('assets/icons/spp2.png'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: press,
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
                                    "Bulan $bulan",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xff4B556B),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  const Text(
                                    "SPP",
                                    style: TextStyle(
                                      fontSize: 14,
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
                                    tanggal,
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

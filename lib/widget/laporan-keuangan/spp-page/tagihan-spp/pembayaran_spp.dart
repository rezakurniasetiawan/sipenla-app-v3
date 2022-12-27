import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:siakad_app/widget/laporan-keuangan/spp-page/tagihan-spp/sukses_pembayaran_spp.dart';
import '../../../../constan.dart';
import '../../../../services/auth_service.dart';

class PembayaranSpp extends StatefulWidget {
  const PembayaranSpp(
      {Key? key,
      required this.oderId,
      required this.vaNumber,
      required this.valueTagihan})
      : super(key: key);

  final String oderId, vaNumber, valueTagihan;

  @override
  State<PembayaranSpp> createState() => _PembayaranSppState();
}

class _PembayaranSppState extends State<PembayaranSpp> {
  Timer? timer;
  String status = '';

  Future getData({required String orderId}) async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(baseURL + '/api/payment/status/$orderId'),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      // return json.decode(response.body);
      String belum = jsonDecode(response.body)['status_code'];
      setState(() {
        status = belum;
      });
      if (belum == '201') {
        print('Belum Bayar');
        // timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        //   if (Belum == '201') {
        //     setState(() {
        //       getData(orderId: widget.oderId);
        //     });
        //   }else{
        //     timer.cancel();
        //   }
        // },
      } else {
        print('sudah Bayar');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SuksesPembayaranSpp(
                      orderId: widget.oderId,
                      valueTagihan: widget.valueTagihan,
                    )));
      }
    } else {
      throw Exception('Failed to load post');
    }
  }

  @override
  void initState() {
    super.initState();
    getData(orderId: widget.oderId);
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (status == '201') {
        setState(() {
          getData(orderId: widget.oderId);
        });
      } else {
        timer.cancel();
      }
    });
  }

  String nomer = '12345678901234';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pembayaran',
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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nomor Akun Virtual',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff4B556B),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),
            Container(
              height: 48,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color(0xffF0F1F2),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.vaNumber,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff4B556B),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: widget.vaNumber));
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Berhasil Menyalin Nomor Akun Virtual')));
                      },
                      child: const ImageIcon(
                        AssetImage('assets/icons/copas.png'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Text(
                'Cara Pembayaran',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xff4B556B),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),
            ),
            Center(
              child: Container(
                height: 1,
                width: MediaQuery.of(context).size.width * 0.37,
                color: const Color(0xff4B556B),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const ItemListCaraPembayaran(
              number: '1. ',
              conten: 'Masuk BCA Mobile',
            ),
            const ItemListCaraPembayaran(
              number: '2. ',
              conten: 'Pilih Menu Transfer & Pembayaran > Pembelian',
            ),
            const ItemListCaraPembayaran(
              number: '3. ',
              conten: 'Pilih Menu Kategori',
            ),
            const ItemListCaraPembayaran(
              number: '4. ',
              conten: 'Masukkan Nomer Akun Virtual',
            ),
            const ItemListCaraPembayaran(
              number: '5. ',
              conten:
                  'Ikuti Petunjuk Selanjutnya Untuk Menyelesaikan  Proses Pembayaran',
            ),
          ],
        ),
      ),
    );
  }
}

class ItemListCaraPembayaran extends StatelessWidget {
  const ItemListCaraPembayaran(
      {Key? key, required this.conten, required this.number})
      : super(key: key);

  final String number, conten;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              number,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xff4B556B),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
            Expanded(
              child: Text(
                conten,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xff4B556B),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

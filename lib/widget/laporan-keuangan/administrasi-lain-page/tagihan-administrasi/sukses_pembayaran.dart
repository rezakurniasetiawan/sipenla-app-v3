import 'package:flutter/material.dart';

import '../../../../constan.dart';
import '../../../../models/api_response_model.dart';
import '../../../../screens/started_screen.dart';
import '../../../../services/auth_service.dart';
import '../../../../services/pembayaran_service.dart';

class SuksesPembayaranAdmLain extends StatefulWidget {
  const SuksesPembayaranAdmLain(
      {Key? key, required this.orderId, required this.valueTagihan})
      : super(key: key);

  final String orderId, valueTagihan;

  @override
  State<SuksesPembayaranAdmLain> createState() =>
      _SuksesPembayaranAdmLainState();
}

class _SuksesPembayaranAdmLainState extends State<SuksesPembayaranAdmLain> {
  String kondisi = '';
  void fungsiUpdateStatus() async {
    ApiResponse response =
        await updateStatusPembayaranMitrans(idOrder: widget.orderId);
    if (response.error == null) {
      setState(() {
        kondisi = 'ada';
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
    }
  }

  @override
  void initState() {
    super.initState();
    fungsiUpdateStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: kondisi == 'ada'
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 85,
                          width: 85,
                          child: Image.asset('assets/icons/success-icon.png'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            'Berhasil Melakukan Pembayaran',
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
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Tunggu Sebentar ...',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xff4B556B),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    )),
          kondisi == 'ada'
              ? Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
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
                          "Oke",
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
                )
              : Container()
        ],
      )),
    );
  }
}

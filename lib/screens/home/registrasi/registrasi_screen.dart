// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:siakad_app/screens/home/registrasi/registrasi_akun.dart';
import 'package:siakad_app/screens/home/registrasi/registrasi_akun_walimurid.dart';
import 'package:siakad_app/screens/home/registrasi/registrasi_karyawan.dart';

class RegistrasiScreen extends StatefulWidget {
  const RegistrasiScreen({Key? key}) : super(key: key);

  @override
  State<RegistrasiScreen> createState() => _RegistrasiScreenState();
}

class _RegistrasiScreenState extends State<RegistrasiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Daftar",
          style: const TextStyle(
            fontSize: 20,
            color: const Color(0xff4B556B),
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: const Color(0xff4B556B),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegistrasiKaryawan()));
              },
              child: Container(
                height: 40,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: Image.asset('assets/icons/person-grub.png'),
                    ),
                    const Text(
                      "Karyawan",
                      style: TextStyle(
                        fontSize: 14,
                        color: const Color(0xff4B556B),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(
                      height: 24,
                      width: 40,
                      child: Image.asset('assets/icons/icon-next.png'),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegistrasiAkun(
                              role: 'student',
                            )));
              },
              child: Container(
                height: 40,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: Image.asset('assets/icons/person-grub.png'),
                    ),
                    const Text(
                      "Siswa",
                      style: TextStyle(
                        fontSize: 14,
                        color: const Color(0xff4B556B),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(
                      height: 24,
                      width: 40,
                      child: Image.asset('assets/icons/icon-next.png'),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegistrasiAkunWaliMurid(
                              role: 'walimurid',
                            )));
              },
              child: Container(
                height: 40,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: Image.asset('assets/icons/person-grub.png'),
                    ),
                    const Text(
                      "Wali Murid",
                      style: TextStyle(
                        fontSize: 14,
                        color: const Color(0xff4B556B),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(
                      height: 24,
                      width: 40,
                      child: Image.asset('assets/icons/icon-next.png'),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

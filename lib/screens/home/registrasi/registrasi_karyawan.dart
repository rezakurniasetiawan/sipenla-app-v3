import 'package:flutter/material.dart';
import 'package:siakad_app/screens/home/registrasi/registrasi_akun.dart';

class RegistrasiKaryawan extends StatefulWidget {
  const RegistrasiKaryawan({Key? key}) : super(key: key);

  @override
  State<RegistrasiKaryawan> createState() => _RegistrasiKaryawanState();
}

class _RegistrasiKaryawanState extends State<RegistrasiKaryawan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Daftar",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Center(
                  child: Text(
                    'KARYAWAN',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                        color: Color(0xff4B556B),
                        letterSpacing: 1),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegistrasiAkun(
                                role: 'kepsek',
                              )));
                },
                child: Container(
                  height: 24,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Kepala Sekolah",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff4B556B),
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
                                role: 'guru',
                              )));
                },
                child: Container(
                  height: 24,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Guru",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff4B556B),
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
                                role: 'pembinaextra',
                              )));
                },
                child: Container(
                  height: 24,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Pembina Ekstrakulikuler",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff4B556B),
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
                                role: 'tu',
                              )));
                },
                child: Container(
                  height: 24,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Pegawai TU",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff4B556B),
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
                                role: 'pengawassekolah',
                              )));
                },
                child: Container(
                  height: 24,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Pengawas Sekolah",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff4B556B),
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
                                role: 'pegawaikantin',
                              )));
                },
                child: Container(
                  height: 24,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Pegawai Kantin",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff4B556B),
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
                                role: 'perpus',
                              )));
                },
                child: Container(
                  height: 24,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Pegawai Perpustakaan",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff4B556B),
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
                                role: 'pegawaikoperasi',
                              )));
                },
                child: Container(
                  height: 24,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Pegawai Koperasi",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff4B556B),
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
                                role: 'dinaspendidikan',
                              )));
                },
                child: Container(
                  height: 24,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Dinas Pendidikan",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff4B556B),
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
            ],
          ),
        ),
      ),
    );
  }
}

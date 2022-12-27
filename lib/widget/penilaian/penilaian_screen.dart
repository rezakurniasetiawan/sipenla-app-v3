import 'package:flutter/material.dart';
import 'package:siakad_app/widget/penilaian/comp/pilih_penilaian.dart';
import 'package:siakad_app/widget/penilaian/comp/pilih_penilaian_riwayat.dart';

import 'comp/pilih_penilaian_ekstra.dart';
import 'comp/pilih_riwayat_ekstra.dart';

class PenilaianScreen extends StatefulWidget {
  const PenilaianScreen(
      {Key? key,
      required this.role,
      required this.idEkstraPembina,
      required this.ekstraPembinaName})
      : super(key: key);

  final String role, ekstraPembinaName;
  final int idEkstraPembina;

  @override
  State<PenilaianScreen> createState() => _PenilaianScreenState();
}

class _PenilaianScreenState extends State<PenilaianScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Penilaian",
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
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: widget.role == 'guru'
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MenuItem(
                      ontapps: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PilihPenilaian()));
                      },
                      leftIcon: 'assets/icons/bar-chart.png',
                      rightIcon: 'assets/icons/icon-next.png',
                      title: 'Masukkan Nilai Pembelajaran',
                    ),
                    MenuItem(
                      ontapps: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PilihPenilaianRiwayat()));
                      },
                      leftIcon: 'assets/icons/bar-chart.png',
                      rightIcon: 'assets/icons/icon-next.png',
                      title: 'Riwayat Pembelajaran',
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MenuItem(
                      ontapps: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PilihPenilaianEkstra(
                                      idEkstraPembina: widget.idEkstraPembina,
                                      ekstraPembinaName:
                                          widget.ekstraPembinaName,
                                    )));
                      },
                      leftIcon: 'assets/icons/bar-chart.png',
                      rightIcon: 'assets/icons/icon-next.png',
                      title: 'Masukkan Nilai Ekstrakulikuler',
                    ),
                    MenuItem(
                      ontapps: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PilihRiwayatEkstraPembina(
                                      idEkstraPembina: widget.idEkstraPembina,
                                      nameekstraPembina:
                                          widget.ekstraPembinaName,
                                    )));
                      },
                      leftIcon: 'assets/icons/bar-chart.png',
                      rightIcon: 'assets/icons/icon-next.png',
                      title: 'Riwayat Ekstrakulikuler',
                    ),
                  ],
                )),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem(
      {Key? key,
      required this.ontapps,
      required this.leftIcon,
      required this.rightIcon,
      required this.title})
      : super(key: key);

  final VoidCallback ontapps;
  final String leftIcon, rightIcon, title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: ontapps,
          child: Container(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  child: Image.asset(leftIcon),
                ),
                Text(
                  title,
                  style: const TextStyle(
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
                  child: Image.asset(rightIcon),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        )
      ],
    );
  }
}

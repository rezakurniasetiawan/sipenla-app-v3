import 'package:flutter/material.dart';
import 'package:siakad_app/widget/jadwal/comp/jadwal_ekstra.dart';
import 'package:siakad_app/widget/jadwal/comp/jadwal_kerja.dart';
import 'package:siakad_app/widget/jadwal/comp/jadwal_kerja_pegawai.dart';
import 'package:siakad_app/widget/jadwal/comp/list_ekstra.dart';
import 'package:siakad_app/widget/jadwal/comp/jadwal_mengajar.dart';
import 'package:siakad_app/widget/jadwal/comp/jadwal_pelajaran.dart';
import 'package:siakad_app/widget/jadwal/comp/list_kelas.dart';

class JadwalScreen extends StatefulWidget {
  const JadwalScreen(
      {Key? key,
      required this.role,
      required this.className,
      required this.idClass,
      required this.idEkstra})
      : super(key: key);

  final String role;
  final String className;
  final int idClass;
  final int idEkstra;

  @override
  State<JadwalScreen> createState() => _JadwalScreenState();
}

class _JadwalScreenState extends State<JadwalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Jadwal',
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
        child: widget.role == 'admin'
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MenuItem(
                    ontapps: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ListEkstra()));
                    },
                    leftIcon: 'assets/icons/bar-chart.png',
                    rightIcon: 'assets/icons/icon-next.png',
                    title: 'Jadwal Ekstrakulikuler',
                  ),
                  MenuItem(
                    ontapps: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ListKelas()));
                    },
                    leftIcon: 'assets/icons/bar-chart.png',
                    rightIcon: 'assets/icons/icon-next.png',
                    title: 'Jadwal Pembelajaran',
                  ),
                  MenuItem(
                    ontapps: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const JadwalKerja()));
                    },
                    leftIcon: 'assets/icons/bar-chart.png',
                    rightIcon: 'assets/icons/icon-next.png',
                    title: 'Jadwal Kerja',
                  ),
                ],
              )
            : widget.role == 'student'
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MenuItem(
                        ontapps: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => JadwalEkstra(
                                        idEkstra: widget.idEkstra,
                                      )));
                        },
                        leftIcon: 'assets/icons/bar-chart.png',
                        rightIcon: 'assets/icons/icon-next.png',
                        title: 'Jadwal Ekstrakulikuler',
                      ),
                      MenuItem(
                        ontapps: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => JadwalPelajaran(
                                        className: widget.className,
                                        idClass: widget.idClass,
                                      )));
                        },
                        leftIcon: 'assets/icons/bar-chart.png',
                        rightIcon: 'assets/icons/icon-next.png',
                        title: 'Jadwal Pembelajaran',
                      ),
                    ],
                  )
                : widget.role == 'guru'
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MenuItem(
                            ontapps: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => JadwalMengajar(
                                            role: widget.role,
                                          )));
                            },
                            leftIcon: 'assets/icons/bar-chart.png',
                            rightIcon: 'assets/icons/icon-next.png',
                            title: 'Jadwal Mengajar',
                          ),
                        ],
                      )
                    : widget.role == 'walimurid'
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // MenuItem(
                              //   ontapps: () {
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) => JadwalEkstra(
                              //                   idEkstra: widget.idEkstra,
                              //                 )));
                              //   },
                              //   leftIcon: 'assets/icons/bar-chart.png',
                              //   rightIcon: 'assets/icons/icon-next.png',
                              //   title: 'Jadwal Ekstrakulikuler',
                              // ),
                              MenuItem(
                                ontapps: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => JadwalPelajaran(
                                                className: widget.className,
                                                idClass: widget.idClass,
                                              )));
                                },
                                leftIcon: 'assets/icons/bar-chart.png',
                                rightIcon: 'assets/icons/icon-next.png',
                                title: 'Jadwal Pembelajaran',
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
                                          builder: (context) =>
                                              const JadwalKerjaPegawai()));
                                },
                                leftIcon: 'assets/icons/bar-chart.png',
                                rightIcon: 'assets/icons/icon-next.png',
                                title: 'Jadwal Kerja',
                              ),
                            ],
                          ),
      ),
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

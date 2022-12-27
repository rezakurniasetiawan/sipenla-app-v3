import 'package:flutter/material.dart';
import 'package:siakad_app/widget/fasilitas/comp/data_fasilitas.dart';
import 'package:siakad_app/widget/fasilitas/comp/data_fasilitas_dispen.dart';
import 'package:siakad_app/widget/fasilitas/comp/peminjaman_fasilitas.dart';
import 'package:siakad_app/widget/fasilitas/comp/pengembalian_fasilitas.dart';
import 'package:siakad_app/widget/fasilitas/comp/riwayat_user_fasilitas.dart';
import 'package:siakad_app/widget/fasilitas/menu_fasilitas_pegawai.dart';
import 'package:siakad_app/widget/fasilitas/menu_fasilitas_siswa.dart';

class FasilitasScreen extends StatefulWidget {
  const FasilitasScreen(
      {Key? key, required this.role, required this.statusStudent})
      : super(key: key);

  final String role, statusStudent;
  @override
  State<FasilitasScreen> createState() => _FasilitasScreenState();
}

class _FasilitasScreenState extends State<FasilitasScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Fasilitas",
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.role == 'tu'
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MenuItem(
                          ontapps: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const DataFasilitas()));
                          },
                          leftIcon: 'assets/icons/bar-chart.png',
                          rightIcon: 'assets/icons/icon-next.png',
                          title: 'Data Fasilitas',
                        ),
                        MenuItem(
                          ontapps: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const MenuFasilitasPegawai()));
                          },
                          leftIcon: 'assets/icons/bar-chart.png',
                          rightIcon: 'assets/icons/icon-next.png',
                          title: 'Fasilitas Pegawai',
                        ),
                        MenuItem(
                          ontapps: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const MenuFasilitasSiswa()));
                          },
                          leftIcon: 'assets/icons/bar-chart.png',
                          rightIcon: 'assets/icons/icon-next.png',
                          title: 'Fasilitas Siswa',
                        ),
                      ],
                    )
                  : widget.role == 'dinaspendidikan'
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MenuItem(
                              ontapps: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const DataFasilitasDispen()));
                              },
                              leftIcon: 'assets/icons/bar-chart.png',
                              rightIcon: 'assets/icons/icon-next.png',
                              title: 'Data Fasilitas',
                            ),
                            MenuItem(
                              ontapps: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             const PengembalianFasilitas()));
                              },
                              leftIcon: 'assets/icons/bar-chart.png',
                              rightIcon: 'assets/icons/icon-next.png',
                              title: 'Riwayat Fasilitas',
                            ),
                          ],
                        )
                      : widget.role == 'kepsek'
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MenuItem(
                                  ontapps: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const DataFasilitas()));
                                  },
                                  leftIcon: 'assets/icons/bar-chart.png',
                                  rightIcon: 'assets/icons/icon-next.png',
                                  title: 'Data Fasilitas',
                                ),
                                MenuItem(
                                  ontapps: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const PeminjamanFasilitas()));
                                  },
                                  leftIcon: 'assets/icons/bar-chart.png',
                                  rightIcon: 'assets/icons/icon-next.png',
                                  title: 'Peminjaman Fasilitas',
                                ),
                                MenuItem(
                                  ontapps: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const PengembalianFasilitas()));
                                  },
                                  leftIcon: 'assets/icons/bar-chart.png',
                                  rightIcon: 'assets/icons/icon-next.png',
                                  title: 'Pengembalian Fasilitas',
                                ),
                                MenuItem(
                                  ontapps: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const RiwayatUserFasilitas()));
                                  },
                                  leftIcon: 'assets/icons/bar-chart.png',
                                  rightIcon: 'assets/icons/icon-next.png',
                                  title: 'Riwayat Fasilitas',
                                ),
                              ],
                            )
                          : widget.role == 'student'
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    widget.statusStudent == 'inactive'
                                        ? Column(
                                            children: [
                                              MenuItem(
                                                ontapps: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const RiwayatUserFasilitas()));
                                                },
                                                leftIcon:
                                                    'assets/icons/bar-chart.png',
                                                rightIcon:
                                                    'assets/icons/icon-next.png',
                                                title: 'Riwayat Fasilitas',
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              MenuItem(
                                                ontapps: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const PeminjamanFasilitas()));
                                                },
                                                leftIcon:
                                                    'assets/icons/bar-chart.png',
                                                rightIcon:
                                                    'assets/icons/icon-next.png',
                                                title: 'Peminjaman Fasilitas',
                                              ),
                                              MenuItem(
                                                ontapps: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const PengembalianFasilitas()));
                                                },
                                                leftIcon:
                                                    'assets/icons/bar-chart.png',
                                                rightIcon:
                                                    'assets/icons/icon-next.png',
                                                title: 'Pengembalian Fasilitas',
                                              ),
                                              MenuItem(
                                                ontapps: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const RiwayatUserFasilitas()));
                                                },
                                                leftIcon:
                                                    'assets/icons/bar-chart.png',
                                                rightIcon:
                                                    'assets/icons/icon-next.png',
                                                title: 'Riwayat Fasilitas',
                                              ),
                                            ],
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
                                                    const PeminjamanFasilitas()));
                                      },
                                      leftIcon: 'assets/icons/bar-chart.png',
                                      rightIcon: 'assets/icons/icon-next.png',
                                      title: 'Peminjaman Fasilitas',
                                    ),
                                    MenuItem(
                                      ontapps: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const PengembalianFasilitas()));
                                      },
                                      leftIcon: 'assets/icons/bar-chart.png',
                                      rightIcon: 'assets/icons/icon-next.png',
                                      title: 'Pengembalian Fasilitas',
                                    ),
                                    MenuItem(
                                      ontapps: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const RiwayatUserFasilitas()));
                                      },
                                      leftIcon: 'assets/icons/bar-chart.png',
                                      rightIcon: 'assets/icons/icon-next.png',
                                      title: 'Riwayat Fasilitas',
                                    ),
                                  ],
                                )
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
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 30,
                  width: 30,
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
          height: 30,
        )
      ],
    );
  }
}

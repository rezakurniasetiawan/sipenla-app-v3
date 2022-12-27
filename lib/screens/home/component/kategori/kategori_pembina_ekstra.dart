import 'package:flutter/material.dart';
import 'package:siakad_app/screens/home/absensi/absensi_pegawai.dart';
import 'package:siakad_app/screens/home/component/item_kategori.dart';
import 'package:siakad_app/widget/jadwal/jadwal_screen.dart';
import 'package:siakad_app/widget/kantin/kantin_screen.dart';
import 'package:siakad_app/widget/laporan-keuangan/laporan-keuangan-screen.dart';
import 'package:siakad_app/widget/monitoring/monitoring_screen.dart';
import 'package:siakad_app/widget/penilaian/penilaian_screen.dart';

import '../../../../widget/koperasi/koperasi_screen.dart';
import '../../../../widget/perpustakaan/perpustakaan_screen.dart';

class KategoriPembinaEkstra extends StatefulWidget {
  const KategoriPembinaEkstra(
      {Key? key,
      required this.role,
      required this.className,
      required this.idClass,
      required this.idEkstra,
      required this.imageTeacher,
      required this.idEkstraPembina,
      required this.ekstraPembinaName})
      : super(key: key);

  final String role;
  final String className;
  final int idClass;
  final int idEkstra;
  final int idEkstraPembina;
  final String imageTeacher;
  final String ekstraPembinaName;

  @override
  State<KategoriPembinaEkstra> createState() => _KategoriPembinaEkstraState();
}

class _KategoriPembinaEkstraState extends State<KategoriPembinaEkstra> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ItemKategori(
                title: "Absensi",
                icon: 'assets/icons/absensi.png',
                ontaps: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AbsensiPegawai()));
                },
              ),
              ItemKategori(
                title: "Jadwal",
                icon: 'assets/icons/jadwal2.png',
                ontaps: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => JadwalScreen(
                                role: widget.role,
                                className: widget.className,
                                idClass: widget.idClass,
                                idEkstra: widget.idEkstra,
                              )));
                },
              ),
              ItemKategori(
                title: "Monitoring",
                icon: 'assets/icons/monitoring.png',
                ontaps: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MonitoringScreen(
                                role: widget.role,
                                imageTeacher: widget.imageTeacher,
                              )));
                },
              ),
              ItemKategori(
                title: "Koperasi",
                icon: 'assets/icons/pembelian.png',
                ontaps: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => KoperasiScreen(
                                role: widget.role,
                              )));
                },
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ItemKategori(
                title: "Kantin",
                icon: 'assets/icons/kantin.png',
                ontaps: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => KantinScreen(
                                role: widget.role,
                              )));
                },
              ),
              ItemKategori(
                title: "Laporan Keuangan",
                icon: 'assets/icons/laporan-keuangan.png',
                ontaps: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LaporanKeuanganScreen(
                                role: widget.role,
                              )));
                },
              ),
              ItemKategori(
                title: "Perpustakaan",
                icon: 'assets/icons/perpustakaan.png',
                ontaps: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PerpustakaanScreen(
                                role: widget.role,
                              )));
                },
              ),
              ItemKategori(
                title: "Penilaian",
                icon: 'assets/icons/penilaian.png',
                ontaps: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PenilaianScreen(
                                role: widget.role,
                                idEkstraPembina: widget.idEkstraPembina,
                                ekstraPembinaName: widget.ekstraPembinaName,
                              )));
                },
              ),
              // ItemKategori(title: "", icon: 'assets/icons/blank.png')
            ],
          ),
        ],
      ),
    );
  }
}

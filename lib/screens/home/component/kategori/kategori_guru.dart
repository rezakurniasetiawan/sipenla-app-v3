// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:siakad_app/screens/home/absensi/absensi_pegawai.dart';
import 'package:siakad_app/screens/home/component/item_kategori.dart';
import 'package:siakad_app/widget/data-user/data_siswa_screen.dart';
import 'package:siakad_app/widget/fasilitas/fasilitas_screen.dart';
import 'package:siakad_app/widget/jadwal/jadwal_screen.dart';
import 'package:siakad_app/widget/laporan-keuangan/laporan-keuangan-screen.dart';
import 'package:siakad_app/widget/monitoring/monitoring_screen.dart';
import 'package:siakad_app/widget/penilaian/penilaian_screen.dart';
import 'package:siakad_app/widget/rapor/rapor_screen.dart';

import '../../../../widget/kantin/kantin_screen.dart';
import '../../../../widget/koperasi/koperasi_screen.dart';
import '../../../../widget/perpustakaan/perpustakaan_screen.dart';

class KategoriGuru extends StatefulWidget {
  const KategoriGuru(
      {Key? key,
      required this.role,
      required this.className,
      required this.idClass,
      required this.idEkstra,
      required this.isWali,
      required this.imageTeacher,
      required this.idEkstraPembina,
      required this.ekstraPembinaName,
      required this.nameSiswa,
      required this.nisnSIswa,
      required this.statusStudent})
      : super(key: key);

  final String role, statusStudent;
  final String className, nameSiswa, nisnSIswa;
  final int idClass;
  final int idEkstra;
  final int idEkstraPembina;
  final String imageTeacher;
  final String isWali;
  final String ekstraPembinaName;
  @override
  State<KategoriGuru> createState() => _KategoriGuruState();
}

class _KategoriGuruState extends State<KategoriGuru> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ItemKategori(
                title: "Absensi",
                icon: 'assets/icons/absensi.png',
                ontaps: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AbsensiPegawai()));
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
              ItemKategori(
                title: "Monitoring",
                icon: 'assets/icons/monitoring.png',
                ontaps: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MonitoringScreen(
                                imageTeacher: widget.imageTeacher,
                                role: widget.role,
                              )));
                },
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              ),
              ItemKategori(
                title: "Fasilitas",
                icon: 'assets/icons/fasilitas.png',
                ontaps: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FasilitasScreen(
                                role: widget.role,
                                statusStudent: widget.statusStudent,
                              )));
                },
              ),
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
                title: "Data Siswa",
                icon: 'assets/icons/data-siswa.png',
                ontaps: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DataSiswaScreen(
                                role: widget.role,
                              )));
                },
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              widget.isWali == 'true'
                  ? ItemKategori(
                      title: "Rapor",
                      icon: 'assets/icons/rapot.png',
                      ontaps: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RaporScreen(
                                      role: widget.role,
                                      nisnSIswa: widget.nisnSIswa,
                                      nameSiswa: widget.nameSiswa,
                                    )));
                      },
                    )
                  : ItemKategori(
                      title: "",
                      icon: 'assets/icons/blank.png',
                      ontaps: () {},
                    ),
              ItemKategori(
                title: "",
                icon: 'assets/icons/blank.png',
                ontaps: () {},
              )
            ],
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:siakad_app/screens/home/absensi/absensi_student.dart';
import 'package:siakad_app/screens/home/component/item_kategori.dart';
import 'package:siakad_app/widget/data-user/data_pegawai_screen.dart';
import 'package:siakad_app/widget/fasilitas/fasilitas_screen.dart';
import 'package:siakad_app/widget/jadwal/jadwal_screen.dart';
import 'package:siakad_app/widget/laporan-keuangan/laporan-keuangan-screen.dart';
import 'package:siakad_app/widget/mutasi/mutasi_screen.dart';
import 'package:siakad_app/widget/penilaian/comp/pilih_penilaian_siswa.dart';
import 'package:siakad_app/widget/penilaian/penilaian_screen.dart';
import 'package:siakad_app/widget/rapor/rapor_screen.dart';

import '../../../../widget/data-user/data_siswa_screen.dart';
import '../../../../widget/kantin/kantin_screen.dart';
import '../../../../widget/koperasi/koperasi_screen.dart';
import '../../../../widget/perpustakaan/perpustakaan_screen.dart';

class KategoriSiswa extends StatefulWidget {
  const KategoriSiswa(
      {Key? key,
      required this.role,
      required this.className,
      required this.idClass,
      required this.idEkstra,
      required this.nameSiswa,
      required this.nisnSIswa,
      required this.statusStudent})
      : super(key: key);

  final String role, statusStudent;
  final String className, nameSiswa, nisnSIswa;
  final int idClass;
  final int idEkstra;

  @override
  State<KategoriSiswa> createState() => _KategoriSiswaState();
}

class _KategoriSiswaState extends State<KategoriSiswa> {
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
                          builder: (context) => const AbsensiStudent()));
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
                          builder: (context) => PilihPenilaianSiswa()));
                },
              ),
              ItemKategori(
                title: "Rapor",
                icon: 'assets/icons/rapot.png',
                ontaps: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RaporScreen(
                                role: widget.role,
                                nameSiswa: widget.nameSiswa,
                                nisnSIswa: widget.nisnSIswa,
                              )));
                },
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            children: [
              ItemKategori(
                title: "Data Pegawai",
                icon: 'assets/icons/data-pegawai.png',
                ontaps: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DataPegawaiScreen(
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
                title: "Mutasi",
                icon: 'assets/icons/mutasi.png',
                ontaps: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MutasiScreen(
                                role: widget.role,
                              )));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:siakad_app/screens/home/absensi/absensi_pegawai.dart';
import 'package:siakad_app/screens/home/component/item_kategori.dart';
import 'package:siakad_app/screens/home/registrasi/registrasi_screen.dart';
import 'package:siakad_app/widget/data-user/data_siswa_screen.dart';
import 'package:siakad_app/widget/jadwal/jadwal_screen.dart';
import 'package:siakad_app/widget/kantin/kantin_screen.dart';
import 'package:siakad_app/widget/koperasi/koperasi_screen.dart';
import 'package:siakad_app/widget/laporan-keuangan/laporan-keuangan-screen.dart';

import '../../../../widget/data-user/data_pegawai_screen.dart';
import '../../../../widget/mutasi/mutasi_screen.dart';
import '../../../../widget/perpustakaan/perpustakaan_screen.dart';

class KategoriAdmin extends StatefulWidget {
  const KategoriAdmin(
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
  State<KategoriAdmin> createState() => _KategoriAdminState();
}

class _KategoriAdminState extends State<KategoriAdmin> {
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
                title: "Daftar",
                icon: 'assets/icons/register.png',
                ontaps: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegistrasiScreen()));
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
              ItemKategori(
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

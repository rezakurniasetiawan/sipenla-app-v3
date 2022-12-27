// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:siakad_app/screens/home/component/item_kategori.dart';
import 'package:siakad_app/widget/laporan-keuangan/laporan-keuangan-screen.dart';

import '../../../../widget/jadwal/jadwal_screen.dart';
import '../../../../widget/kantin/kantin_screen.dart';
import '../../../../widget/koperasi/koperasi_screen.dart';
import '../../../../widget/mutasi/mutasi_screen.dart';
import '../../../../widget/perpustakaan/perpustakaan_screen.dart';
import '../../absensi/absensi_student.dart';

class KategoriWaliMurid extends StatefulWidget {
  const KategoriWaliMurid({Key? key, required this.role, required this.idClass}) : super(key: key);

  final String role, idClass;

  @override
  State<KategoriWaliMurid> createState() => _KategoriWaliMuridState();
}

class _KategoriWaliMuridState extends State<KategoriWaliMurid> {
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
                icon: 'assets/icons/jadwal.png',
                ontaps: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => JadwalScreen(
                                role: widget.role,
                                className: '',
                                idClass: int.parse(widget.idClass),
                                idEkstra: 0,
                              )));
                },
              ),
              ItemKategori(
                title: "Penilaian",
                icon: 'assets/icons/penilaian.png',
                ontaps: () {},
              ),
              ItemKategori(
                title: "Rapot",
                icon: 'assets/icons/rapot.png',
                ontaps: () {},
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
                ontaps: () {},
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
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

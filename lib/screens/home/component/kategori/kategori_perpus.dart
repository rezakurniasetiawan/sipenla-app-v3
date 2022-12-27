import 'package:flutter/material.dart';
import 'package:siakad_app/screens/home/absensi/absensi_pegawai.dart';
import 'package:siakad_app/screens/home/component/item_kategori.dart';
import 'package:siakad_app/widget/jadwal/jadwal_screen.dart';
import 'package:siakad_app/widget/laporan-keuangan/laporan-keuangan-screen.dart';
import 'package:siakad_app/widget/perpustakaan/perpustakaan_screen.dart';

import '../../../../widget/kantin/kantin_screen.dart';
import '../../../../widget/koperasi/koperasi_screen.dart';

class KategoriPerpus extends StatefulWidget {
  const KategoriPerpus(
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
  State<KategoriPerpus> createState() => _KategoriPerpusState();
}

class _KategoriPerpusState extends State<KategoriPerpus> {
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
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

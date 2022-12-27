import 'package:flutter/material.dart';

class SyaratDanKetentuan extends StatefulWidget {
  const SyaratDanKetentuan({Key? key}) : super(key: key);

  @override
  State<SyaratDanKetentuan> createState() => _SyaratDanKetentuanState();
}

class _SyaratDanKetentuanState extends State<SyaratDanKetentuan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Syarat Dan Ketentuan",
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "SYARAT DAN KETENTUAN PENGGUNAAN APLIKASI PERPUSTAKAAN UNSYIAH",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xff4B556B),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "A. KETENTUAN UMUM",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xff4B556B),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),
              const ListNumberSyarat(
                number: '1. ',
                content:
                    "Aplikasi Perpustakaan Unsyiah dapat digunakan untuk memperoleh informasi yang berhubungan data koleksi/katalog dan informasi tentang transaksi/kegiatan perpustakaan.",
              ),
              const ListNumberSyarat(
                number: '2. ',
                content:
                    "Data registrasi Pengguna dapat dipertanggungjawabkan.",
              ),
              const ListNumberSyarat(
                number: '3. ',
                content:
                    "Dengan menjadi Pengguna Aplikasi Perpustakaan Unsyiah maka Pengguna dianggap telah Memahami/Mengerti dan Menyetujui Semua isi di dalam Persyaratan dan Ketentuan Penggunaan Aplikasi Perpustakaan Unsyiah, Panduan Pengguna, dan Ketentuan lain yang diterbitkan oleh Perpustakaan Unsyiah.",
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "B. KEANGGOTAAN PENGGUNA",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xff4B556B),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),
              Row(
                children: const [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "1. Registrasi Pengguna",
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xff4B556B),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
              const ListNumberSyarat(
                number: 'a. ',
                content:
                    "Semua anggota menyetujui untuk sepenuhnya mematuhi syarat dan ketentuan Perpustakaan.",
              ),
              const ListNumberSyarat(
                number: 'b. ',
                content:
                    "Semua anggota bertanggung jawab untuk memberitahukan perubahan informasi pribadi mereka kepada Perpustakaan Unsyiah. Perpustakaan Unsyiah tidak akan bertanggung jawab atas hilangnya kartu atau data anggota dan dipergunakan oleh pihak lain.",
              ),
              const ListNumberSyarat(
                number: 'c. ',
                content:
                    "Perpustakaan Unsyiah berhak untuk mengubah dan memperbaiki Syarat & Ketentuan ‘Perpustakaan Unsyiah’, termasuk mengakhiri atau mengahapus status keanggotaan setiap saat tanpa pemberitahuan terlebih dahulu.",
              ),
              const ListNumberSyarat(
                number: 'd. ',
                content:
                    "Anggota disarankan memberitahukan jika terjadi kekeluruan tehadap data informasi pribadi anggota ke pihak Perpustakaan Unsyiah.",
              ),
              const ListNumberSyarat(
                number: 'e. ',
                content:
                    "Perpustakaan Unsyiah tidak akan bertanggung jawab atas penggunaan yang tidak sah dari kartu anggota yang hilang atau dicuri. Perpustakaan Unsyiah berhak untuk menarik kartu anggota jika kedapatan dipakai oleh pihak lain.",
              ),
              const ListNumberSyarat(
                number: 'f. ',
                content:
                    "Dalam hal terjadi perbedaan pendapat berkaitan dengan Keanggotaan dan Syarat dan Ketentuan di atas, putusan Perpustakaan akan menjadi putusan akhir yang mengikat. Saya membenarkan bahwa saya telah membaca dan setuju atas Syarat dan Ketentuan di atas terkait dengan Keanggotaan Perpustakaan Unsyiah.",
              ),
              Row(
                children: const [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "2. Kewajiban Pengguna",
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xff4B556B),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
              const ListNumberSyarat(
                number: 'a. ',
                content:
                    "Memenuhi Ketentuan Peraturan Perundang-Undangan yang berlaku di Negara Republik Indonesia dan Kebijakan yang berlaku dalam Aplikasi Perpustakaan Unsyiah.",
              ),
              const ListNumberSyarat(
                number: 'b. ',
                content:
                    "Setiap Pengguna bertanggungjawab Terhadap Kerahasiaan Hak Akses, Informasi dan Aktivitas Lainnya dalam Aplikasi Perpustakaan Unsyiah.",
              ),
              const ListNumberSyarat(
                number: 'c. ',
                content:
                    "Setiap Penyalahgunaan Hak Akses oleh Pihak Lain menjadi Tanggung Jawab Pengguna.",
              ),
              const ListNumberSyarat(
                number: 'd. ',
                content:
                    "Menjaga kerahasiaan dan mencegah penyalahgunaan data dan informasi yang tidak diperuntukkan bagi khalayak umum.",
              ),
              const ListNumberSyarat(
                number: 'e. ',
                content:
                    "Pengguna bertanggung jawab terhadap setiap kekeliruan dan atau kelalaian atas aplikasi Perpustakaan Unsyiah yang tidak menjadi tanggung jawab Perpustakaan Unsyiah.",
              ),
              Row(
                children: const [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "3. Ketentuan Pengguna",
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xff4B556B),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
              const ListNumberSyarat(
                number: 'a. ',
                content:
                    "Pengguna setuju bahwa menggunakan aplikasi Perpustakaan Unsyiah tidak boleh melanggar peraturan perundang-undangan yang berlaku di negara republik Indonesia.",
              ),
              const ListNumberSyarat(
                number: 'b. ',
                content:
                    "Pengguna wajib tunduk dan taat pada semua peraturan yang berlaku di negara Republik Indonesia yang berhubungan dengan penggunaan jaringan dan komunikasi data baik di wilayah negara Indonesia maupun dari dan keluar wilayah negara Indonesia melalui aplikasi Perpustakaan Unsyiah.",
              ),
              const ListNumberSyarat(
                number: 'c. ',
                content:
                    "Pengguna bertanggungjawab penuh atas komunikasi yang dilakukan dengan menggunakan aplikasi Perpustakaan Unsyiah.",
              ),
              const ListNumberSyarat(
                number: 'd. ',
                content:
                    "Pengguna setuju bahwa usaha untuk memanipulasi data, mengacaukan sistem dan jaringan Perpustakaan Unsyiah adalah tindakan melanggar hukum.",
              ),
              Row(
                children: const [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "4. Pembatalan dan Pemblokiran Pengguna",
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xff4B556B),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
              const ListNumberSyarat(
                number: 'a. ',
                content:
                    "Perpustakaan Unsyiah berhak menunda/menghalangi sementara/membatalkan hak akses pengguna apabila ditemukan adanya informasi/aktivitas yang tidak dibenarkan sesuai ketentuan yang berlaku.",
              ),
              const ListNumberSyarat(
                number: 'b. ',
                content:
                    "Pengguna diperbolehkan/mempunyai hak untuk menghapus aplikasi perpustakaan unsyiah di perangkat pengguna.",
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "C. TANGGUNG JAWAB DAN AKIBAT",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xff4B556B),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),
              const ListNumberSyarat(
                number: '1. ',
                content:
                    "Perpustakaan Unsyiah tidak bertanggung jawab atas semua akibat karena pelanggaran hukum yang terjadi pada Perpustakaan Unsyiah yang dilakukan pengguna dan pihak lain.",
              ),
              const ListNumberSyarat(
                number: '2. ',
                content:
                    "Perpustakaan Unsyiah tidak bertanggung jawab atas semua akibat adanya gangguan infrastruktur yang berakibat pada terganggunya proses penggunaan aplikasi Perpustakaan Unsyiah.",
              ),
              const ListNumberSyarat(
                number: '3. ',
                content:
                    "Perpustakaan Unsyiah tidak bertanggung jawab atas segala akibat penyalahgunaan aplikasi Perpustakaan Unsyiah yang dilakukan oleh pengguna atau pihak lain.",
              ),
              const ListNumberSyarat(
                number: '4. ',
                content:
                    "Perpustakaan Unsyiah tidak menjamin aplikasi Perpustakaan Unsyiah berlangsung terus secara handal/tanpa adanya gangguan.",
              ),
              const ListNumberSyarat(
                number: '5. ',
                content:
                    "Perpustakaan Unsyiah berusaha terus melakukan inovasi, meningkatkan dan memperbaiki performance aplikasi Perpustakaan Unsyiah.",
              ),
              const ListNumberSyarat(
                number: '6. ',
                content:
                    "Perpustakaan Unsyiah dapat membantu pengguna Aplikasi Perpustakaan Unsyiah terkait dengan penyelesaian kesalahan penggunaan atau penyelesaian keterbatasan fasilitas/fitur aplikasi namun tidak bertanggungjawab atas hasil yang diakibatkan oleh tindakannya.",
              ),
              const ListNumberSyarat(
                number: '7. ',
                content:
                    "Perpustakaan Unsyiah dapat melakukan suatu tindakan yang dianggap perlu terhadap Pengguna.",
              ),
              const ListNumberSyarat(
                number: '8. ',
                content:
                    "Pengguna menanggung segala akibat terhadap komunikasi yang dilakukan dalam menggunakan aplikasi Perpustakaan Unsyiah.",
              ),
              const ListNumberSyarat(
                number: '9. ',
                content:
                    "Perpustakaan Unsyiah tidak bertanggung jawab atas kehilangan data pengguna baik secara langsung maupun tidak langsung, ataupun kerugian karena kehilangan pendapatan/keuntungan nyata yang diharapkan pengguna, dan tuntutan dari pihak manapun atas terganggunya pelayanan jasa Perpustakaan Unsyiah. Apabila kejadian tersebut terjadi, maka pengguna tidak akan menyalahkan Perpustakaan Unsyiah dalam bentuk apapun.",
              ),
              const ListNumberSyarat(
                number: '10. ',
                content:
                    "Perpustakaan Unsyiah tidak bertanggung jawab atas segala kerusakan, kehilangan data, kerusakan sistem perangkat pengguna, dan tidak memberikan kompensasi apapun, yang diakibatkan oleh penggunaan layanan atau aplikasi Perpustakaan Unsyiah (yang termasuk, namun tidak terbatas pada: Terputusnya koneksi dari pihak uplink/isp/provider internet, kerusakan hardware, kesalahan pengguna, kelalaian pihak perpustakaan unsyiah yang tidak sengaja, dan lain sebagainya).",
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "D. HAK CIPTA",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xff4B556B),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),
              const ListNumberSyarat(
                number: '1. ',
                content:
                    "Pengguna atau pihak lain dilarang mengubah, mengutip atau menyalin sebagian atau seluruh isi yang terdapat di dalam Aplikasi Perpustakaan Unsyiah tanpa izin. Pelanggaran atas ketentuan ini dapat dituntut dan digugat berdasarkan peraturan hukum pidana dan perdata yang berlaku di Negara Indonesia.",
              ),
              const ListNumberSyarat(
                number: '2. ',
                content:
                    "Pengguna setuju tidak akan dengan cara apapun memanfaatkan, memperbanyak, atau berperan dalam penjualan/menyebarkan setiap isi yang diperoleh dari aplikasi Perpustakaan Unsyiah untuk kepentingan pribadi dan atau komersial.",
              ),
              const Text(
                "E. PERUBAHAN",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xff4B556B),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),
              const ListNumberSyarat(
                number: '1. ',
                content:
                    "Perpustakaan Unsyiah berhak/dapat menambah, mengurangi, memperbaiki aturan dan ketentuan aplikasi Perpustakaan Unsyiah ini setiap saat, dengan atau tanpa pemberitahuan sebelumnya.",
              ),
              const ListNumberSyarat(
                number: '2. ',
                content:
                    "Perpustakaan Unsyiah berhak/dapat menambah, mengurangi, memperbaiki fasilitas/fitur yang disediakan aplikasi Perpustakaan Unsyiah ini setiap saat, dengan atau tanpa pemberitahuan sebelumnya.",
              ),
              const ListNumberSyarat(
                number: '3. ',
                content:
                    "Pengguna wajib taat kepada aturan dan ketentuan yang telah ditambah, dikurangi, diperbaiki tersebut. Apabila pengguna tidak setuju dapat mengajukan keberatan dan mengundurkan diri dengan menghapus aplikasi perpustakaan unsyiah dari perangkat pengguna.",
              ),
              const ListNumberSyarat(
                number: '4. ',
                content:
                    "Dengan maupun tanpa alasan, Perpustakaan Unsyiah berhak menghentikan penggunaan aplikasi Perpustakaan Unsyiah dan akses jasa ini tanpa menanggung kewajiban apapun kepada pengguna apabila penghentian operasional ini terpaksa dilakukan.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListNumberSyarat extends StatelessWidget {
  const ListNumberSyarat({
    Key? key,
    required this.number,
    required this.content,
  }) : super(key: key);

  final String number, content;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          width: 20,
        ),
        Text(
          number,
          style: const TextStyle(
            fontSize: 10,
            color: Color(0xff4B556B),
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            letterSpacing: 1,
          ),
        ),
        Expanded(
          child: Text(
            content,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xff4B556B),
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              letterSpacing: 1,
            ),
          ),
        ),
      ],
    );
  }
}

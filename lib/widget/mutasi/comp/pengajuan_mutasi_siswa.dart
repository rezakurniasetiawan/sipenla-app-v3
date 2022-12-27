import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../constan.dart';
import '../../../models/api_response_model.dart';
import '../../../models/student_model.dart';
import '../../../screens/check_userdata.dart';
import '../../../screens/started_screen.dart';
import '../../../services/auth_service.dart';

class PengajuanMutasiSiswa extends StatefulWidget {
  const PengajuanMutasiSiswa({Key? key}) : super(key: key);

  @override
  State<PengajuanMutasiSiswa> createState() => _PengajuanMutasiSiswaState();
}

class _PengajuanMutasiSiswaState extends State<PengajuanMutasiSiswa> {
  TextEditingController namadepan = TextEditingController();
  TextEditingController namabelakang = TextEditingController();
  TextEditingController nisn = TextEditingController();
  TextEditingController tempatlahir = TextEditingController();
  TextEditingController tanggallahir = TextEditingController();
  TextEditingController jeniskelamin = TextEditingController();
  TextEditingController agama = TextEditingController();
  TextEditingController alamattinggal = TextEditingController();
  TextEditingController pindahke = TextEditingController();

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(
            color: Colors.blueAccent,
          ),
          Container(
              margin: const EdgeInsets.only(left: 5),
              child: const Text("Loading")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  StudentModel? studentModel;
  bool loading = true;
  bool _loading = false;

  void getUser() async {
    ApiResponse response = await getUserDetail();
    if (response.error == null) {
      setState(() {
        studentModel = response.data as StudentModel;
        namadepan.text = studentModel!.studentFirstName;
        namabelakang.text = studentModel!.studentLastName;
        nisn.text = studentModel!.nisn;
        tempatlahir.text = studentModel!.placeOfBirth;
        tanggallahir.text = studentModel!.dateOfBirth;
        jeniskelamin.text = studentModel!.gender;
        agama.text = studentModel!.religion;
        alamattinggal.text = studentModel!.address;
        loading = false;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const GetStartedScreen()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  void fungsiPengajuanMutasi() async {
    showAlertDialog(context);
    String token = await getToken();
    Map<String, String> headers = {
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    };
    var uri = Uri.parse(baseURL + '/api/mutasi/add');
    var request = http.MultipartRequest('POST', uri);

    request.files.add(await http.MultipartFile.fromPath(
        'letter_school_transfer', filesPermohonan!.first.path.toString()));
    request.files.add(await http.MultipartFile.fromPath(
        'letter_ijazah', filesIjazah!.first.path.toString()));
    request.files.add(await http.MultipartFile.fromPath(
        'rapor', filesRapor!.first.path.toString()));
    request.files.add(await http.MultipartFile.fromPath(
        'letter_no_sanksi', filesPernyataan!.first.path.toString()));
    request.files.add(await http.MultipartFile.fromPath(
        'letter_recom_diknas', filesRekomendasi!.first.path.toString()));
    request.files.add(await http.MultipartFile.fromPath(
        'kartu_keluarga', filesKK!.first.path.toString()));
    request.files.add(await http.MultipartFile.fromPath(
        'surat_keterangan_pindah_sekolah',
        filesKeterangan!.first.path.toString()));

    request.headers.addAll(headers);
    request.fields['to_school'] = pindahke.text;
    var response = await request.send();
    if (response.statusCode == 200) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pengajuan Mutasi Berhasil')));
      Navigator.pop(context);
    } else if (response.statusCode == 400) {
      print(response.request);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Ada Kesalahan')));
      setState(() {
        _loading = !_loading;
      });
      Navigator.pop(context);
    }
  }

  String? nameFilePermohonan;
  List<PlatformFile>? filesPermohonan;

  void ambilFilePermohonan() async {
    filesPermohonan = (await FilePicker.platform.pickFiles(
            type: FileType.any, allowMultiple: false, allowedExtensions: null))!
        .files;

    setState(() {
      nameFilePermohonan = filesPermohonan!.first.name;
    });
  }

  String? nameFileIjazah;
  List<PlatformFile>? filesIjazah;

  void ambilFileIjazah() async {
    filesIjazah = (await FilePicker.platform.pickFiles(
            type: FileType.any, allowMultiple: false, allowedExtensions: null))!
        .files;

    setState(() {
      nameFileIjazah = filesIjazah!.first.name;
    });
  }

  String? nameFileRapor;
  List<PlatformFile>? filesRapor;

  void ambilFileRapor() async {
    filesRapor = (await FilePicker.platform.pickFiles(
            type: FileType.any, allowMultiple: false, allowedExtensions: null))!
        .files;

    setState(() {
      nameFileRapor = filesRapor!.first.name;
    });
  }

  String? nameFilePernyataan;
  List<PlatformFile>? filesPernyataan;

  void ambilFilePernyataan() async {
    filesPernyataan = (await FilePicker.platform.pickFiles(
            type: FileType.any, allowMultiple: false, allowedExtensions: null))!
        .files;

    setState(() {
      nameFilePernyataan = filesPernyataan!.first.name;
    });
  }

  String? nameFileRekomendasi;
  List<PlatformFile>? filesRekomendasi;

  void ambilFileRekomendasi() async {
    filesRekomendasi = (await FilePicker.platform.pickFiles(
            type: FileType.any, allowMultiple: false, allowedExtensions: null))!
        .files;

    setState(() {
      nameFileRekomendasi = filesRekomendasi!.first.name;
    });
  }

  String? nameFileKK;
  List<PlatformFile>? filesKK;

  void ambilFileKK() async {
    filesKK = (await FilePicker.platform.pickFiles(
            type: FileType.any, allowMultiple: false, allowedExtensions: null))!
        .files;

    setState(() {
      nameFileKK = filesKK!.first.name;
    });
  }

  String? nameFileKeterangan;
  List<PlatformFile>? filesKeterangan;

  void ambilFileKeterangan() async {
    filesKeterangan = (await FilePicker.platform.pickFiles(
            type: FileType.any, allowMultiple: false, allowedExtensions: null))!
        .files;

    setState(() {
      nameFileKeterangan = filesKeterangan!.first.name;
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pengajuan Mutasi",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: loading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blueAccent,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 25,
                          child: Image.asset('assets/image/logo-sipenla.png'),
                        ),
                        SizedBox(
                          height: 25,
                          child: Image.asset('assets/image/kemendikbud.png'),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Center(
                      child: Text(
                        "FOLUMULIR",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff4B556B),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Column(
                        children: [
                          const Text(
                            "Pengajuan Mutasi",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff4B556B),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                            ),
                          ),
                          Container(
                            height: 1,
                            width: MediaQuery.of(context).size.width * 0.4,
                            color: Color(0xff4B556B),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Nama Lengkap",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                        color: Color(0xff4B556B),
                      ),
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFormField(
                          controller: namadepan,
                          readOnly: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Masukkan Nama Depan',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Wajib Di isi';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFormField(
                          controller: namabelakang,
                          readOnly: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Masukkan Nama Belakang',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Wajib Di isi';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "NISN",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                        color: Color(0xff4B556B),
                      ),
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFormField(
                          controller: nisn,
                          readOnly: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Masukkan NISN',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Wajib Di isi';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Tempat, Tanggal Lahir",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                        color: Color(0xff4B556B),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: TextFormField(
                                controller: tempatlahir,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Masuukan Tempat Lahir',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Wajib Di isi';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: TextFormField(
                                controller: tanggallahir,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: ImageIcon(AssetImage(
                                      'assets/icons/calendar_month.png')),
                                  hintText: 'yyyy-mm-dd',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Wajib Di isi';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Jenis Kelamin",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                        color: Color(0xff4B556B),
                      ),
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFormField(
                          controller: jeniskelamin,
                          readOnly: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Masukkan Jenis Kelamin',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Wajib Di isi';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Agama",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                        color: Color(0xff4B556B),
                      ),
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFormField(
                          controller: agama,
                          readOnly: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Masukkan Agama',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Wajib Di isi';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Alamat Tinggal",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                        color: Color(0xff4B556B),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFormField(
                          maxLines: 4,
                          controller: alamattinggal,
                          readOnly: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Masukkan Alamat Tinggal',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Wajib Di isi';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: const [
                        Text(
                          "Pindah Ke",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                            color: Color(0xff4B556B),
                          ),
                        ),
                        Text(
                          " * ",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              color: Colors.red),
                        ),
                      ],
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFormField(
                          controller: pindahke,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Masukkan Pindah ke',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Wajib Di isi';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: const [
                        Text(
                          "Surat Permohonan Pindah Dari Orang Tua / Wali",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                            color: Color(0xff4B556B),
                          ),
                        ),
                        Text(
                          " * ",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              color: Colors.red),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFormField(
                          // controller: textEmail,
                          readOnly: true,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: nameFilePermohonan == null
                                  ? 'Unggah Dokumen'
                                  : '$nameFilePermohonan'),
                          onTap: () {
                            ambilFilePermohonan();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: const [
                        Text(
                          "Ijazah",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                            color: Color(0xff4B556B),
                          ),
                        ),
                        Text(
                          " * ",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              color: Colors.red),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFormField(
                          // controller: textEmail,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: nameFileIjazah == null
                                ? 'Pilih Dokumen'
                                : '$nameFileIjazah',
                          ),
                          onTap: () {
                            ambilFileIjazah();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: const [
                        Text(
                          "Rapor",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                            color: Color(0xff4B556B),
                          ),
                        ),
                        Text(
                          " * ",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              color: Colors.red),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFormField(
                          // controller: textEmail,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: nameFileRapor == null
                                ? 'Pilih Dokumen'
                                : '$nameFileRapor',
                          ),
                          onTap: () {
                            ambilFileRapor();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: const [
                        Text(
                          "Surat Pernyataan Tidak Sedang Menjalani Sanksi",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                            color: Color(0xff4B556B),
                          ),
                        ),
                        Text(
                          " * ",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              color: Colors.red),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFormField(
                          // controller: textEmail,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: nameFilePernyataan == null
                                ? 'Pilih Dokumen'
                                : '$nameFilePernyataan',
                          ),
                          onTap: () {
                            ambilFilePernyataan();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: const [
                        Text(
                          "Surat Rekomendasi Dari Diknas",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                            color: Color(0xff4B556B),
                          ),
                        ),
                        Text(
                          " * ",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              color: Colors.red),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFormField(
                          // controller: textEmail,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: nameFileRekomendasi == null
                                ? 'Pilih Dokumen'
                                : '$nameFileRekomendasi',
                          ),
                          onTap: () {
                            ambilFileRekomendasi();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: const [
                        Text(
                          "KK",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                            color: Color(0xff4B556B),
                          ),
                        ),
                        Text(
                          " * ",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              color: Colors.red),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFormField(
                          // controller: textEmail,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: nameFileKK == null
                                ? 'Pilih Dokumen'
                                : '$nameFileKK',
                          ),
                          onTap: () {
                            ambilFileKK();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: const [
                        Text(
                          "Surat Keterangan Pindah Dari Sekolah Asal",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                            color: Color(0xff4B556B),
                          ),
                        ),
                        Text(
                          " * ",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              color: Colors.red),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFormField(
                          // controller: textEmail,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: nameFileKeterangan == null
                                ? 'Pilih Dokumen'
                                : '$nameFileKeterangan',
                          ),
                          onTap: () {
                            ambilFileKeterangan();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        fungsiPengajuanMutasi();
                      },
                      child: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: const LinearGradient(
                              begin: FractionalOffset.centerLeft,
                              end: FractionalOffset.centerRight,
                              colors: [
                                Color(0xff2E447C),
                                Color(0xff3774C3),
                              ],
                            ),
                          ),
                          child: const Center(
                              child: Text(
                            "Kirim",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                letterSpacing: 1),
                          )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

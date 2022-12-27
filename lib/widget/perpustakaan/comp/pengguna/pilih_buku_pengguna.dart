import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:siakad_app/widget/perpustakaan/comp/pengguna/peminjaman_buku_pengguna.dart';
import 'package:http/http.dart' as http;

import '../../../../constan.dart';
import '../../../../models/api_response_model.dart';
import '../../../../models/perpustakaan/pegawai_perpus_model.dart';
import '../../../../screens/started_screen.dart';
import '../../../../services/auth_service.dart';
import '../../../../services/perpustakaan/pengguna_perpus_service.dart';

class PilihBukuPengguna extends StatefulWidget {
  const PilihBukuPengguna({Key? key}) : super(key: key);

  @override
  State<PilihBukuPengguna> createState() => PilihBukuPenggunaState();
}

class PilihBukuPenggunaState extends State<PilihBukuPengguna> {
  TextEditingController tanggal = TextEditingController();
  TextEditingController code = TextEditingController();
  TextEditingController jumlah = TextEditingController();
  String imageBook = '';

  TextEditingController codeBook = TextEditingController();
  TextEditingController nameBook = TextEditingController();

  DataBukuPenggunaPerpusModel? dataBukuPenggunaPerpusModel;
  DataBukuPerpusModel? dataBukuPerpusModel;
  bool loading = true;
  List bookList = [];
  var valuebook;

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

  void fungsiSeacrchBook() async {
    showAlertDialog(context);
    ApiResponse response = await searchBook(code: code.text);
    if (response.error == null) {
      setState(() {
        print(code.text);
        dataBukuPenggunaPerpusModel =
            response.data as DataBukuPenggunaPerpusModel;
        loading = false;
        if (dataBukuPenggunaPerpusModel!.bookId == 0) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Buku Kosong')));
        } else {
          valuebook = dataBukuPenggunaPerpusModel!.bookId.toString();
          fungsiGetFasilitasById();
        }
        Navigator.pop(context);
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

  void fungsiGetFasilitasById() async {
    showAlertDialog(context);
    ApiResponse response = await getBookbyId(idBook: valuebook.toString());
    if (response.error == null) {
      setState(() {
        dataBukuPerpusModel = response.data as DataBukuPerpusModel;
        nameBook.text = dataBukuPerpusModel!.bookName;
        code.text = dataBukuPerpusModel!.bookCode;
        print(code.text);
        imageBook = dataBukuPerpusModel!.image;
        Navigator.pop(context);
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

  Future getBookPerpus() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(baseURL + '/api/perpus/getbook'),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body)['data'];
      setState(() {
        bookList = jsonData;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getBookPerpus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Peminjaman Buku",
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
              const Text(
                "Kode Buku",
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
                  child: TextField(
                    controller: code,
                    textInputAction: TextInputAction.go,
                    onSubmitted: (value) {
                      fungsiSeacrchBook();
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Pencarian',
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Nama Buku",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  color: Color(0xff4B556B),
                ),
              ),
              Container(
                height: 48,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color(0xffF0F1F2),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      icon: const ImageIcon(
                        AssetImage('assets/icons/arrow-down.png'),
                      ),
                      dropdownColor: const Color(0xffF0F1F2),
                      borderRadius: BorderRadius.circular(15),
                      hint: const Text('Buku Perpustakaan'),
                      items: bookList.map((item) {
                        return DropdownMenuItem(
                          value: item['book_id'].toString(),
                          child: Text(item['book_name'].toString()),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          valuebook = newVal;
                          fungsiGetFasilitasById();
                          print(valuebook);
                        });
                      },
                      value: valuebook,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Jumlah Buku",
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
                    controller: jumlah,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Masukkan Jumlah Buku',
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
                "Pengarang",
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
                    // controller: jumlah,

                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Masukkan Pengarang Buku',
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
              const Text(
                "Tanggal Selesai Pinjam",
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
                    controller: tanggal,
                    readOnly: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: ImageIcon(
                          AssetImage('assets/icons/calendar_month.png')),
                      hintText: 'yyyy-mm-dd',
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));

                      if (pickedDate != null) {
                        // print(pickedDate);
                        String formattedDate =
                            DateFormat('yyyyMMdd').format(pickedDate);
                        print(formattedDate);

                        setState(() {
                          tanggal.text = formattedDate;
                        });
                      } else {
                        print("Date is not selected");
                      }
                    },
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
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xff2E447C),
                        ),
                      ),
                      child: const Center(
                          child: Text(
                        "Batal",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: Color(0xff2E447C),
                            letterSpacing: 1),
                      )),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      // if (valueFasilitas == null) {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //       const SnackBar(
                      //           content: Text('Fasilitas Tidak Boleh Kosong')));
                      // } else if (jumlah.text == '') {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //       const SnackBar(
                      //           content: Text('Jumlah Tidak Boleh Kosong')));
                      // } else if (tanggal.text == '') {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //       const SnackBar(
                      //           content: Text('Tanggal Tidak Boleh Kosong')));
                      // } else {
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => MapPeminjamanFasilitas(
                      //                 idFas: int.parse(valueFasilitas),
                      //                 jumlahFas: int.parse(jumlah.text),
                      //                 tanggalakhir: tanggal.text,
                      //                 tanggalawal: datenow,
                      //                 codeFas: codeFas.text,
                      //                 nameFas: nameFas.text,
                      //                 imageFas: imageFas,
                      //               )));
                      // }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PeminjamanBukuPengguna(
                            codeBuku: code.text,
                            jumlahBuku: int.parse(jumlah.text),
                            namaBuku: nameBook.text,
                            idBuku: int.parse(valuebook),
                            tanggalselesai: tanggal.text,
                            imageBook: imageBook,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
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
                        "Simpan",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            letterSpacing: 1),
                      )),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

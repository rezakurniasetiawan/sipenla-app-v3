import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;

import '../../../../constan.dart';
import '../../../../models/api_response_model.dart';
import '../../../../models/perpustakaan/mapping_peminjaman.dart';
import '../../../../models/perpustakaan/pegawai_perpus_model.dart';
import '../../../../screens/started_screen.dart';
import '../../../../services/auth_service.dart';
import '../../../../services/perpustakaan/pengguna_perpus_service.dart';

class PeminjamanBukuPengguna extends StatefulWidget {
  const PeminjamanBukuPengguna({
    Key? key,
    required this.codeBuku,
    required this.namaBuku,
    required this.jumlahBuku,
    required this.idBuku,
    required this.tanggalselesai,
    required this.imageBook,
  }) : super(key: key);

  final String codeBuku, namaBuku, tanggalselesai, imageBook;
  final int idBuku, jumlahBuku;

  @override
  State<PeminjamanBukuPengguna> createState() => _PeminjamanBukuPenggunaState();
}

class _PeminjamanBukuPenggunaState extends State<PeminjamanBukuPengguna> {
  TextEditingController idbook = TextEditingController();
  TextEditingController tanggalselesai = TextEditingController();
  TextEditingController code = TextEditingController();
  TextEditingController jumlah = TextEditingController();
  String imageBook = '';

  TextEditingController codeBook = TextEditingController();
  TextEditingController nameBook = TextEditingController();

  MappingServerBook mappingServerBook = MappingServerBook(books: []);
  MappingLocalBook mappingLocalBook = MappingLocalBook(books: []);

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
          // fungsiGetFasilitasById();
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

  void mappingData() {
    print(tanggalselesai.text);
    mappingServerBook.books.add(
      BookPeminjamanServer(
          bookId: int.parse(idbook.text),
          toDate: int.parse(tanggalselesai.text),
          totalBook: int.parse(jumlah.text)),
    );
    mappingLocalBook.books.add(BookPeminjamanLocal(
        bookId: int.parse(idbook.text),
        totalBook: int.parse(jumlah.text),
        toDate: int.parse(tanggalselesai.text),
        nameBook: nameBook.text,
        codeBook: code.text,
        imageBook: imageBook));

    setState(() {
      idbook.clear();
      // valueFasilitas = null;
      jumlah.clear();
      tanggalselesai.clear();
      code.clear();
      nameBook.clear();
      imageBook = '';
    });
  }

  void send() async {
    showAlertDialog(context);
    String token = await getToken();
    var response = await http.post(
      Uri.parse(baseURL + '/api/perpus/createloan'),
      headers: {
        "Content-type": "application/json",
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
      body: json.encode(mappingServerBook.toJson()),
    );
    print(response.body);
    print(response.statusCode);
    print(json.encode(mappingServerBook.toJson()));

    if (response.statusCode == 200) {
      print('OKe');
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Berhasil Melakukan Peminjaman Buku')));
      Navigator.pop(context);
    } else if (response.statusCode == 400) {
      String respon = json.decode(response.body)['meta']['message'];
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${respon}')));
    }
  }

  @override
  void initState() {
    super.initState();
    idbook.text = widget.idBuku.toString();
    jumlah.text = widget.jumlahBuku.toString();
    tanggalselesai.text = widget.tanggalselesai;
    nameBook.text = widget.namaBuku;
    code.text = widget.codeBuku;
    imageBook = widget.imageBook;
    // pengajuanFasilitasModel.books = <Bookss>[];
    // pengajuanFasilitasMappingModel.books = <Booksss>[];
    mappingData();
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
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: mappingServerBook.books.length,
            //     itemBuilder: (BuildContext context, int index) => Column(
            //       children: <Widget>[
            //         Text(mappingServerBook.books[index].bookId.toString()),
            //         Text(mappingServerBook.books[index].totalBook.toString()),
            //         Text(mappingServerBook.books[index].toDate.toString()),
            //         TextButton(
            //             onPressed: () {
            //               setState(() {
            //                 mappingServerBook.books.removeWhere((element) =>
            //                     element.bookId ==
            //                     mappingServerBook.books[index].bookId);
            //                 mappingServerBook.books.removeWhere((element) =>
            //                     element.bookId ==
            //                     mappingServerBook.books[index].bookId);
            //                 print('Hapus Sukses');
            //               });
            //             },
            //             child: Text('Hapus'))
            //       ],
            //     ),
            //   ),
            // ),
            Expanded(
                child: ListView.builder(
                    itemCount: mappingLocalBook.books.length,
                    itemBuilder: (BuildContext context, int index) => Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 83,
                                    height: 116,
                                    child: CachedNetworkImage(
                                      imageUrl: mappingLocalBook
                                          .books[index].imageBook,
                                      fit: BoxFit.cover,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        width: 83.0,
                                        height: 116.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      placeholder: (context, url) => Shimmer(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          gradient:
                                              const LinearGradient(stops: [
                                            0.2,
                                            0.5,
                                            0.6
                                          ], colors: [
                                            Colors.grey,
                                            Colors.white12,
                                            Colors.grey,
                                          ])),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Kode Buku',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff4B556B),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          mappingLocalBook
                                              .books[index].codeBook,
                                          style: const TextStyle(
                                            fontSize: 11,
                                            color: Color(0xff4B556B),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text(
                                          'Nama Buku',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff4B556B),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          mappingLocalBook
                                              .books[index].nameBook,
                                          style: const TextStyle(
                                            fontSize: 11,
                                            color: Color(0xff4B556B),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text(
                                          'Jumlah',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff4B556B),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          mappingLocalBook
                                              .books[index].totalBook
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 11,
                                            color: Color(0xff4B556B),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            child: AlertDialog(
                                              actions: [
                                                Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 85,
                                                      width: 85,
                                                      child: Image.asset(
                                                          'assets/icons/warning-icon.png'),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 15),
                                                      child: Text(
                                                        'Apakah Anda Yakin Ingin Menghapus Data Ini?',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontFamily: 'Poppins',
                                                          color:
                                                              Color(0xff4B556B),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          width: 130,
                                                          height: 44,
                                                          decoration: BoxDecoration(
                                                              color: const Color(
                                                                  0xffFF4238),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                          child: TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                "Batal",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    color: Colors
                                                                        .white),
                                                              )),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                          width: 130,
                                                          height: 44,
                                                          decoration: BoxDecoration(
                                                              color: const Color(
                                                                  0xff83BC10),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                          child: TextButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                mappingServerBook.books.removeWhere((element) =>
                                                                    element
                                                                        .bookId ==
                                                                    mappingServerBook
                                                                        .books[
                                                                            index]
                                                                        .bookId);
                                                                mappingLocalBook.books.removeWhere((element) =>
                                                                    element
                                                                        .bookId ==
                                                                    mappingLocalBook
                                                                        .books[
                                                                            index]
                                                                        .bookId);
                                                                print(
                                                                    'Hapus Sukses');
                                                              });
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                              "Setuju",
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    icon: const ImageIcon(
                                      AssetImage(
                                        "assets/icons/delete-news.png",
                                      ),
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ))),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      // isDismissible: false,
                      builder: (context) {
                        return SizedBox(
                          height: 800,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(Icons.arrow_back)),
                                  const Text(
                                    "Peminjaman Fasilitas",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xff4B556B),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15),
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
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: TextField(
                                          controller: code,
                                          textInputAction: TextInputAction.go,
                                          onSubmitted: (value) {
                                            fungsiSeacrchBook();
                                            FocusScope.of(context).nextFocus();
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
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            icon: const ImageIcon(
                                              AssetImage(
                                                  'assets/icons/arrow-down.png'),
                                            ),
                                            dropdownColor:
                                                const Color(0xffF0F1F2),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            hint:
                                                const Text('Buku Perpustakaan'),
                                            items: bookList.map((item) {
                                              return DropdownMenuItem(
                                                value:
                                                    item['book_id'].toString(),
                                                child: Text(item['book_name']
                                                    .toString()),
                                              );
                                            }).toList(),
                                            onChanged: (newVal) {
                                              setState(() {
                                                valuebook = newVal;
                                                fungsiGetFasilitasById();
                                                FocusScope.of(context)
                                                    .nextFocus();
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
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: TextFormField(
                                          controller: jumlah,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Masukkan Jumlah Buku',
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
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
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: TextFormField(
                                          // controller: jumlah,

                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Masukkan Pengarang Buku',
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
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
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: TextFormField(
                                          controller: tanggalselesai,
                                          readOnly: true,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            suffixIcon: ImageIcon(AssetImage(
                                                'assets/icons/calendar_month.png')),
                                            hintText: 'yyyy-mm-dd',
                                          ),
                                          onTap: () async {
                                            DateTime? pickedDate =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2000),
                                                    lastDate: DateTime(2101));

                                            if (pickedDate != null) {
                                              // print(pickedDate);
                                              String formattedDate =
                                                  DateFormat('yyyyMMdd')
                                                      .format(pickedDate);
                                              print(formattedDate);

                                              setState(() {
                                                tanggalselesai.text =
                                                    formattedDate;
                                              });
                                            } else {
                                              print("Date is not selected");
                                            }
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.45,
                                            height: 45,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
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
                                            if (valuebook == null) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'Fasilitas Tidak Boleh Kosong')));
                                            } else if (jumlah.text == '') {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'Jumlah Tidak Boleh Kosong')));
                                            } else if (tanggalselesai.text ==
                                                '') {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'Tanggal Tidak Boleh Kosong')));
                                            } else {
                                              idbook.text =
                                                  valuebook.toString();
                                              mappingData();
                                              Navigator.pop(context);
                                            }
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.45,
                                            height: 45,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              gradient: const LinearGradient(
                                                begin:
                                                    FractionalOffset.centerLeft,
                                                end: FractionalOffset
                                                    .centerRight,
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
                            ],
                          ),
                        );
                      },
                    );
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
                      "Tambah Buku",
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
                    send();
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
                      "Pinjam",
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
    );
  }
}

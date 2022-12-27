import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/employee_model.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:siakad_app/services/data_user_services.dart';

import '../../constan.dart';

class DataPegawaibyId extends StatefulWidget {
  const DataPegawaibyId({Key? key, required this.idEmployee}) : super(key: key);

  final String idEmployee;

  @override
  State<DataPegawaibyId> createState() => _DataPegawaibyIdState();
}

class _DataPegawaibyIdState extends State<DataPegawaibyId> {
  EmployeeData? employeeData;
  bool loading = true;

  void getUserData() async {
    ApiResponse response =
        await getDataEmployeebyId(idEmployee: widget.idEmployee);
    if (response.error == null) {
      setState(() {
        employeeData = response.data as EmployeeData;
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

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Data Pegawai",
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
      body: loading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blueAccent,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 40,
                        child: Image.asset('assets/image/logo.png'),
                      ),
                      SizedBox(
                        height: 40,
                        child: Image.asset('assets/image/logo.png'),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                    child: Text(
                      "DATA PENERIMAAN PEGAWAI",
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
                    height: 15,
                  ),
                  const Center(
                    child: Text(
                      "Biodata Pegawai",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff4B556B),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 42,
                  ),
                  ItemData(
                    title: "1. Nama Lengkap",
                    respons:
                        employeeData!.firstName + " " + employeeData!.lastName,
                  ),
                  // ItemData(title: "2. NIK", respons: employeeData!.nik),
                  ItemData(title: "3. NUPTK", respons: employeeData!.nuptk),
                  ItemData(title: "4. NPSN", respons: employeeData!.npsn),
                  ItemData(
                      title: "5. Tempat, Tanggal Lahir",
                      respons: employeeData!.placeOfBirth +
                          " " +
                          employeeData!.dateOfBirth),
                  ItemData(
                      title: "6. Jenis Kelamin", respons: employeeData!.gender),
                  ItemData(title: "7. Agama", respons: employeeData!.religion),
                  ItemData(
                      title: "8. Alamat Tinggal",
                      respons: employeeData!.address),
                  ItemData(
                      title: "9. Riwayat Pendidikan",
                      respons: employeeData!.education),
                  ItemData(
                      title: "10. Nama Ibu", respons: employeeData!.familyName),
                  // ItemData(title: "11. Email", respons: email),
                  ItemData(
                      title: "12. Jabatan 1", respons: employeeData!.position),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                '15. Foto',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff4B556B),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                ': ',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff4B556B),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 140,
                                    height: 160,
                                    child: employeeData!.image != null
                                        ? CachedNetworkImage(
                                            imageUrl: employeeData!.image,
                                            fit: BoxFit.cover,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              height: 100.0,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                Shimmer(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    gradient:
                                                        const LinearGradient(
                                                            stops: [
                                                          0.2,
                                                          0.5,
                                                          0.6
                                                        ],
                                                            colors: [
                                                          Colors.grey,
                                                          Colors.white12,
                                                          Colors.grey,
                                                        ])),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          )
                                        : Shimmer(
                                            child: Container(
                                              width: 100,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                            ),
                                            gradient: const LinearGradient(
                                              stops: [0.2, 0.5, 0.6],
                                              colors: [
                                                Colors.grey,
                                                Colors.white12,
                                                Colors.grey,
                                              ],
                                            ),
                                          ),
                                  ),
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
    );
  }
}

class ItemData extends StatelessWidget {
  const ItemData({Key? key, required this.respons, required this.title})
      : super(key: key);

  final String title;
  final String respons;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xff4B556B),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        ': ',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff4B556B),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  )),
              Expanded(
                  child: Text(
                respons,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xff4B556B),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.5,
                ),
              ))
            ],
          ),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}

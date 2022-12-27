// ignore_for_file: avoid_print, unnecessary_const

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:siakad_app/screens/tab_screen.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:dropdown_search/dropdown_search.dart';

class RegistrasiAkunWaliMurid extends StatefulWidget {
  const RegistrasiAkunWaliMurid({Key? key, required this.role})
      : super(key: key);

  final String role;

  @override
  State<RegistrasiAkunWaliMurid> createState() =>
      _RegistrasiAkunWaliMuridState();
}

class _RegistrasiAkunWaliMuridState extends State<RegistrasiAkunWaliMurid> {
  final List<String> items = [
    'Laki-laki',
    'Perempuan',
  ];

  List countries = [
    {
      "student_id": 1,
      "first_name": "johan",
      "last_name": "luke",
    },
    {
      "student_id": 2,
      "first_name": "aziz",
      "last_name": "pranaja",
    }
  ];

  bool isItemDisabled(String s) {
    //return s.startsWith('I');

    if (s.startsWith('I')) {
      return true;
    } else {
      return false;
    }
  }

  void itemSelectionChanged(String? s) {
    print(s);
  }

  String? namasiswa;
  bool _loading = false;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirmation = TextEditingController();
  bool _secureText1 = true;
  bool _secureText2 = true;
  showHide1() {
    setState(() {
      _secureText1 = !_secureText1;
    });
  }

  showHide2() {
    setState(() {
      _secureText2 = !_secureText2;
    });
  }

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

  check() {
    final form = _key.currentState!;
    if (form.validate()) {
      form.save();
      funsiRegisterWaliMurid();
    }
  }

  checkConfirmPassword() {
    if (password.text != passwordConfirmation.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Password Tidak Sesuai')));
    }
  }

  List _get = [];
  String name = '';
  int? idUser;

  void funsiRegisterWaliMurid() async {
    setState(() {
      checkConfirmPassword();
    });
    print(idUser);
    showAlertDialog(context);
    ApiResponse response = await registerWaliMurid(
        email: email.text,
        password: password.text,
        passwordConfirmation: passwordConfirmation.text,
        studentId: idUser.toString());
    if (response.error == null) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Registrasi Berhasil')));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const TabScreen()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Ada Kesalahan')));
      setState(() {
        _loading = !_loading;
      });
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    // fetchAlbum();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Daftar",
          style: const TextStyle(
            fontSize: 20,
            color: const Color(0xff4B556B),
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: const Color(0xff4B556B),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                // height: 370,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: const Offset(0, 5), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Form(
                    key: _key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: const Center(
                            child: Text(
                              'DAFTAR AKUN BARU',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                  color: Color(0xff4B556B),
                                  letterSpacing: 1),
                            ),
                          ),
                        ),
                        // Text(
                        //   "Role : ${widget.role}",
                        //   style: const TextStyle(
                        //     fontSize: 14,
                        //     fontWeight: FontWeight.w600,
                        //     fontFamily: 'Poppins',
                        //     color: const Color(0xff4B556B),
                        //   ),
                        // ),
                        const SizedBox(
                          height: 30,
                        ),
                        DropdownSearch<dynamic>(
                          dropdownSearchDecoration: const InputDecoration(
                            labelText: "Nama Siswa",
                            hintText: "Pilih nama siswa",
                          ),
                          mode: Mode.MENU,
                          showSearchBox: true,
                          onFind: (text) async {
                            String token = await getToken();
                            final response = await http.get(
                              Uri.parse(baseURL + '/api/users/student'),
                              headers: {
                                'X-Requested-With': 'XMLHttpRequest',
                                'Authorization': 'Bearer $token'
                              },
                            );

                            if (response.statusCode == 200) {
                              final data =
                                  json.decode(response.body)['data'][0];
                              print(response.body);

                              setState(() {
                                _get = data;
                                print(_get);
                              });
                            }

                            return _get;
                          },
                          onChanged: (value) {
                            setState(() {
                              name = value['first_name'];
                              idUser = value['student_id'];
                            });
                          },
                          itemAsString: (item) =>
                              item['first_name'] + " " + item['last_name'],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "Email",
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
                              controller: email,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Email',
                              ),
                              validator: (value) {
                                String pattern =
                                    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                    r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                    r"{0,253}[a-zA-Z0-9])?)*$";
                                RegExp regex = RegExp(pattern);
                                if (value == null || value.isEmpty) {
                                  return 'Wajib Di isi';
                                } else if (!regex.hasMatch(value)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Email yang anda masukkan tidak valid')));
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
                          "Password",
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
                              controller: password,
                              obscureText: _secureText1,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Masukkan Sandi',
                                suffixIcon: IconButton(
                                  onPressed: showHide1,
                                  icon: Icon(_secureText1
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  color: const Color(0xff4B556B),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Sandi Wajib Diisi.';
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //     SnackBar(
                                  //         content: Text(
                                  //             'The password field is required.')));
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
                          "Konfirmasi",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                            color: const Color(0xff4B556B),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: TextFormField(
                              controller: passwordConfirmation,
                              obscureText: _secureText2,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Masukkan Sandi',
                                suffixIcon: IconButton(
                                  onPressed: showHide2,
                                  icon: Icon(_secureText2
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  color: const Color(0xff4B556B),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Sandi Wajib Diisi';
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //     SnackBar(
                                  //         content: Text(
                                  //             'The password field is required.')));
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                check();
              },
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 55,
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
                    "Registrasi",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        letterSpacing: 1),
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

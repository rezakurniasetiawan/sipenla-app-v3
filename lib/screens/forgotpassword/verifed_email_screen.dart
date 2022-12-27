// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/screens/forgotpassword/created_new_password.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/services/auth_service.dart';

import 'package:siakad_app/services/forgot_password_service.dart';

class VerifedEmailScreen extends StatefulWidget {
  const VerifedEmailScreen({Key? key, required this.email}) : super(key: key);

  final String email;

  @override
  State<VerifedEmailScreen> createState() => _VerifedEmailScreenState();
}

class _VerifedEmailScreenState extends State<VerifedEmailScreen> {
  bool _loading = false;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  TextEditingController numberOtp1 = TextEditingController();
  TextEditingController numberOtp2 = TextEditingController();
  TextEditingController numberOtp3 = TextEditingController();
  TextEditingController numberOtp4 = TextEditingController();

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

  void lupaPassword() async {
    showAlertDialog(context);
    ApiResponse response = await forgotPassword(email: widget.email);
    if (response.error == null) {
      print("Ambil OTP Sukses");
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Kode berhasil dikirim ulang')));
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const GetStartedScreen()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Email yang anda masukkan tidak valid.')));
      setState(() {
        _loading = !_loading;
      });
      Navigator.pop(context);
    }
  }

  check() {
    final form = _key.currentState!;
    if (form.validate()) {
      form.save();
      ambilOtp();
    }
  }

  String doneOtp = '';

  void checkOtp() {
    doneOtp =
        numberOtp1.text + numberOtp2.text + numberOtp3.text + numberOtp4.text;
  }

  void ambilOtp() async {
    showAlertDialog(context);
    setState(() {
      checkOtp();
    });
    ApiResponse response = await getOtp(token: doneOtp);
    if (response.error == null) {
      // print("Otp Bernar");
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CreatedNewPasswordScreen(
                    token: doneOtp,
                  )));
    } else {
      // print("Erors gays");
      // print(doneOtp);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Token salah')));
      setState(() {
        _loading = !_loading;
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Color(0xff4B556B),
          ),
          backgroundColor: Colors.white,
          title: const Text(
            "Verifikasi Email",
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Color(0xff4B556B),
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
              fontSize: 20,
            ),
          ),
          elevation: 0,
        ),
        body: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Center(
                        child: SizedBox(
                      height: 240,
                      // width: 200,
                      child: Image.asset('assets/image/forgot2.png'),
                    )),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 42, right: 42),
                    child: Text(
                      "Silahkan Masukkan 4 Digit Yang",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          letterSpacing: 1),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 42, right: 42),
                    child: Text(
                      "Dikirim Ke ${widget.email}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          letterSpacing: 1),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _key,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 50,
                              width: 48,
                              child: TextFormField(
                                controller: numberOtp1,
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                  if (value.isEmpty) {
                                    FocusScope.of(context).previousFocus();
                                  }
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              width: 48,
                              child: TextFormField(
                                controller: numberOtp2,
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                  if (value.isEmpty) {
                                    FocusScope.of(context).previousFocus();
                                  }
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              width: 48,
                              child: TextFormField(
                                controller: numberOtp3,
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                  if (value.isEmpty) {
                                    FocusScope.of(context).previousFocus();
                                  }
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              width: 48,
                              child: TextFormField(
                                controller: numberOtp4,
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                  if (value.isEmpty) {
                                    FocusScope.of(context).previousFocus();
                                  }
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      lupaPassword();
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 42, right: 42),
                      child: Text(
                        "Kirim Ulang Kode",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins',
                            color: Color(0xff2E447C),
                            letterSpacing: 1),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    check();
                  },
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
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
                        "Kirim",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            letterSpacing: 1),
                      )),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

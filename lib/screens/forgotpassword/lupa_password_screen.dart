import 'package:flutter/material.dart';
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/screens/forgotpassword/verifed_email_screen.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:siakad_app/services/forgot_password_service.dart';

class LupaPasswordScreen extends StatefulWidget {
  const LupaPasswordScreen({Key? key}) : super(key: key);

  @override
  State<LupaPasswordScreen> createState() => _LupaPasswordScreenState();
}

class _LupaPasswordScreenState extends State<LupaPasswordScreen> {
  bool _loading = false;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController textEmail = TextEditingController();

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
      lupaPassword();
    }
  }

  void lupaPassword() async {
    showAlertDialog(context);
    ApiResponse response = await forgotPassword(email: textEmail.text);
    if (response.error == null) {
      // ignore: avoid_print
      print("Ambil OTP Sukses");
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VerifedEmailScreen(
                    email: textEmail.text,
                  )));
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
            "Lupa Sandi",
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
                      child: Image.asset('assets/image/forgot3.png'),
                    )),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 42, right: 42),
                    child: Text(
                      "Silahkan Masukkan Alamat Email Anda",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          letterSpacing: 1),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 42, right: 42),
                    child: Text(
                      "Untuk Menerima Verifikasi",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          letterSpacing: 1),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: _key,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextFormField(
                            controller: textEmail,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Alamat Email',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'The email field is required.';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // const Padding(
                  //   padding: EdgeInsets.only(left: 42, right: 42),
                  //   child: Text(
                  //     "Try another way",
                  //     textAlign: TextAlign.center,
                  //     style: TextStyle(
                  //         fontSize: 14,
                  //         fontWeight: FontWeight.w700,
                  //         fontFamily: 'Poppins',
                  //         color: Color(0xff2E447C),
                  //         letterSpacing: 1),
                  //   ),
                  // ),
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

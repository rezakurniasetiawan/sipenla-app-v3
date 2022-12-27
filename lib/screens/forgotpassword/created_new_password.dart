import 'package:flutter/material.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/screens/login/login_screen.dart';
import 'package:siakad_app/services/forgot_password_service.dart';

class CreatedNewPasswordScreen extends StatefulWidget {
  const CreatedNewPasswordScreen({Key? key, required this.token})
      : super(key: key);

  final String token;

  @override
  State<CreatedNewPasswordScreen> createState() =>
      _CreatedNewPasswordScreenState();
}

class _CreatedNewPasswordScreenState extends State<CreatedNewPasswordScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController password = TextEditingController();
  TextEditingController comfirmpassword = TextEditingController();

  bool _loading = false;

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
      gantiPassowrd();
    }
  }

  void gantiPassowrd() async {
    showAlertDialog(context);
    ApiResponse response = await changePassword(
        token: widget.token,
        password: password.text,
        passwordConfirmation: comfirmpassword.text);
    if (response.error == null) {
      // ignore: avoid_print
      print("Sukses Reset Password");
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LogiScreen()));
    } else {
      // ignore: avoid_print
      print("Erors gays");
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Ada Kesalahan')));
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
            "Buat Sandi Baru",
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
        body: Form(
          key: _key,
          child: ListView(
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
                        child: Image.asset('assets/image/forgot4.png'),
                      )),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 35, right: 35),
                      child: Text(
                        "Sandi Baru Anda Harus Berbeda Dari",
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
                      padding: EdgeInsets.only(left: 35, right: 35),
                      child: Text(
                        "Sandi Yang Digunakan Sebelumnya.",
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
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextFormField(
                            controller: password,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Sandi Baru',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'The password field is required.';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextFormField(
                            controller: comfirmpassword,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Konfirmasi Sandi',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'The password field is required.';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
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
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

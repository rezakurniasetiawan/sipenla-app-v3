// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/user_model.dart';
import 'package:siakad_app/screens/check_userdata.dart';
import 'package:siakad_app/screens/forgotpassword/lupa_password_screen.dart';
import 'package:siakad_app/services/auth_service.dart';

class LogiScreen extends StatefulWidget {
  const LogiScreen({Key? key}) : super(key: key);

  @override
  State<LogiScreen> createState() => _LogiScreenState();
}

class _LogiScreenState extends State<LogiScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController textEmail = TextEditingController();
  TextEditingController textPassword = TextEditingController();

  bool _secureText = true;
  bool isChecked = false;
  showHide() {
    setState(() {
      _secureText = !_secureText;
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
      _loginUser();
    }
  }

  void _loginUser() async {
    showAlertDialog(context);
    ApiResponse response =
        await login(email: textEmail.text, password: textPassword.text);
    if (response.error == null) {
      _saveAndRedirectToHome(response.data as UserModel);
      Navigator.pop(context);
    } else {
      print("Login Ggal");
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Email atau password anda salah")));
    }
  }

  void _saveAndRedirectToHome(UserModel userModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('token', userModel.data.accessToken);
    // await preferences.setString('first_name', userModel.data.name.firstName);
    // await preferences.setString('last_name', userModel.data.name.lastName);
    await preferences.setString('role', userModel.data.user.role);
    await preferences.setString('email', userModel.data.user.email);
    await preferences.setInt('userId', userModel.data.user.id);

    if (isChecked) {
      await preferences.setString('emaillogin', textEmail.text);
      await preferences.setString('passwordlogin', textPassword.text);
    }
    // else if (!isChecked) {
    //   if (emaillogin != textEmail.text) {
    //     await preferences.remove('emaillogin');
    //     await preferences.remove('passwordlogin');
    //   }
    // }
    // Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(builder: (context) => TabScreen()), (route) => false);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const CheckUserData()));
  }

  void checkRemember() async {
    String emaillogin = await getEmailLogin();
    String passwordlogin = await getPasswordLogin();
    setState(() {
      if (emaillogin.isNotEmpty) {
        textEmail.text = emaillogin;
      }
      if (passwordlogin.isNotEmpty) {
        textPassword.text = passwordlogin;
      }
      print(emaillogin);
      print(passwordlogin);
    });
  }

  @override
  void initState() {
    checkRemember();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                  // width: 200,
                  child: Image.asset('assets/image/logo.png'),
                ),
                const Text(
                  "SIPENLA",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    fontFamily: 'Poppins',
                    color: Color(0xff3774C3),
                  ),
                ),
              ],
            )),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.65,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: const Offset(5, 0), // changes position of shadow
                  ),
                ],
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(32),
                    topLeft: Radius.circular(32)),
                color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
              child: Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "Selamat Datang",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                        fontFamily: 'Poppins',
                        color: Color(0xff4B556B),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
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
                          controller: textEmail,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Masukkan Email',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email Wajib Diisi';
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //     SnackBar(
                              //         content: Text(
                              //             'The email field is required.')));
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
                      "Sandi",
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
                          controller: textPassword,
                          obscureText: _secureText,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Masukkan Sandi',
                            suffixIcon: IconButton(
                              onPressed: showHide,
                              icon: Icon(_secureText
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              color: const Color(0xff4B556B),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password Wajib Diisi';
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 25,
                              child: Checkbox(
                                  value: isChecked,
                                  onChanged: (value) {
                                    isChecked = !isChecked;
                                    setState(() {});
                                  }),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            const Text(
                              "Simpan Email & Sandi",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                              ),
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const LupaPasswordScreen()));
                          },
                          child: const Text(
                            "Lupa Sandi?",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                                color: Colors.red,
                                letterSpacing: 0.5),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
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
                            "Masuk",
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
            ),
          ),
        ],
      ),
    );
  }
}

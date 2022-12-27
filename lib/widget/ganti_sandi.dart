import 'package:flutter/material.dart';

import '../constan.dart';
import '../models/api_response_model.dart';
import '../screens/started_screen.dart';
import '../services/auth_service.dart';

class GantiSandiScreen extends StatefulWidget {
  const GantiSandiScreen({Key? key}) : super(key: key);

  @override
  State<GantiSandiScreen> createState() => _GantiSandiScreenState();
}

class _GantiSandiScreenState extends State<GantiSandiScreen> {
  TextEditingController sandiLama = TextEditingController();
  TextEditingController sandiBaru = TextEditingController();
  TextEditingController konfirmasiSandi = TextEditingController();
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

  void fungsigantiPassword() async {
    showAlertDialog(context);
    ApiResponse response = await gantiPassword(
        konfirmasiSandi: konfirmasiSandi.text,
        sandiBaru: sandiBaru.text,
        sandiLama: sandiLama.text);
    if (response.error == null) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Berhasil Ganti Sandi')));
      setState(() {
        Navigator.pop(context, 'refresh');
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
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ganti Sandi",
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
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.75,
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
                      "Sandi Yang Digunakan Sebelumnya",
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
                          controller: sandiLama,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Sandi Saat Ini',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Sandi Harus Diisi.';
                            }
                            return null;
                          },
                        ),
                      ),
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
                          controller: sandiBaru,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Sandi Baru',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Sandi Harus Diisi';
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
                          controller: konfirmasiSandi,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Konfirmasi Sandi Baru',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Sandi Harus Diisi';
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
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    fungsigantiPassword();
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
      ),
    );
  }
}

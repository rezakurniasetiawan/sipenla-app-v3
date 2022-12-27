import 'package:flutter/material.dart';
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/jadwal_model.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:siakad_app/services/jadwal_service.dart';
import 'package:siakad_app/widget/jadwal/comp/jadwal_pelajaran.dart';

class ListKelas extends StatefulWidget {
  const ListKelas({Key? key}) : super(key: key);

  @override
  State<ListKelas> createState() => _ListKelasState();
}

class _ListKelasState extends State<ListKelas> {
  bool _loading = true;
  List<dynamic> _kelasList = [];

  Future<void> fungsiGetKelas() async {
    ApiResponse response = await getKelas();
    if (response.error == null) {
      setState(() {
        _kelasList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => GetStartedScreen()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    fungsiGetKelas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Jadwal Pembelajaran',
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
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blueAccent,
              ),
            )
          : ListView.builder(
              itemCount: _kelasList.length,
              itemBuilder: (BuildContext context, int index) {
                KelasModel kelasModel = _kelasList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => JadwalPelajaran(
                                        className: kelasModel.gradeName,
                                        idClass: kelasModel.gradeId,
                                      )));
                        },
                        child: Container(
                          height: 40,
                          color: Colors.white.withOpacity(0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                kelasModel.gradeName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff4B556B),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 40,
                                child:
                                    Image.asset('assets/icons/icon-next.png'),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}

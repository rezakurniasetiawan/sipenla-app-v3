import 'package:flutter/material.dart';
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/jadwal_model.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/services/auth_service.dart';
import 'package:siakad_app/services/jadwal_service.dart';
import 'package:siakad_app/widget/jadwal/comp/jadwal_ekstra.dart';

class ListEkstra extends StatefulWidget {
  const ListEkstra({Key? key}) : super(key: key);

  @override
  State<ListEkstra> createState() => _ListEkstraState();
}

class _ListEkstraState extends State<ListEkstra> {
  @override
  bool _loading = true;
  List<dynamic> _EkstraList = [];

  Future<void> fungsiGetEkstra() async {
    ApiResponse response = await getEkstra();
    if (response.error == null) {
      setState(() {
        _EkstraList = response.data as List<dynamic>;
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
    fungsiGetEkstra();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Jadwal Ektrakulikuler',
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: _loading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.blueAccent,
                ),
              )
            : ListView.builder(
                itemCount: _EkstraList.length,
                itemBuilder: (BuildContext context, int index) {
                  EkstraModel ekstraModel = _EkstraList[index];
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => JadwalEkstra(
                                        idEkstra: ekstraModel.extracurricularId,
                                      )));
                        },
                        child: Container(
                          height: 40,
                          color: Colors.white.withOpacity(0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ekstraModel.extracurricularName,
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
                  );
                },
              ),
      ),
    );
  }
}

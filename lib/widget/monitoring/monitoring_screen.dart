import 'package:flutter/material.dart';
import 'package:siakad_app/widget/monitoring/comp/monitoring_ekstra.dart';
import 'package:siakad_app/widget/monitoring/comp/monitoring_pembelajaran.dart';
import 'package:siakad_app/widget/monitoring/comp/riwayat_monitoring_ekstra.dart';
import 'package:siakad_app/widget/monitoring/comp/riwayat_monitoring_pembelajaran.dart';

class MonitoringScreen extends StatefulWidget {
  const MonitoringScreen(
      {Key? key, required this.imageTeacher, required this.role})
      : super(key: key);

  final String imageTeacher;
  final String role;

  @override
  State<MonitoringScreen> createState() => _MonitoringScreenState();
}

class _MonitoringScreenState extends State<MonitoringScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Monitoring',
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
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: widget.role == 'guru'
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MenuItem(
                      ontapps: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MonitoringPembelajaran(
                                      imageTeacher: widget.imageTeacher,
                                    )));
                      },
                      leftIcon: 'assets/icons/bar-chart.png',
                      rightIcon: 'assets/icons/icon-next.png',
                      title: 'Monitoring Pembelajaran',
                    ),
                    MenuItem(
                      ontapps: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const RiwayatMonitoringPembelajaran()));
                      },
                      leftIcon: 'assets/icons/bar-chart.png',
                      rightIcon: 'assets/icons/icon-next.png',
                      title: 'Riwayat Monitoring',
                    ),
                  ],
                )
              : widget.role == 'pembinaextra'
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MenuItem(
                          ontapps: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MonitoringEkstra(
                                          imageTeacher: widget.imageTeacher,
                                        )));
                          },
                          leftIcon: 'assets/icons/bar-chart.png',
                          rightIcon: 'assets/icons/icon-next.png',
                          title: 'Monitoring Ekstrakurikuler',
                        ),
                        MenuItem(
                          ontapps: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RiwayatMonitoringEkstra()));
                          },
                          leftIcon: 'assets/icons/bar-chart.png',
                          rightIcon: 'assets/icons/icon-next.png',
                          title: 'Riwayat Monitoring',
                        ),
                      ],
                    )
                  : SizedBox()),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem(
      {Key? key,
      required this.ontapps,
      required this.leftIcon,
      required this.rightIcon,
      required this.title})
      : super(key: key);

  final VoidCallback ontapps;
  final String leftIcon, rightIcon, title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: ontapps,
          child: Container(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  child: Image.asset(leftIcon),
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xff4B556B),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(
                  height: 24,
                  width: 40,
                  child: Image.asset(rightIcon),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        )
      ],
    );
  }
}

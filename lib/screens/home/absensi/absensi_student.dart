import 'package:flutter/material.dart';
import 'package:siakad_app/screens/home/history_absen/list_week_ekstra_student.dart';
import 'package:siakad_app/screens/home/history_absen/list_week_student.dart';

class AbsensiStudent extends StatefulWidget {
  const AbsensiStudent({Key? key}) : super(key: key);

  @override
  State<AbsensiStudent> createState() => _AbsensiStudentState();
}

class _AbsensiStudentState extends State<AbsensiStudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Absensi',
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MenuItem(
              ontapps: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ListWeekStudent()));
              },
              leftIcon: 'assets/icons/bar-chart.png',
              rightIcon: 'assets/icons/icon-next.png',
              title: 'Absensi Pembelajaran',
            ),
            MenuItem(
              ontapps: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ListWeekEkstraStudent()));
              },
              leftIcon: 'assets/icons/bar-chart.png',
              rightIcon: 'assets/icons/icon-next.png',
              title: 'Absensi Ekstrakurikuler',
            ),
          ],
        ),
      ),
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
          child: SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
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
          height: 30,
        )
      ],
    );
  }
}

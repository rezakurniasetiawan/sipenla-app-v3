import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/employee_model.dart';
import 'package:siakad_app/models/guardian_model.dart';
import 'package:siakad_app/models/student_model.dart';
import 'package:siakad_app/screens/profile/penerimaan_pegawai.dart';
import 'package:siakad_app/screens/profile/penerimaan_siswa.dart';
import 'package:siakad_app/screens/started_screen.dart';
import 'package:siakad_app/screens/tab_screen.dart';
import 'package:siakad_app/services/auth_service.dart';

class CheckUserData extends StatefulWidget {
  const CheckUserData({Key? key}) : super(key: key);

  @override
  State<CheckUserData> createState() => _CheckUserDataState();
}

class _CheckUserDataState extends State<CheckUserData> {
  EmployeeModel? employeeModel;
  StudentModel? studentModel;
  GuardianModel? guardianModel;
  bool loading = true;

  //Get user detail
  void getUser() async {
    String role = await getrole();
    ApiResponse response = await getUserDetail();

    switch (response.error) {
      case null:
        setState(() {
          if (role == 'student') {
            studentModel = response.data as StudentModel;
            loading = false;
            if (studentModel!.status == 'false') {
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DataPenerimaanStudent()));
              });
            } else {
              setState(() {
                setPrefStudent();
              });
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const TabScreen()),
                  (route) => false);
            }
          } else if (role == 'walimurid') {
            setState(() {
              getGuardian();
              // ignore: avoid_print
              print('Login wali murid benar');
            });
          } else {
            employeeModel = response.data as EmployeeModel;
            loading = false;
            if (employeeModel!.status == 'false') {
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DataPenerimaanPegawai()));
              });
            } else {
              setState(() {
                setPrefEmployee();
              });
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const TabScreen()),
                  (route) => false);
            }
          }
        });
        break;
      case unauthorized:
        logout().then((value) => {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const GetStartedScreen()),
                  (route) => false)
            });
        break;
      default:
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  getGuardian() async {
    ApiResponse response = await getGuardianDetail();
    if (response.error == null) {
      setState(() {
        guardianModel = response.data as GuardianModel;
        loading = false;
        setPrefGuardian();
      });
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const TabScreen()),
          (route) => false);
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
    }
  }

  setPrefStudent() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('first_name', studentModel!.studentFirstName);
    await preferences.setString('last_name', studentModel!.studentLastName);
    await preferences.setInt('idGrade', studentModel!.gradeId);
    await preferences.setString('gradeName', studentModel!.gradeName);
    await preferences.setInt('idEkstra', studentModel!.extracurricularId);
    await preferences.setString('photoUser', studentModel!.image);
    await preferences.setString('nisn', studentModel!.nisn);
    await preferences.setString('status_student', studentModel!.StatusStudent);
  }

  setPrefEmployee() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('first_name', employeeModel!.firstName);
    await preferences.setString('last_name', employeeModel!.lastName);
    await preferences.setString('photoUser', employeeModel!.image);
    // await preferences.setString('nik', employeeModel!.nik);
    await preferences.setString('npsn', employeeModel!.npsn);
    await preferences.setString('isWali', employeeModel!.isWali);
    await preferences.setInt(
        'extracurricular_id', employeeModel!.extracurricularid);
    await preferences.setString(
        'extracurricular', employeeModel!.extracurricular);
  }

  setPrefGuardian() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('first_name', guardianModel!.fatherName);
    await preferences.setString('last_name', guardianModel!.lastName);
    await preferences.setString('photoUser', guardianModel!.image);
    await preferences.setInt('idGrade', guardianModel!.gradeId);
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: CircularProgressIndicator(
        color: Colors.blue[900],
      ),
    ));
  }
}

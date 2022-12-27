// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/employee_model.dart';
import 'package:siakad_app/models/guardian_model.dart';
import 'package:siakad_app/models/student_model.dart';
import 'package:siakad_app/models/user_model.dart';

import '../constan.dart';

String apiLogin = baseURL + '/api/users/login';

Future<ApiResponse> login(
    {required String email, required String password}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(Uri.parse(apiLogin), headers: {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
    }, body: {
      'email': email,
      'password': password
    });
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data = UserModel.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['data']['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['data']['errors'];
        break;
      default:
        apiResponse.error = somethingWhentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

String apiRegisterSiswa = baseURL + '/api/users/registerstudent';
Future<ApiResponse> registerSiswa({
  required String email,
  required String password,
  required String passwordConfirmation,
}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(Uri.parse(apiRegisterSiswa), headers: {
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    }, body: {
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
    });
    switch (response.statusCode) {
      case 200:
        print('status 200');
        print(response.body);
        apiResponse.data = jsonDecode(response.body);
        break;
      case 400:
        print('status 422');
        print(response.body);
        final errors = jsonDecode(response.body)['data']['errors']['email'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];

        break;

      default:
        print('status someting');
        apiResponse.error = somethingWhentWrong;
        break;
    }
  } catch (e) {
    print(serverError);
    apiResponse.error = serverError;
  }
  return apiResponse;
}

String apiRegisterWalimurid = baseURL + '/api/users/registerguardian';
Future<ApiResponse> registerWaliMurid({
  required String email,
  required String password,
  required String passwordConfirmation,
  required String studentId,
}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(Uri.parse(apiRegisterWalimurid), headers: {
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    }, body: {
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'student_id': studentId,
    });
    switch (response.statusCode) {
      case 200:
        print('status 200');
        print(response.body);
        apiResponse.data = jsonDecode(response.body);
        break;
      case 400:
        print('status 422');
        print(response.body);
        final errors = jsonDecode(response.body)['data']['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];

        break;

      default:
        print('status someting');
        apiResponse.error = somethingWhentWrong;
        break;
    }
  } catch (e) {
    print("erro");
    print(serverError);
    apiResponse.error = serverError;
  }
  return apiResponse;
}

String apiRegisterEmployee = baseURL + '/api/users/registeremployee';

Future<ApiResponse> registerEmployee({
  required String email,
  required String password,
  required String passwordConfirmation,
  required String role,
}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(Uri.parse(apiRegisterEmployee), headers: {
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    }, body: {
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'role': role,
    });
    switch (response.statusCode) {
      case 200:
        print('status 200');
        print(response.body);
        apiResponse.data = jsonDecode(response.body);
        break;
      case 400:
        print('status 400');
        print(response.body);
        final errors = jsonDecode(response.body)['data']['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;

      default:
        print('status someting');
        print(response.body);
        apiResponse.error = somethingWhentWrong;
        break;
    }
  } catch (e) {
    print(serverError);
    apiResponse.error = serverError;
  }
  return apiResponse;
}

String apiUser = baseURL + '/api/users/profile';

Future<ApiResponse> getUserDetail() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String role = await getrole();
    String token = await getToken();
    final response = await http.get(Uri.parse(apiUser), headers: {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    });
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        print(response.body);
        if (role == 'student') {
          apiResponse.data =
              StudentModel.fromJson(jsonDecode(response.body)['data']);
        } else if (role == 'walimurid') {
          print('Wali Murid');
        } else {
          print('pegawai');
          apiResponse.data =
              EmployeeModel.fromJson(jsonDecode(response.body)['data']);
        }
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      case 500:
        print(response.body);
        break;
      default:
        apiResponse.error = somethingWhentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

String apiGuardian = baseURL + '/api/users/guardian';

Future<ApiResponse> getGuardianDetail() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(apiGuardian), headers: {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    });

    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data =
            GuardianModel.fromJson(jsonDecode(response.body)['data']);
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWhentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

Future<ApiResponse> gantiPassword(
    {required String sandiLama,
    required String sandiBaru,
    required String konfirmasiSandi}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response =
        await http.post(Uri.parse(baseURL + '/api/users/changepass'), headers: {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    }, body: {
      'old_pass': sandiLama,
      'new_pass': sandiBaru,
      'new_pass_confirmation': konfirmasiSandi,
    });
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data = jsonDecode(response.body);
        break;
      case 422:
        final errors = jsonDecode(response.body)['data']['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 400:
        apiResponse.error = jsonDecode(response.body)['meta']['message'];
        break;
      default:
        apiResponse.error = somethingWhentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

//get token
Future<String> getToken() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString('token') ?? '';
}

// get emailogin
Future<String> getEmailLogin() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString('emaillogin') ?? '';
}

// get passwordlogin
Future<String> getPasswordLogin() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString('passwordlogin') ?? '';
}

//get email
Future<String> getEmail() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString('email') ?? '';
}

//get firstName
Future<String> getfirstName() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString('first_name') ?? '';
}

//get firstName
Future<String> getlastName() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString('last_name') ?? '';
}

//get role
Future<String> getrole() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString('role') ?? '';
}

//get user id
Future<int> getUserId() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getInt('userId') ?? 0;
}

Future<String> getabsensi() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString('absensi') ?? '';
}

Future<String> getClassName() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString('gradeName') ?? '';
}

Future<int> getidClass() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getInt('idGrade') ?? 0;
}

Future<int> getidEkstra() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getInt('idEkstra') ?? 0;
}

//logout
Future<bool> logout() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.remove('token');
}

// Get base64 encoded image
String? getStringImage(File? file) {
  if (file == null) return null;
  return base64Encode(file.readAsBytesSync());
}

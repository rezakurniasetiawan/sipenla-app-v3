// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:siakad_app/constan.dart';
import 'package:http/http.dart' as http;
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/data_user_model.dart';
import 'package:siakad_app/models/employee_model.dart';
import 'package:siakad_app/models/student_model.dart';
import 'package:siakad_app/models/user_model.dart';
import 'package:siakad_app/services/auth_service.dart';

String apiGetDataStudent = baseURL + '/api/admission/getstudent';

Future<ApiResponse> getDataStudent() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(apiGetDataStudent), headers: {
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    });

    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data =
            StudentDataModel.fromJson(jsonDecode(response.body)['data']);
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

Future<ApiResponse> getDataStudentbyId({required String idStudent}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
        Uri.parse(baseURL + '/api/data/getstudentbyid/$idStudent'),
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Bearer $token'
        });
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data =
            StudentDataModel.fromJson(jsonDecode(response.body)['data']);
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

String apiGetDataEmployee = baseURL + '/api/admission/getemployee';

Future<ApiResponse> getDataEmployee() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(apiGetDataEmployee), headers: {
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    });

    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data =
            EmployeeData.fromJson(jsonDecode(response.body)['data']);
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

Future<ApiResponse> getDataEmployeebyId({required String idEmployee}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
        Uri.parse(baseURL + '/api/data/getemployee/$idEmployee'),
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Bearer $token'
        });

    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data =
            EmployeeData.fromJson(jsonDecode(response.body)['data']);
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

// String apiUpdateStudent = baseURL + '/api/news/addnews';

Future<ApiResponse> updatePhotoStudent(
  int studentId,
  String? image,
) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(
        Uri.parse(baseURL + '/api/admission/updatestudent/$studentId'),
        headers: {
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Bearer $token'
        },
        body: {
          'profile_student': image
        });
    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data =
            UpdateFotoProfileModel.fromJson(jsonDecode(response.body)['data']);
        break;
      case 422:
        final errors = jsonDecode(response.body)['data']['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;

      default:
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

Future<ApiResponse> updatePhotoEmployee(
  int employeeId,
  String? image,
) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(
        Uri.parse(baseURL + '/api/admission/updateemployee/$employeeId'),
        headers: {
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Bearer $token'
        },
        body: {
          'profile_employee': image
        });
    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data =
            UpdateFotoProfileModel.fromJson(jsonDecode(response.body)['data']);
        break;
      case 422:
        final errors = jsonDecode(response.body)['data']['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;

      default:
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

String apiGetDataSiswa = baseURL + '/api/data/getstudent';
Future<ApiResponse> getDataSiswa() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(apiGetDataSiswa), headers: {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    });
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data = jsonDecode(response.body)['data']
            .map((p) => DataSiswaModel.fromJson(p))
            .toList();
        apiResponse.data as List<dynamic>;
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        String? somethingWentWrong;
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

Future<ApiResponse> getDataSiswaFilter({required String value}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http
        .get(Uri.parse(baseURL + '/api/data/getstudent/$value'), headers: {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    });
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data = jsonDecode(response.body)['data']
            .map((p) => DataSiswaModel.fromJson(p))
            .toList();
        apiResponse.data as List<dynamic>;
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        String? somethingWentWrong;
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

String apiGetDataPegawai = baseURL + '/api/data/getemployee';
Future<ApiResponse> getDataPegawai() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(apiGetDataPegawai), headers: {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    });
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data = jsonDecode(response.body)['data']
            .map((p) => DataPegawaiModel.fromJson(p))
            .toList();
        apiResponse.data as List<dynamic>;
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        String? somethingWentWrong;
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

Future<ApiResponse> getDataPegawaiFilter({required String value}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
        Uri.parse(baseURL + '/api/data/getemployeebyname/$value'),
        headers: {
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Bearer $token'
        });
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data = jsonDecode(response.body)['data']
            .map((p) => DataPegawaiModel.fromJson(p))
            .toList();
        apiResponse.data as List<dynamic>;
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      case 400:
        print(response.body);
        break;
      default:
        String? somethingWentWrong;
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

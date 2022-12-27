import 'dart:convert';

import 'package:siakad_app/constan.dart';
import 'package:http/http.dart' as http;
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/penilaian_model.dart';
import 'package:siakad_app/services/auth_service.dart';

Future<ApiResponse> getStudentForNilai({required String idClass}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
        Uri.parse(baseURL + '/api/assessment/getstudent/$idClass'),
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
            .map((p) => PenilaianStudentModel.fromJson(p))
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

Future<ApiResponse> getNilaiStudent(
    {required String idClass,
    required String idMapel,
    required String idSemester,
    required String idJenPen}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
        Uri.parse(baseURL +
            '/api/assessment/getnilai/$idClass/$idMapel/$idSemester/$idJenPen'),
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
            .map((p) => NilaiStudentModel.fromJson(p))
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

Future<ApiResponse> updateNilaiSiswa({
  required String penilaianId,
  required String nilai,
}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    print(token);
    final response = await http.post(
        Uri.parse(baseURL + '/api/assessment/updatepenilaian/$penilaianId'),
        headers: {
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Bearer $token'
        },
        body: {
          'nilai': nilai,
        });
    print(response.body);
    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data = jsonDecode(response.body);
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

Future<ApiResponse> updateNilaiEkstraSiswa({
  required String penilaianId,
  required String nilai,
}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    print(token);
    final response = await http.post(
        Uri.parse(baseURL + '/api/assessmentextra/updatepenilaian/$penilaianId'),
        headers: {
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Bearer $token'
        },
        body: {
          'nilai': nilai,
        });
    print(response.body);
    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data = jsonDecode(response.body);
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

Future<ApiResponse> getRiwayatNilaiSiswa(
    {required int idKelas,
    required int idSemester,
    required int idAkademik,
    required int idMapel}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
        Uri.parse(baseURL +
            '/api/assessment/gethistory/$idKelas/$idSemester/$idAkademik/$idMapel'),
        headers: {
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Bearer $token'
        });
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data =
            RiwayatNilaiSiswaModel.fromJson(jsonDecode(response.body)['data']);
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      case 404:
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

Future<ApiResponse> getStudentForNilaiEkstra() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http
        .get(Uri.parse(baseURL + '/api/assessmentextra/getstudent'), headers: {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    });
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data = jsonDecode(response.body)['data']
            .map((p) => PenilaianEkstrStudentModel.fromJson(p))
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

Future<ApiResponse> getNilaiEkstraStudent(
    {required String idAkademik, required String idSemester}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
        Uri.parse(
            baseURL + '/api/assessmentextra/getnilai/$idAkademik/$idSemester'),
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
            .map((p) => NilaiEkstraStudentModel.fromJson(p))
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

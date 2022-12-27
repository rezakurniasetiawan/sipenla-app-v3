import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/absensi_siswa_model.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/rapor_model.dart';
import 'package:siakad_app/services/auth_service.dart';

Future<ApiResponse> getSiswaKonfirmasiNilai({required String idKelas}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http
        .get(Uri.parse(baseURL + '/api/rapor/getrapor/$idKelas'), headers: {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['data']
            .map((p) => SiswaKonfirmasiPenilaianModel.fromJson(p))
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

Future<ApiResponse> getDetailNilaiSiswa(
    {required String idStudent,
    required String idGrade,
    required String idSemester,
    required String idAkademik,
    required String idMapel}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
        Uri.parse(baseURL +
            '/api/rapor/getnilai/$idStudent/$idGrade/$idSemester/$idAkademik/$idMapel'),
        headers: {
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Bearer $token'
        });
    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data =
            DetailNilaiSiswaModel.fromJson(jsonDecode(response.body)['data']);
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

Future<ApiResponse> konfirmasiNilaiSiswa(
    {required int idKelas,
    required int idStudent,
    required int idSemester,
    required int idAkademik,
    required int idMapel}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(
        Uri.parse(baseURL +
            '/api/rapor/updaterapor/$idStudent/$idSemester/$idAkademik/$idMapel/$idKelas'),
        headers: {
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Bearer $token'
        });
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      case 404:
        print(response.body);
        break;
      case 400:
        apiResponse.error = jsonDecode(response.body)['data'];
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

Future<ApiResponse> getKelasKonfirmasiNilai() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response =
        await http.get(Uri.parse(baseURL + '/api/rapor/getgrade'), headers: {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    });
    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data = jsonDecode(response.body)['data']
            .map((p) => DataKelasKepsekModel.fromJson(p))
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

Future<ApiResponse> konfirmasiNilaibyKelasKepsek({required int idKelas}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http
        .post(Uri.parse(baseURL + '/api/rapor/editrapor/$idKelas'), headers: {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    });
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      case 400:
        apiResponse.error = jsonDecode(response.body)['data'];
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

Future<ApiResponse> getNilaiRaporSiswa({
  required int idGrade,
  required int idSemester,
  required int idAkademik,
}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
        Uri.parse(baseURL +
            '/api/rapor/getraporbyuser/$idGrade/$idSemester/$idAkademik'),
        headers: {
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Bearer $token'
        });
    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data = jsonDecode(response.body)['data']['nilai']
            .map((p) => NilaiRaporSiswa.fromJson(p))
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

Future<ApiResponse> getNilaiEkstraSiswa({
  required int idGrade,
  required int idSemester,
  required int idAkademik,
}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
        Uri.parse(baseURL +
            '/api/rapor/getraporbyuser/$idGrade/$idSemester/$idAkademik'),
        headers: {
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Bearer $token'
        });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['data']['extra']
            .map((p) => NilaiEkstraSiswa.fromJson(p))
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

Future<ApiResponse> getNilaiRaporSiswabyId({
  required String idStudent,
}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
        Uri.parse(baseURL + '/api/data/getraporbyuser/$idStudent'),
        headers: {
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Bearer $token'
        });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['data']['nilai']
            .map((p) => NilaiRaporSiswa.fromJson(p))
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

Future<ApiResponse> getNilaiEkstraSiswabyId({
  required String idStudent,
}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
        Uri.parse(baseURL + '/api/data/getraporbyuser/$idStudent'),
        headers: {
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Bearer $token'
        });
    print(response.body);
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['data']['extra']
            .map((p) => NilaiEkstraSiswa.fromJson(p))
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

Future<ApiResponse> getRiwayatRaporKepsek() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http
        .get(Uri.parse(baseURL + '/api/rapor/gethistorykepsek'), headers: {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    });
    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data = jsonDecode(response.body)['data']
            .map((p) => RiwayatKepsekModel.fromJson(p))
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

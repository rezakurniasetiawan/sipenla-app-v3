// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:siakad_app/services/auth_service.dart';

String apiPenerimaanSiswa = baseURL + '/api/admission/addstudent';

Future<ApiResponse> penerimaanSiswa({
  required String namadepan,
  required String namabelakang,
  // required String nik,
  required String nisn,
  required String phone,
  required String tempatlahir,
  required String tanggallahir,
  required String jeniskelamin,
  required String agama,
  required String alamattinggal,
  required String asalsekolah,
  required String kelas,
  required String tglKelas,
  required String namaayah,
  required String namaibu,
  required String alamatortu,
  required String pekerjaanayah,
  required String pekerjaanibu,
  required String pendidikanayah,
  required String pendidikanibu,
  required String namawali,
  required String alamatwali,
  required String pekerjaanwali,
  required String ekstra,
  required String? profilestudent,
}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    print(token);
    final response = await http.post(Uri.parse(apiPenerimaanSiswa), headers: {
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    }, body: {
      'first_name': namadepan,
      'last_name': namabelakang,
      // 'nik': nik,
      'nisn': nisn,
      'phone': phone,
      'place_of_birth': tempatlahir,
      'date_of_birth': tanggallahir,
      'gender': jeniskelamin,
      'religion': agama,
      'address': alamattinggal,
      'school_origin': asalsekolah,
      'school_now': kelas,
      'date_school_now': tglKelas,
      'father_name': namaayah,
      'mother_name': namaibu,
      'parent_address': alamatortu,
      'father_profession': pekerjaanayah,
      'mother_profession': pekerjaanibu,
      'father_education': pendidikanayah,
      'mother_education': pendidikanibu,
      'family_name': namawali,
      'family_address': alamatwali,
      'family_profession': pekerjaanwali,
      'extracurricular_id': ekstra,
      'profile_student': profilestudent,
    });
    switch (response.statusCode) {
      case 200:
        print('status 200');
        print(response.body);
        apiResponse.data = jsonDecode(response.body);
        break;
      case 400:
        print('status 400');
        final errors = jsonDecode(response.body)['data']['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;

      default:
        print(response.body);
        print('status someting');
        print(response.statusCode);
        apiResponse.error = somethingWhentWrong;
        break;
    }
  } catch (e) {
    print(serverError);
    apiResponse.error = serverError;
  }
  return apiResponse;
}

String apiPenerimaanPegawai = baseURL + '/api/admission/addemployee';

Future<ApiResponse> penerimaanPegawai({
  required String namadepan,
  required String namabelakang,
  // required String nik,
  required String nuptk,
  required String npsn,
  required String tempatlahir,
  required String tanggallahir,
  required String jeniskelamin,
  required String agama,
  required String alamattinggal,
  required String riwayatpendidikan,
  required String namaibu,
  required String alamatortu,
  required String jabatan1,
  required String phone,
  required String workshiftId,
  required String? photoprofile,
}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    print(token);
    final response = await http.post(Uri.parse(apiPenerimaanPegawai), headers: {
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    }, body: {
      'first_name': namadepan,
      'last_name': namabelakang,
      // 'nik': nik,
      'nuptk': nuptk,
      'npsn': npsn,
      'place_of_birth': tempatlahir,
      'date_of_birth': tanggallahir,
      'gender': jeniskelamin,
      'religion': agama,
      'address': alamattinggal,
      'education': riwayatpendidikan,
      'family_name': namaibu,
      'family_address': alamatortu,
      'position': jabatan1,
      'phone': phone,
      'profile_employee': photoprofile,
      'workshift_id': workshiftId,
    });
    switch (response.statusCode) {
      case 200:
        print('status 200');
        print(response.body);
        apiResponse.data = jsonDecode(response.body);
        break;
      case 400:
        print('status 400');
        final errors = jsonDecode(response.body)['data']['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;

      default:
        print(response.body);
        print('status someting');
        print(response.statusCode);
        apiResponse.error = somethingWhentWrong;
        break;
    }
  } catch (e) {
    print(e);
    print(apiResponse.error);
    apiResponse.error = serverError;
  }
  return apiResponse;
}

// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/absensi_siswa_model.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/history_absensi_model.dart';
import 'package:siakad_app/services/auth_service.dart';

String apiCheckInEmployee = baseURL + '/api/attendances/checkin';

Future<ApiResponse> checkInEmployee({required String? attendanceimage}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    print(token);
    final response = await http.post(Uri.parse(apiCheckInEmployee), headers: {
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    }, body: {
      'attendance_check_in': attendanceimage,
    });
    switch (response.statusCode) {
      case 200:
        print('status 200');
        print(response.body);
        apiResponse.data = jsonDecode(response.body);
        break;
      case 400:
        // print('status 400');
        print(response.body);
        apiResponse.error = jsonDecode(response.body)['meta']['message'];
        // final errors = jsonDecode(response.body)['data'];
        // apiResponse.error = errors[errors.keys.elementAt(0)][0];
        // print(errors);
        // print('respon 400 : ');
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
    print('catch error');
    apiResponse.error = serverError;
  }
  return apiResponse;
}

String apiCheckOutEmployee = baseURL + '/api/attendances/checkout';

Future<ApiResponse> checkOutEmployee(
    {required String? attendanceimageOut}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    print(token);
    final response = await http.post(Uri.parse(apiCheckOutEmployee), headers: {
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    }, body: {
      'attendance_check_out': attendanceimageOut
    });
    switch (response.statusCode) {
      case 200:
        print('status 200');
        print(response.body);
        apiResponse.data = jsonDecode(response.body);
        break;
      case 400:
        // print('status 400');
        // print(response.body);
        // final errors = jsonDecode(response.body)['data']['errors'];
        // apiResponse.error = errors[errors.keys.elementAt(0)][0];
        apiResponse.error = jsonDecode(response.body)['meta']['message'];
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

String apiPermohonanCuti = baseURL + '/api/attendances/addleave';

Future<ApiResponse> permohonanCuti({
  required String jeniscuti,
  required String tanggalmulai,
  required String tanggalakhir,
  required String keterangancuti,
  required String pekerjaanditinggalkan,
}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    print(token);
    final response = await http.post(Uri.parse(apiPermohonanCuti), headers: {
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    }, body: {
      'leave_type_id': jeniscuti,
      'application_from_date': tanggalmulai,
      'application_to_date': tanggalakhir,
      'purpose': keterangancuti,
      'abandoned_job': pekerjaanditinggalkan,
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

String apiPermohonanTugasDinas = baseURL + '/api/attendances/addduty';

Future<ApiResponse> permohonanTugasDinas({
  required String tanggalmulai,
  required String tanggalakhir,
  required String keterangantugas,
  required String tujuan,
  required String? dokument,
  required String jam,
  required String pekerjaanditinggalkan,
}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    print(token);
    final response =
        await http.post(Uri.parse(apiPermohonanTugasDinas), headers: {
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    }, body: {
      'duty_from_date': tanggalmulai,
      'duty_to_date': tanggalakhir,
      'time': jam,
      'place': keterangantugas,
      'purpose': tujuan,
      'attachment': dokument,
      'abandoned_job': pekerjaanditinggalkan,
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

String apiWeekAbsensi = baseURL + '/api/attendances/history';
Future<ApiResponse> getWeekAbsensi() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(apiWeekAbsensi), headers: {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    });
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data = jsonDecode(response.body)['data']
            .map((p) => WeekAbsensiModel.fromJson(p))
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

Future<ApiResponse> getWeekAbsensibyIdSiswa({required String idStudent}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
        Uri.parse(baseURL + '/api/data/historymapel/$idStudent'),
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
            .map((p) => WeekAbsensiPembelajaranModel.fromJson(p))
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

Future<ApiResponse> getWeekAbsensibyIdEmployee(
    {required String idEmployee}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http
        .get(Uri.parse(baseURL + '/api/data/history/$idEmployee'), headers: {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    });
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data = jsonDecode(response.body)['data']
            .map((p) => WeekAbsensiPembelajaranModel.fromJson(p))
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

String apiHistoryAbsensi = baseURL + '/api/attendances/historyall';
Future<ApiResponse> getHistoryAbsensi() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(apiHistoryAbsensi), headers: {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    });
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        print('anjay');
        print(response.body);
        apiResponse.data = jsonDecode(response.body)['data']
            .map((p) => HistoryAbsensiModel.fromJson(p))
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

Future<ApiResponse> getHistoryAbsensiPegawaibyId(
    {required String idEmployee}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http
        .get(Uri.parse(baseURL + '/api/data/historyall/$idEmployee'), headers: {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    });
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data = jsonDecode(response.body)['data']
            .map((p) => HistoryAbsensiModel.fromJson(p))
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

Future<ApiResponse> getHistoryAbsensiSiswabyId(
    {required String idStudent}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
        Uri.parse(baseURL + '/api/data/getsubjectall/$idStudent'),
        headers: {
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Bearer $token'
        });
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        print('anjay');
        print(response.body);
        apiResponse.data = jsonDecode(response.body)['data']
            .map((p) => HistoryAbsensiPembelajaranModel.fromJson(p))
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

String apiStatistic = baseURL + '/api/attendances/statistic';

Future<ApiResponse> getstatistic() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(apiStatistic), headers: {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    });

    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data =
            StatisticModel.fromJson(jsonDecode(response.body)['data']);
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

String apiStatisticSiswa = baseURL + '/api/monitoring/statisticmapel';

Future<ApiResponse> getStatistikSiswa() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(apiStatisticSiswa), headers: {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    });
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data =
            StatisticSiswaModel.fromJson(jsonDecode(response.body)['data']);
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

String apiWeekAbsensiPembelajaran = baseURL + '/api/monitoring/historymapel';
Future<ApiResponse> getWeekAbsensiPembelajaran() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response =
        await http.get(Uri.parse(apiWeekAbsensiPembelajaran), headers: {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    });
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data = jsonDecode(response.body)['data']
            .map((p) => WeekAbsensiPembelajaranModel.fromJson(p))
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

String apiHistoryAbsensiPembelajaran =
    baseURL + '/api/monitoring/getsubjectall';
Future<ApiResponse> getHistoryAbsensiPembelajaran() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response =
        await http.get(Uri.parse(apiHistoryAbsensiPembelajaran), headers: {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    });
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        print('anjay');
        print(response.body);
        apiResponse.data = jsonDecode(response.body)['data']
            .map((p) => HistoryAbsensiPembelajaranModel.fromJson(p))
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

String apiWeekAbsensiEkstra = baseURL + '/api/monitoring/historyextra';
Future<ApiResponse> getWeekAbsensiEsktra() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(apiWeekAbsensiEkstra), headers: {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    });
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data = jsonDecode(response.body)['data']
            .map((p) => WeekAbsensiPembelajaranModel.fromJson(p))
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

//Get Student for attandent

Future<ApiResponse> getSiswaForAbsen({required int id}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
        Uri.parse(baseURL + '/api/monitoring/getattendance/$id'),
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
            .map((p) => AbsensiSiswaModel.fromJson(p))
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

Future<ApiResponse> getSiswaForAbsenEkstra({required int id}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
        Uri.parse(baseURL + '/api/monitoring/getattendextra/$id'),
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
            .map((p) => AbsensiSiswaModel.fromJson(p))
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

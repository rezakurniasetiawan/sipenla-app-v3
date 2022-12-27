import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../constan.dart';
import '../../models/api_response_model.dart';
import '../../models/perpustakaan/pegawai_perpus_model.dart';
import '../../models/perpustakaan/pengguna_perpus_model.dart';
import '../auth_service.dart';

Future<ApiResponse> searchBook({
  required String code,
}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http
        .get(Uri.parse(baseURL + '/api/perpus/getbook/$code'), headers: {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    });
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data = DataBukuPenggunaPerpusModel.fromJson(
            jsonDecode(response.body)['data']);
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      case 405:
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

Future<ApiResponse> getBookbyId({
  required String idBook,
}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http
        .get(Uri.parse(baseURL + '/api/perpus/book/$idBook'), headers: {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    });

    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data =
            DataBukuPerpusModel.fromJson(jsonDecode(response.body)['data']);
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      case 405:
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

Future<ApiResponse> approvePengembalianBukuPerpus({
  required String idLoan,
}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(
        Uri.parse(baseURL + '/api/perpus/pendingreturn/$idLoan'),
        headers: {
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Bearer $token'
        });

    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data = jsonDecode(response.body);
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      case 405:
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

String apiOngoingPengguna = baseURL + '/api/perpus/getreturn';
Future<ApiResponse> getOngoungPerpus() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(apiOngoingPengguna), headers: {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    });
    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data = jsonDecode(response.body)['data']
            .map((p) => PengembalianOngoingPenggunaPerpusModel.fromJson(p))
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

String apiRiwayatPengPemPengguna = baseURL + '/api/perpus/historybyuser';
Future<ApiResponse> getRiwayatPengPemPengguna() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response =
        await http.get(Uri.parse(apiRiwayatPengPemPengguna), headers: {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    });
    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data = jsonDecode(response.body)['data']
            .map((p) => RiwayarPengPemModel.fromJson(p))
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

String apihistorysumbangbyuser = baseURL + '/api/perpus/historysumbangbyuser';
Future<ApiResponse> gethistorysumbangbyuser() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response =
        await http.get(Uri.parse(apihistorysumbangbyuser), headers: {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    });
    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data = jsonDecode(response.body)['data']
            .map((p) => RiwayarPengPemModel2.fromJson(p))
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

String apiCreateSumbangBuku = baseURL + '/api/perpus/addsumbangan';
Future<ApiResponse> createSumbangBuku(
    {required String bookname,
    required String bookprice,
    required String bookcreator,
    required String bookyear,
    required String numberofbook,
    required String? bookimage}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(Uri.parse(apiCreateSumbangBuku), headers: {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    }, body: {
      'book_name': bookname,
      'book_price': bookprice,
      'book_creator': bookcreator,
      'book_year': bookyear,
      'number_of_book': numberofbook,
      'book_image': bookimage,
    });
    print(response.statusCode);
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

Future<ApiResponse> approveSumbanganBukuPerpus({
  required String idLoan,
}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http
        .post(Uri.parse(baseURL + '/api/perpus/approvebook/$idLoan'), headers: {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    });

    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data = jsonDecode(response.body);
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      case 405:
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

Future<ApiResponse> reejectSumbanganBukuPerpus({
  required String idLoan,
}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http
        .post(Uri.parse(baseURL + '/api/perpus/rejectbook/$idLoan'), headers: {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    });

    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data = jsonDecode(response.body);
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      case 405:
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

// String apigetsumbanganemployee = baseURL + '/api/perpus/getsumbanganemployee';
Future<ApiResponse> gethistorysumbangstudent({required String date}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
        Uri.parse(baseURL + '/api/perpus/historysumbangstudent/$date'),
        headers: {
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Bearer $token'
        });
    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data = jsonDecode(response.body)['data']
            .map((p) => HistorySumbangBukuSiswaModel.fromJson(p))
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

Future<ApiResponse> gethistorysumbangemployee({required String date}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
        Uri.parse(baseURL + '/api/perpus/historysumbangemployee/$date'),
        headers: {
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Bearer $token'
        });
    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data = jsonDecode(response.body)['data']
            .map((p) => HistorySumbangBukuPegawaiModel.fromJson(p))
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

Future<ApiResponse> gethistorystudent({required String date}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http
        .get(Uri.parse(baseURL + '/api/perpus/historystudent/$date'), headers: {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    });
    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data = jsonDecode(response.body)['data']
            .map((p) => RiwayatPengajuanBukuSiswaPerpusModel.fromJson(p))
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

Future<ApiResponse> gethistoryemployee({required String date}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
        Uri.parse(baseURL + '/api/perpus/historyemployee/$date'),
        headers: {
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Bearer $token'
        });
    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data = jsonDecode(response.body)['data']
            .map((p) => PengajuanBukuPegawaiPerpusModel.fromJson(p))
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

Future<ApiResponse> pembayaranDendaDanKehillangan({
  required String idLoan,
  required String status,
  required String valueDenda,
}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(
        Uri.parse(baseURL + '/api/perpus/pendingreturndenda/$idLoan'),
        headers: {
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Bearer $token'
        },
        body: {
          'status_loan': status,
          'fine_transaction': valueDenda,
        });
    print(response.body);
    switch (response.statusCode) {
      case 200:
        apiResponse.data =
            PemabayaranDendaModel.fromJson(jsonDecode(response.body)['data']);
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

import 'dart:convert';

import '../../constan.dart';
import '../../models/api_response_model.dart';
import '../../models/perpustakaan/pegawai_perpus_model.dart';
import '../auth_service.dart';
import 'package:http/http.dart' as http;

String apiCreateBukuPerpus = baseURL + '/api/perpus/addbook';
Future<ApiResponse> cretaedBookPerpus(
    {required String bookname,
    required String bookprice,
    required String bookcreator,
    required String bookyear,
    required String numberofbook,
    required String? bookimage}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(Uri.parse(apiCreateBukuPerpus), headers: {
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

String apigetbookperpus = baseURL + '/api/perpus/getbook';
Future<ApiResponse> getBookPerpus() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(apigetbookperpus), headers: {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    });
    switch (response.statusCode) {
      case 200:
        // print(response.body);
        apiResponse.data = jsonDecode(response.body)['data']
            .map((p) => DataBukuPerpusModel.fromJson(p))
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

// String apiCreateBukuPerpus = baseURL + '/api/perpus/addbook';
Future<ApiResponse> deleteBookPerpus({required String idbook}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.delete(
      Uri.parse(baseURL + '/api/perpus/deletebook/$idbook'),
      headers: {
        'Accept': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
    );
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

Future<ApiResponse> updateBookPerpus(
    {required String bookname,
    required String idbook,
    required String bookprice,
    required String bookcreator,
    required String bookyear,
    required String numberofbook,
    required String? bookimage}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response =
        await http.post(Uri.parse(baseURL + '/api/perpus/updatebook/$idbook'),
            headers: {
              'Accept': 'application/json',
              'X-Requested-With': 'XMLHttpRequest',
              'Authorization': 'Bearer $token'
            },
            body: bookimage == null
                ? {
                    'book_name': bookname,
                    'book_price': bookprice,
                    'book_creator': bookcreator,
                    'book_year': bookyear,
                    'number_of_book': numberofbook,
                  }
                : {
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

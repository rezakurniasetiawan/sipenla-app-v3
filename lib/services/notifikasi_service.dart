import 'dart:convert';

import '../constan.dart';
import '../models/api_response_model.dart';
import '../models/notifikasi_model.dart';
import 'auth_service.dart';
import 'package:http/http.dart' as http;

String apiGetNotifikasi = baseURL + '/api/notif';
Future<ApiResponse> getNotifikasi() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(apiGetNotifikasi), headers: {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    });
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data = jsonDecode(response.body)['data']
            .map((p) => NotifikasiModel.fromJson(p))
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

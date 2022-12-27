// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'package:siakad_app/constan.dart';
import 'dart:convert';

import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/monitoring_model.dart';
import 'package:siakad_app/services/auth_service.dart';

Future<ApiResponse> getHistoryMonitoringPembelajaran(
    {required String tanggal,
    required int kelasId,
    required int mapelId}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
        Uri.parse(
            baseURL + '/api/monitoring/gethistory/$tanggal/$mapelId/$kelasId'),
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
            RiwayatMonitoringModel.fromJson(jsonDecode(response.body)['data']);
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

Future<ApiResponse> getHistoryMonitoringEkstra({
  required String tanggal,
  required int ekstraId,
}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
        Uri.parse(
            baseURL + '/api/monitoring/gethistoryextra/$tanggal/$ekstraId'),
        headers: {
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Bearer $token'
        });
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data = RiwayatMonitoringEkstraModel.fromJson(
            jsonDecode(response.body)['data']);
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

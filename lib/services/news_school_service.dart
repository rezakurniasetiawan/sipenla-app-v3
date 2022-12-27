// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:siakad_app/models/news_school_model.dart';
import 'package:siakad_app/services/auth_service.dart';

String apiNews = baseURL + '/api/news';
Future<ApiResponse> getPosts(int current_page) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response =
        await http.get(Uri.parse(apiNews + '?page=$current_page'), headers: {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    });
    print(response.statusCode);
    print(token);
    switch (response.statusCode) {
      case 200:
        // print(response.body);
        apiResponse.data = jsonDecode(response.body)['data'][0]['data']
            .map((p) => NewsModel.fromJson(p))
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
    print("Error sdsd ");
    apiResponse.error = serverError;
  }
  return apiResponse;
}

String apiCreateNews = baseURL + '/api/news/addnews';

Future<ApiResponse> createNews({
  required String title,
  required String content,
  required String? image,
}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(Uri.parse(apiCreateNews), headers: {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    }, body: {
      'news_title': title,
      'news_content': content,
      'news_image': image,
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        break;
      case 422:
        final errors = jsonDecode(response.body)['data']['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;

      default:
        apiResponse.error = somethingWhentWrong;
        break;
    }
  } catch (e) {
    print(serverError);
    apiResponse.error = serverError;
  }
  return apiResponse;
}

String apiDeleteNews = baseURL + '/api/news';

Future<ApiResponse> deleteNews(int newsId) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.delete(Uri.parse(baseURL + '/api/news/$newsId'),
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Bearer $token'
        });
    switch (response.statusCode) {
      case 200:
        print("response 200");
        apiResponse.data = jsonDecode(response.body);
        break;
      case 422:
        print("response 442");
        final errors = jsonDecode(response.body)['data']['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 404:
        print("response 404");
        print(response.body);
        apiResponse.error = jsonDecode(response.body)['message'];
        break;

      default:
        print(response.statusCode);
        print(response.body);
        apiResponse.error = somethingWhentWrong;
        break;
    }
  } catch (e) {
    print("object");
    apiResponse.error = serverError;
  }
  return apiResponse;
}

String apiUpdateNews = baseURL + '/api/news/addnews';

Future<ApiResponse> updateNews(
  int newsId,
  String title,
  String content,
  String? image,
) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(Uri.parse(baseURL + '/api/news/$newsId'),
        headers: {
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Bearer $token'
        },
        body: image == null
            ? {
                'news_title': title,
                'news_content': content,
              }
            : {
                'news_title': title,
                'news_content': content,
                'news_image': image
              }
              );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
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

// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:siakad_app/constan.dart';
import 'package:siakad_app/models/api_response_model.dart';
import 'package:http/http.dart' as http;

String apiForgot = baseURL + '/api/users/forgot';

Future<ApiResponse> forgotPassword({
  required String email,
}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(Uri.parse(apiForgot), headers: {
      'X-Requested-With': 'XMLHttpRequest',
    }, body: {
      'email': email,
    });
    switch (response.statusCode) {
      case 200:
        print("200");
        apiResponse.data = jsonDecode(response.body);
        break;
      case 422:
        print("422");
        final errors = jsonDecode(response.body)['data']['errors']['email'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        print("403");
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

String apiGetOtp = baseURL + '/api/users/otp';

Future<ApiResponse> getOtp({
  required String token,
}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(Uri.parse(apiGetOtp), headers: {
      'X-Requested-With': 'XMLHttpRequest',
    }, body: {
      'token': token,
    });
    switch (response.statusCode) {
      case 200:
        print('status 200');
        apiResponse.data = jsonDecode(response.body);
        break;
      case 400:
        print('status 422');
        final errors = jsonDecode(response.body)['data'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];

        break;

      default:
        print('status someting');
        apiResponse.error = somethingWhentWrong;
        break;
    }
  } catch (e) {
    print(serverError);
    apiResponse.error = serverError;
  }
  return apiResponse;
}

String apiChangePassword = baseURL + '/api/users/reset';

Future<ApiResponse> changePassword({
  required String token,
  required String password,
  required String passwordConfirmation,
}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(Uri.parse(apiChangePassword), headers: {
      'X-Requested-With': 'XMLHttpRequest',
    }, body: {
      'token': token,
      'password': password,
      'password_confirmation': passwordConfirmation,
    });
    switch (response.statusCode) {
      case 200:
        print('status 200');
        apiResponse.data = jsonDecode(response.body);
        break;
      case 400:
        print('status 422');
        final errors = jsonDecode(response.body);
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        print('status 403');
        apiResponse.error = jsonDecode(response.body)['message'];
        break;

      default:
        print('status someting');
        apiResponse.error = somethingWhentWrong;
        break;
    }
  } catch (e) {
    print(serverError);
    apiResponse.error = serverError;
  }
  return apiResponse;
}

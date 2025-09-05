import 'dart:convert';

import 'web_api/api_service.dart';
import 'web_api/endpoints.dart';

class AuthApi {
  static Future<dynamic> registerUser({
    required String userEmail,
    required String userPassword,
  }) async {
    final responseData = await NetworkHelper.postRequest(
      url: BaseURL.getBaseUrl + Auth.register,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': userEmail,
        'password': userPassword,
      }),
    );
    return responseData;
  }

    static Future<dynamic> loginUser({
    required String userEmail,
    required String userPassword,
  }) async {
    final responseData = await NetworkHelper.postRequest(
      url: BaseURL.getBaseUrl + Auth.login,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "email": userEmail,
        "password": userPassword,
      }),
    );
    return responseData;
  }
}

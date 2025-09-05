import 'dart:convert';

import 'web_api/api_service.dart';
import 'web_api/endpoints.dart';

class UserApi {
  static Future<dynamic> addUserInterests({
    required String userToken,
    required String userId,
    required List<dynamic> selectedInterests,
  }) async {
    final responseData = await NetworkHelper.postRequest(
      url: "${BaseURL.getBaseUrl}${User.users}/$userId/interests",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $userToken',
      },
      body: jsonEncode(<String, dynamic>{"interests": selectedInterests}),
    );
    return responseData;
  }

  static Future<dynamic> getUserInterests({
    required String userToken,
    required String userId,
  }) async {
    final responseData = await NetworkHelper.getRequest(
      url: "${BaseURL.getBaseUrl}${User.users}/$userId/interests",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $userToken',
      },
    );
    return responseData;
  }
}

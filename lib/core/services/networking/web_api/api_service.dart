import 'dart:io';

import 'package:http/http.dart' as http;

class NetworkHelper {
  static late http.Response response;

  static Future<dynamic> getRequest({
    required String url,
    Map<String, String>? headers,
  }) async {
    response = await http.get(Uri.parse(url), headers: headers);
    return response;
  }

  static Future<dynamic> postRequest({
    required String url,
    Map<String, String>? headers,
    Object? body,
  }) async {
    response = await http.post(Uri.parse(url), headers: headers, body: body);
    return response;
  }

  static Future<dynamic> putRequest({
    required String url,
    Map<String, String>? headers,
    required Object body,
  }) async {
    response = await http.put(Uri.parse(url), headers: headers, body: body);
    return response;
  }

  static Future<dynamic> patchRequest({
    required String url,
    Map<String, String>? headers,
    required Object body,
  }) async {
    response = await http.patch(Uri.parse(url), headers: headers, body: body);
    return response;
  }

  static Future<dynamic> deleteRequest({
    required String url,
    Map<String, String>? headers,
  }) async {
    response = await http.delete(Uri.parse(url), headers: headers);
    return response;
  }

  static Future<dynamic> postFileRequest({
    required String url,
    required String userToken,
    required File file,
    required String filename,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    required String gender,
    required String dateOfBirth,
  }) async {
    var request = http.MultipartRequest('PUT', Uri.parse(url))
      ..fields['firstName'] = firstName
      ..fields['lastName'] = lastName
      ..fields['phoneNumber'] = phoneNumber
      ..fields['email'] = email
      ..fields['dateOfBirth'] = dateOfBirth
      ..fields['gender'] = gender
      ..files.add(
        await http.MultipartFile.fromPath('profilePicture', file.path),
      );
    request.headers.addAll({
      "Authorization": "Bearer $userToken",
      "Content-type": "multipart/form-data",
    });
    var streamResponse = await request.send();
    var res = http.Response.fromStream(streamResponse);
    // print("This is response:${streamResponse.stream.bytesToString()}");
    return res;
  }
}

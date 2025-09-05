import 'web_api/api_service.dart';
import 'web_api/endpoints.dart';

class BlogApi {
  static Future<dynamic> getPosts({String? categoryId}) async {
    final responseData = await NetworkHelper.getRequest(
      url:
          "${BaseURL.getBaseUrl}${Blog.posts}?${categoryId != null && categoryId != '' ? 'categoryId=$categoryId' : ''}",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // 'Authorization': 'Bearer $userToken',
      },
    );
    return responseData;
  }

   static Future<dynamic> getCategories() async {
    final responseData = await NetworkHelper.getRequest(
      url:
          "${BaseURL.getBaseUrl}${Blog.categories}",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // 'Authorization': 'Bearer $userToken',
      },
    );
    return responseData;
  }
}

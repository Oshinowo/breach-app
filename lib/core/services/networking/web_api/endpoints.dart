class BaseURL {
  static String get getBaseUrl => 'https://breach-api.qa.mvm-tech.xyz';
}

class Auth {
  static String get register => '/api/auth/register';
  static String get login => '/api/auth/login';
}

class Blog {
  static String get posts => '/api/blog/posts';
  static String get categories => '/api/blog/categories';
}

class User {
  static String get users => '/api/users';
}

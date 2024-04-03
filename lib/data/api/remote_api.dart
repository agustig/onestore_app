mixin RemoteApi {
  static const base = "https://onestore.agustig.dev";
  static const api = "$base/api";
  final loginPath = "$api/login";
  final registerPath = "$api/register";
  final logoutPath = "$api/logout";
  final categoryPath = "$api/categories";
  final productPath = "$api/products";
  final orderPath = "$api/order";
  final bannerPath = "$api/banners/";
  final profilePath = "$api/profile";

  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8",
    "Accept": "application/json",
  };

  authyHeaders(String authToken) {
    final authyHeaders = headers;
    authyHeaders["Authorization"] = "Bearer $authToken";
    return authyHeaders;
  }
}

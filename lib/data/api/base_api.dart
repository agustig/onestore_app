class BaseApi {
  static const base = "https://ficlab.agustig.dev";
  static const api = "$base/api";
  final loginPath = "$api/login";
  final registerPath = "$api/register";

  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8",
    "Accept": "application/json",
  };
}

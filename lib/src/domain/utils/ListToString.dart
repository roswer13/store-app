String listToString(dynamic data) {
  String message = '';

  if (data is List<dynamic>) {
    message = data.join(" ");
  }
  if (data is String) {
    message = data;
  }
  return message;
}

class ServerException implements Exception {}

class DatabaseException implements Exception {
  final String message;

  DatabaseException(this.message);
}

class UnauthorizeException implements Exception {}

class ValidatorException implements Exception {
  final Map<String, List<String>> _messages;

  ValidatorException(Map<String, dynamic> messages)
      : _messages = messages.map((key, value) => MapEntry(
              key,
              (value as List<dynamic>)
                  .map((subValue) => subValue.toString())
                  .toList(),
            ));

  Map<String, List<String>> get messages => _messages;
}

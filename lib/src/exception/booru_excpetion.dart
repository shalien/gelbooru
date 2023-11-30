import 'package:http/http.dart';

/// An exception thrown by the booru client.
final class BooruException implements Exception {
  /// The message of the exception.
  final String message;

  /// The status code of the exception.
  final int statusCode;

  /// The reason phrase of the exception.
  final String? reasonPhrase;

  /// Create a [BooruException].
  const BooruException(this.message, this.statusCode, this.reasonPhrase);

  /// Create a [BooruException] from a [Response].
  BooruException.fromResponse(Response response)
      : message = response.body,
        statusCode = response.statusCode,
        reasonPhrase = response.reasonPhrase;

  @override
  String toString() {
    return 'BooruException(message: $message, statusCode: $statusCode, reasonPhrase: $reasonPhrase)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BooruException &&
        other.message == message &&
        other.statusCode == statusCode &&
        other.reasonPhrase == reasonPhrase;
  }

  @override
  int get hashCode =>
      message.hashCode ^ statusCode.hashCode ^ reasonPhrase.hashCode;
}

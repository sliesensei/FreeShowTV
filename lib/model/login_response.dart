
class RequestTokenResponse {
  final String requestToken;

  RequestTokenResponse({this.requestToken});

  factory RequestTokenResponse.fromJson(Map<String, dynamic> json) {
    return RequestTokenResponse(
      requestToken: json['request_token'],
    );
  }
}

class ValidateRequestTokenResponse {
  final String requestToken;

  ValidateRequestTokenResponse({this.requestToken});

  factory ValidateRequestTokenResponse.fromJson(Map<String, dynamic> json) {
    return ValidateRequestTokenResponse(
      requestToken: json['request_token'],
    );
  }
}

class SessionIdResponse {
  final String sessionId;

  SessionIdResponse({this.sessionId});

  factory SessionIdResponse.fromJson(Map<String, dynamic> json) {
    return SessionIdResponse(
      sessionId: json['session_id'],
    );
  }
}


import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

class MockHttpClientFactory {
  static http.Client get200Client(String responseBody) {
    return MockClient((request) async => http.Response(responseBody, 200));
  }

  static http.Client get404Client() {
    return MockClient((request) async => http.Response("", 404));
  }

  static http.Client getHttpExceptionClient() {
    return MockClient((request) async =>
        throw const HttpException("This is a simulated HttpException"));
  }

  static http.Client getTimeoutExceptionClient() {
    return MockClient((request) async =>
        throw TimeoutException("This is a simulated TimeoutException"));
  }

  static http.Client getWebSocketExecptionClient() {
    return MockClient((request) async => throw const WebSocketException(
        "This is a simulated WebSocketException"));
  }
}

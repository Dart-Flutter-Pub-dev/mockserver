import 'dart:io';
import 'package:mockserver/src/mockserver/end_point.dart';

class MockServer {
  final int port;
  final List<EndPoint> endPoints;
  final int endPointDelay;
  late HttpServer _server;

  MockServer({
    this.port = 8080,
    this.endPoints = const <EndPoint>[],
    this.endPointDelay = 0,
  });

  Future<int> start() async {
    _server = await HttpServer.bind(InternetAddress.anyIPv6, port);
    _server.listen(_onRequest);
    return _server.port;
  }

  Future<dynamic> stop() => _server.close();

  void _onRequest(HttpRequest request) {
    final HttpResponse response = request.response;

    try {
      final EndPoint? endPoint = _endPoint(request.method, request.uri.path);

      if (endPoint != null) {
        endPoint.processRequest(request, response, endPointDelay);
      } else {
        response.statusCode = StatusCode.NOT_FOUND;
        response.close();
      }
    } catch (e) {
      print(e.toString());

      response.statusCode = StatusCode.INTERNAL_SERVER_ERROR;
      response.close();
    }
  }

  EndPoint? _endPoint(String method, String path) {
    for (final EndPoint endPoint in endPoints) {
      if (!endPoint.hasPathParameters && endPoint.match(method, path)) {
        return endPoint;
      }
    }

    for (final EndPoint endPoint in endPoints) {
      if (endPoint.match(method, path)) {
        return endPoint;
      }
    }

    return null;
  }
}

import 'dart:io';
import 'package:mockserver/src/mockserver/end_point.dart';

class MockServer {
  final int port;
  final List<EndPoint> endPoints;
  final int endPointDelay;
  HttpServer server;

  MockServer({
    this.port,
    this.endPoints,
    this.endPointDelay = 500,
  });

  Future<dynamic> start() async {
    server = await HttpServer.bind(InternetAddress.anyIPv6, port);
    server.listen(onRequest);
  }

  Future<dynamic> stop() => server.close();

  void onRequest(HttpRequest request) {
    final HttpResponse response = request.response;
    final String method = request.method;
    final String path = request.uri.path;

    try {
      for (EndPoint endPoint in endPoints) {
        if (!endPoint.hasPathParameters && endPoint.match(method, path)) {
          endPoint.processRequest(request, response, endPointDelay);
          return;
        }
      }

      for (EndPoint endPoint in endPoints) {
        if (endPoint.match(method, path)) {
          endPoint.processRequest(request, response, endPointDelay);
          return;
        }
      }
    } catch (e) {
      print(e.toString());

      response.statusCode = 500;
      response.close();

      return;
    }

    response.statusCode = 404;
    response.close();
  }
}

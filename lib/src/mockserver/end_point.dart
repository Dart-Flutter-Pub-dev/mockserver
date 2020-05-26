import 'dart:convert';
import 'dart:io';

abstract class EndPoint {
  final String method;
  final String path;
  final String route;

  static const String GET = 'GET';
  static const String POST = 'POST';
  static const String PUT = 'PUT';
  static const String PATCH = 'PATCH';
  static const String DELETE = 'DELETE';

  EndPoint({
    this.method,
    this.path,
  }) : route = path.replaceAll(RegExp('\\{.*\\}'), '[^\/]+');

  bool get hasPathParameters => path != route;

  Future<String> body(HttpRequest request) => utf8.decodeStream(request);

  bool match(String method, String path) =>
      (method == this.method) && RegExp('^$route\$').hasMatch(path);

  void processRequest(HttpRequest request, HttpResponse response, int delay) {
    Future.delayed(
      Duration(milliseconds: delay),
      () => process(request, response),
    );
  }

  void process(HttpRequest request, HttpResponse response);
}

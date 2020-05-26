import 'package:mockserver/src/mockserver/mock_server.dart';
import 'package:mockserver/src/mockserver/end_point.dart';

Future<dynamic> main() async {
  final List<EndPoint> endPoints = [
    // end points
  ];

  final MockServer mockServer = MockServer(
    port: 8080,
    endPoints: endPoints,
  );
  await mockServer.start();
}

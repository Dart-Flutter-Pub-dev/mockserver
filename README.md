# Mockserver

A mock server for Dart.

## Example

```dart
final List<EndPoint> endPoints = [
  // end points
];

final MockServer mockServer = MockServer(
  port: 8080,
  endPoints: endPoints,
);
await mockServer.start();
```
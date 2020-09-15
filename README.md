# Mockserver

A mock server for Dart.

## Installation

Add the following dependency to your `pubspec.yaml`:

```yaml
dependencies: 
  mockserver: ^1.3.0
```

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
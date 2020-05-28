import 'package:mockserver/src/mockserver/end_point.dart';
import 'package:test/test.dart';

void main() {
  group('path matching', () {
    test('check matching', () async {
      // TODO(momo): finish test
      final List<String> paths = [
        '/foo/bar/{id}',
      ];

      expect(_index(paths, '/foo/bar/123'), '0');
    });
  });
}

String _index(List<String> paths, String path) {
  String result = '';

  for (int i = 0; i < paths.length; i++) {
    final PathMatcher pathMatcher = PathMatcher(paths[i]);

    if (pathMatcher.match(path)) {
      result += i.toString();
    }
  }

  return result;
}

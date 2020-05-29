import 'package:mockserver/src/mockserver/end_point.dart';
import 'package:test/test.dart';

void main() {
  group('path matching', () {
    test('/pet/123', () {
      expect(_index(PATHS, '/pet/123'), 0);
    });

    test('/pet/123/image', () {
      expect(_index(PATHS, '/pet/123/image'), 1);
    });

    test('/pet', () {
      expect(_index(PATHS, '/pet'), 2);
    });

    test('/pet/search', () {
      expect(_index(PATHS, '/pet/search'), 3);
    });

    test('/user/john', () {
      expect(_index(PATHS, '/user/john'), 4);
    });

    test('/user/login', () {
      expect(_index(PATHS, '/user/login'), 5);
    });

    test('/user', () {
      expect(_index(PATHS, '/user'), 6);
    });

    test('/store/inventory', () {
      expect(_index(PATHS, '/store/inventory'), 7);
    });

    test('/store/order/123', () {
      expect(_index(PATHS, '/store/order/123'), 8);
    });

    test('/store/order/123/download', () {
      expect(_index(PATHS, '/store/order/123/download'), 9);
    });

    test('/store/order', () {
      expect(_index(PATHS, '/store/order'), 10);
    });
  });
}

const List<String> PATHS = [
  '/pet/{petId}', // 0
  '/pet/{petId}/image', // 1
  '/pet', // 2
  '/pet/search', // 3

  '/user/{username}', // 4
  '/user/login', // 5
  '/user', // 6

  '/store/inventory', // 7
  '/store/order/{orderId}', // 8
  '/store/order/{orderId}/download', // 9
  '/store/order', // 10
];

int _index(List<String> paths, String path) {
  for (int i = 0; i < paths.length; i++) {
    final PathMatcher pathMatcher = PathMatcher(paths[i]);

    if (pathMatcher.match(path)) {
      return i;
    }
  }

  return -1;
}

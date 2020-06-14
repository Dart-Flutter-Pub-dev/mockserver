import 'package:mockserver/src/mockserver/end_point.dart';
import 'package:test/test.dart';

void main() {
  group('path matching', () {
    test('/pet/123', () {
      check('/pet/123', 0);
    });

    test('/pet/123/image', () {
      check('/pet/123/image', 1);
    });

    test('/pet', () {
      check('/pet', 2);
    });

    test('/pet/search', () {
      check('/pet/search', 3);
    });

    test('/user/john', () {
      check('/user/john', 4);
    });

    test('/user/login', () {
      check('/user/login', 5);
    });

    test('/user', () {
      check('/user', 6);
    });

    test('/store/inventory', () {
      check('/store/inventory', 7);
    });

    test('/store/order/123', () {
      check('/store/order/123', 8);
    });

    test('/store/order/123/download', () {
      check('/store/order/123/download', 9);
    });

    test('/store/order', () {
      check('/store/order', 10);
    });
  });
}

const List<String> PATHS = <String>[
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

void check(String path, int index) => expect(_index(PATHS, path), index);

int _index(List<String> paths, String path) {
  for (int i = 0; i < paths.length; i++) {
    final PathMatcher pathMatcher = PathMatcher(paths[i]);

    if (!paths[i].contains('{') && pathMatcher.match(path)) {
      return i;
    }
  }

  for (int i = 0; i < paths.length; i++) {
    final PathMatcher pathMatcher = PathMatcher(paths[i]);

    if (pathMatcher.match(path)) {
      return i;
    }
  }

  return -1;
}

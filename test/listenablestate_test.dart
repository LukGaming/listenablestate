import 'package:flutter_test/flutter_test.dart';

import 'package:listenablestate/listenablestate.dart';

void main() {
  test('should test listenablestate', () {
    final counterNotifier = ListenableState(0);
    counterNotifier.update(counterNotifier.state + 1);
    expect(counterNotifier.state, 1);
    counterNotifier.update(counterNotifier.state + 1);
    expect(counterNotifier.state, 2);
  });
}

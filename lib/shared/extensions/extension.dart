import 'dart:async';

extension FutureDelayExtension<T> on Future<T> {
  Future<T> withDelay([int seconds = 1]) async {
    await Future.delayed(Duration(seconds: seconds));
    return await this;
  }
}

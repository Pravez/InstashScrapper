import 'package:hooks_riverpod/hooks_riverpod.dart';

class StoreNotifier<T> extends StateNotifier<Set<T>> {
  StoreNotifier() : super({});

  void add(T data) {
    state.add(data);
    state = state;
  }

  void addAll(Iterable<T> data) {
    state.addAll(data);
    state = state;
  }

  void remove(T data) {
    state.remove(data);
    state = state;
  }
}

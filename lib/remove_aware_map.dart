typedef void HasRemovedCallback(dynamic key, dynamic value);

class RemoveAwareMap<K, V> implements Map<K, V> {

  HasRemovedCallback? hasRemovedCallback;

  Map<K, V> impl = Map<K, V>();

  @override
  V? operator [](Object? key) {
    return impl[key];
  }

  @override
  void operator []=(key, value) {
    impl[key] = value;
  }

  @override
  void addAll(Map<K, V> other) {
    impl.addAll(other);
  }

  @override
  void addEntries(Iterable<MapEntry<K, V>> newEntries) {
    impl.addEntries(newEntries);
  }

  @override
  Map<RK, RV> cast<RK, RV>() {
    return impl.cast<RK, RV>();
  }

  @override
  void clear() {
    Map<K, V> temp = Map.from(impl);
    impl.clear();
    if (hasRemovedCallback != null) {
      temp.forEach(hasRemovedCallback!);
    }
  }

  @override
  bool containsKey(Object? key) {
    return impl.containsKey(key);
  }

  @override
  bool containsValue(Object? value) {
    return impl.containsValue(value);
  }

  @override
  Iterable<MapEntry<K, V>> get entries => impl.entries;

  @override
  void forEach(void f(K key, V value)) {
    impl.forEach(f);
  }

  @override
  bool get isEmpty => impl.isEmpty;

  @override
  bool get isNotEmpty => impl.isNotEmpty;

  @override
  Iterable<K> get keys => impl.keys;

  @override
  int get length => impl.length;

  @override
  Map<K2, V2> map<K2, V2>(MapEntry<K2, V2> f(K key, V value)) {
    return impl.map<K2, V2>(f);
  }

  @override
  V putIfAbsent(K key, V ifAbsent()) {
    return impl.putIfAbsent(key, ifAbsent);
  }

  @override
  V? remove(Object? key) {
    bool containsKey = impl.containsKey(key);
    V? value = impl.remove(key);
    if (containsKey && hasRemovedCallback != null) {
      hasRemovedCallback!(key, value);
    }
    return value;
  }

  @override
  void removeWhere(bool predicate(K key, V value)) {
    impl.removeWhere((K key, V value) {
      bool removed = predicate(key, value);
      if (removed && hasRemovedCallback != null) {
        hasRemovedCallback!(key, value);
      }
      return removed;
    });
  }

  @override
  V update(K key, V update(V value), {V ifAbsent()?}) {
    return impl.update(key, update, ifAbsent: ifAbsent);
  }

  @override
  void updateAll(V update(K key, V value)) {
    impl.updateAll(update);
  }

  @override
  Iterable<V> get values => impl.values;
}

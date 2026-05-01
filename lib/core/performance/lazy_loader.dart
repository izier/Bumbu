class LazyLoader<T> {
  T? _value;
  final T Function() builder;

  LazyLoader(this.builder);

  T get value {
    _value ??= builder();
    return _value!;
  }
}

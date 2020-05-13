/// Base config class, it has a key, value and a description which is displayed
/// on the settings screen
/// Implementations should use strong types instead of [T]
abstract class ModuleConfigItem<T> {
  final String key;
  final String description;
  final T value;

  ModuleConfigItem(this.key, this.value, this.description)
      : assert(key != null),
        assert(value != null);

  @override
  String toString() =>
      "${this.runtimeType}: { key: $key, value: $value, description: $description }";
}

///
final class ConfigurableItem<T> {
  /// The title of the item
  String title;

  /// The actual value that can be edited if [isEditable]
  /// [value] will set the value if [validate] returns true
  T? value;

  /// Used to determine if the [value] can be edited
  ///  and use editatble fields
  bool isEditable;

  ConfigurableItem({
    required this.title,
    this.value,
    this.isEditable = false,
  });

  /// Convert the provided [entry] to [ConfigurableItem] instance
  factory ConfigurableItem.fromMapEntry(MapEntry<String, T> entry,
      {bool isEditable = false}) {
    return ConfigurableItem(
      title: entry.key,
      value: entry.value,
      isEditable: isEditable,
    );
  }

  /// Convert the provided [map] to [ConfigurableItem] instance
  factory ConfigurableItem.fromJson(Map<String, dynamic> map) {
    return ConfigurableItem(
      title: map['title'],
      value: map['value'],
      isEditable: bool.tryParse(map['editable'] ?? '') ?? false,
    );
  }
}

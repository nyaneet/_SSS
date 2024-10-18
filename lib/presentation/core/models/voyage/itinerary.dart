///
///Common data of the given [Itinerary]
abstract interface class Itinerary {
  int get index;
  String get port;
  String get portCode;
  DateTime get departure;
  DateTime get arrival;
  int get draftLimit;
}

/// A [Iterinerary] implementation based on JSON
final class JsonItinerary implements Itinerary {
  final Map<String, dynamic> _json;

  JsonItinerary({required Map<String, dynamic> json}) : _json = json;

  @override
  int get index => int.parse(_json['index']);

  @override
  DateTime get arrival => DateTime.parse(_json['arrival']);

  @override
  DateTime get departure => DateTime.parse(_json['departure']);

  @override
  String get port => _json['port'];

  @override
  String get portCode => _json['port_code'];

  @override
  int get draftLimit => int.tryParse(_json['draft_limit']) ?? 0;
}

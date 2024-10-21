///
/// Ship details
class Ship {
  /// name of the ship
  final String name;

  /// call sign of the ship
  final String callSign;

  /// IMO number
  final String imo;

  /// type of the ship
  final String type;

  /// Society classification
  final String classification;

  /// Registation number
  final String registration;

  /// Registration port
  final String registrationPort;

  /// Flag state
  final String flagState;

  /// Owner of the ship
  final String owner;

  /// Owner code
  final String ownerCode;

  /// Yard where the ship was built
  final String buildYard;

  /// Place where the ship was built
  final String buildPlace;

  /// Year when the ship was built
  final String buildYear;

  /// Builder number
  final String builderNumber;

  /// Master of the ship
  String? _master;

  /// Chief mate of the ship
  String? _chiefMate;

  Ship({
    required this.name,
    required this.callSign,
    required this.imo,
    required this.type,
    required this.classification,
    required this.registration,
    required this.registrationPort,
    required this.flagState,
    required this.owner,
    required this.ownerCode,
    required this.buildYard,
    required this.buildPlace,
    required this.buildYear,
    required this.builderNumber,
    String? master,
    String? chiefMate,
  })  : _master = master,
        _chiefMate = chiefMate;

  String get master => _master ?? '';

  String get chiefMate => _chiefMate ?? '';

  /// List of fields that can be edited.
  List<String> editableFields = ['ship_master', 'ship_chief_mate'];

  /// Checks if the given [field] is found in [editableFields] list
  /// returns true if found, false otherwise.
  /// used to determine if a field can be edited.
  bool isFieldEditable(String field) {
    return editableFields.contains(field);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ship_name': name,
      'call_sign': callSign,
      'imo': imo,
      'ship_type': type,
      'ship_classification': classification,
      'registration': registration,
      'registration_port': registrationPort,
      'flag_state': flagState,
      'ship_owner': owner,
      'ship_owner_code': ownerCode,
      'build_yard': buildYard,
      'build_place': buildPlace,
      'build_year': buildYear,
      'ship_builder_number': builderNumber,
      'ship_master': master,
      'ship_chief_mate': chiefMate,
    };
  }

  /// Converts a JSON object into a [Ship] object
  factory Ship.fromJson(Map<String, dynamic> map) {
    return Ship(
      name: map['ship_name'] as String,
      callSign: map['call_sign'] as String,
      imo: map['imo'] as String,
      type: map['ship_type'] as String,
      classification: map['ship_classification'] as String,
      registration: map['registration'] as String,
      registrationPort: map['registration_port'] as String,
      flagState: map['flag_state'] as String,
      owner: map['ship_owner'] as String,
      ownerCode: map['ship_owner_code'] as String,
      buildYard: map['build_yard'] as String,
      buildPlace: map['build_place'] as String,
      buildYear: map['build_year'] as String,
      builderNumber: map['ship_builder_number'] as String,
      master: map['ship_master'],
      chiefMate: map['ship_chief_mate'],
    );
  }
}

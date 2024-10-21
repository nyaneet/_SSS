import 'package:hmi_core/hmi_core_failure.dart';
import 'package:hmi_core/hmi_core_result_new.dart';
import 'package:sss/presentation/core/models/ship/ship.dart';

///
/// Vessel details collection that stored in postgres DB.
/// TODO: Postgres database access implementation
/// 
class PgVesselDetails {
  Future<Result<Ship, Failure<String>>> fetchShip() async {
    return Ok(
      Ship.fromJson({
        "ship_name": "Наименование судна",
        "call_sign": "Позывной",
        "imo": "Номер ИМО",
        "ship_type": "Тип судна",
        "ship_classification": "Классификационное общество",
        "registration": "Регистровый номер",
        "registration_port": "Порт приписки",
        "flag_state": "Флаг приписки",
        "ship_owner": "Cудовладелец",
        "ship_owner_code": "Код судовладельца",
        "build_yard": "Верфь постройки",
        "build_place": "Место постройки",
        "build_year": "Год постройки",
        "ship_builder_number": "Заводской номер",
        "ship_master": "Капитан",
        "ship_chief_mate": "Старший помощник капитана"
      }),
    );
  }
}

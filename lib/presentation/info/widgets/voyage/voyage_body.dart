import 'package:flutter/material.dart';
import 'package:hmi_core/hmi_core_app_settings.dart';
import 'package:hmi_core/hmi_core_result_new.dart';
import 'package:hmi_core/hmi_core_translate.dart';
import 'package:hmi_widgets/hmi_widgets.dart';
import 'package:sss/presentation/core/models/voyage/voyage.dart';
import 'package:sss/presentation/core/validation/real_validation_case.dart';
import 'package:sss/presentation/core/widgets/edit_on_tap_field.dart';

import 'package:sss/presentation/core/widgets/future_builder_widget.dart';
import 'package:sss/presentation/core/widgets/table/table_nullable_cell.dart';
import 'package:sss/presentation/core/widgets/zebra_stripped_list.dart';
import 'package:sss/presentation/info/widgets/voyage/pg_voyage_details.dart';
import 'package:sss/presentation/info/widgets/voyage/voyage_itinerary_table.dart';
import 'package:sss/presentation/subscripting/subscripting.dart';

///
/// The widget that displays the body of the voyage
/// e.g [VoyageItineraries] and [VoyageFlightDetails]
class VoyageBody extends StatelessWidget {
  ///
  const VoyageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final blockPadding = const Setting('blockPadding').toDouble;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: blockPadding),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: EdgeInsets.all(blockPadding),
                child: FutureBuilderWidget(
                  onFuture: PgVoyageDetails().fetchDetails,
                  caseData: (_, details, __) =>
                      _BuildDetailsWidget(details: details),
                ),
              ),
            ),
          ),
          SizedBox(height: blockPadding),
          Expanded(
            // flex: 3,
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(blockPadding),
                child: FutureBuilderWidget(
                  onFuture: PgVoyageDetails().fetchItineraries,
                  caseData: (_, data, __) => VoyageItineraryTable(
                    itineraries: data,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _BuildDetailsWidget extends StatefulWidget {
  const _BuildDetailsWidget({required this.details});

  /// The details to be displayed
  final Voyage details;

  @override
  State<_BuildDetailsWidget> createState() => __BuildDetailsWidgetState();
}

class __BuildDetailsWidgetState extends State<_BuildDetailsWidget> {
  late ScrollController _scrollController;

  //
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  //
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final padding = const Setting('padding').toDouble;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          Localized('Ship').v,
          textAlign: TextAlign.start,
          style: theme.textTheme.titleLarge,
        ),
        SizedBox(height: padding),
        Expanded(
          child: ZebraStripedListView<MapEntry<String, String>>(
            scrollController: _scrollController,
            scrollbarThickness: 0.0,
            items: widget.details.toMap().entries.toList(),
            buildItem: (context, item, stripped) => Padding(
              padding: EdgeInsets.all(padding / 2),
              child: Row(
                children: [
                  if (!widget.details.isEntryDescription(item.key))
                    Expanded(
                      child: Text(item.key),
                    ),
                  Flexible(
                    child: _buildValueWidget(item, padding: padding),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildValueWidget(MapEntry<String, String?> item,
      {double padding = 0}) {
    switch (item.key) {
      case 'intake_water_density':
        return EditOnTapField(
          initialValue: item.value ?? '',
          onSubmitted: (value) => Ok(value),
          validator: Validator(
            cases: [
              ///todo: add more cases e.g min, max
              RealValidationCase(),
            ],
          ),
          onSubmit: (String value) async {
            return Ok(value);
          },
        );

      case 'voyage_description':
        return EditOnTapField(
          initialValue: item.value ?? '',
          onSubmitted: (value) => Ok(value),
          onSubmit: (String value) async {
            return Ok(value);
          },
        );
      case 'cargo_grade':
        return _BuildDropdownButton(
          items: CargoGrade.values.map((e) => e.name).toList(),
          initialValue: CargoGrade.fromString(item.value).name,
          onChanged: (value) async => Ok(value),
        );
      case 'aquatorium':
        return _BuildDropdownButton(
          items: Aquatorium.values.map((e) => e.name).toList(),
          initialValue: Aquatorium.fromString(item.value).name,
          onChanged: (value) async => Ok(value),
        );
      case 'icing':
        return _BuildDropdownButton(
          items: Icing.values.map((e) => e.name).toList(),
          initialValue: Icing.fromString(item.value).name,
          onChanged: (value) async => Ok(value),
        );
      case 'wetting_deck':
        return _BuildDropdownButton(
          items: ["Нет", "Да"],
          initialValue: item.value,
          onChanged: (value) async => Ok(value),
        );
      default:
        return NullableCellWidget(value: item.value);
    }
  }
}

class _BuildDropdownButton extends StatefulWidget {
  const _BuildDropdownButton(
      {required this.items, this.initialValue, required this.onChanged});
  final String? initialValue;
  final List<String> items;
  final Future<ResultF<String>> Function(String) onChanged;

  @override
  State<_BuildDropdownButton> createState() => _BuildDropdownButtonState();
}

class _BuildDropdownButtonState extends State<_BuildDropdownButton> {
  late String _initialValue;

  @override
  void initState() {
    _initialValue = widget.initialValue ?? widget.items.firstOrNull ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        value: _initialValue,
        isDense: true,
        padding: EdgeInsets.zero,
        isExpanded: true,
        items: widget.items
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child: Text(Localized(e).v),
              ),
            )
            .toList(),
        onChanged: (value) {
          if (value == null) return;
          _initialValue = value;
          widget.onChanged(_initialValue).then((value) {
            setState(() {});
          });
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hmi_core/hmi_core.dart';
import 'package:hmi_core/hmi_core_app_settings.dart';
import 'package:hmi_core/hmi_core_result_new.dart';
import 'package:sss/presentation/core/models/configurable_item/configurable_item.dart';
import 'package:sss/presentation/core/widgets/edit_on_tap_field.dart';

import 'package:sss/presentation/core/widgets/table/table_nullable_cell.dart';
import 'package:sss/presentation/core/widgets/zebra_stripped_list.dart';

///
///  The widget that displays a [ZebraStripedListView] of [ConfigurableItem]s
class EditableZebraList extends StatefulWidget {
  const EditableZebraList({
    super.key,
    required this.title,
    required this.items,
    this.showScrollbar = true,
    this.showItemTitle = true,
  });

  /// Whether or not to prefix item title
  final bool showItemTitle;

  /// The unlocalized [String] for the title
  final String title;

  ///
  /// Whether or not to show the scrollbar
  final bool showScrollbar;

  /// The list of [ConfigurableItem]s
  final List<ConfigurableItem> items;

  @override
  State<EditableZebraList> createState() => _EditableZebraListState();
}

class _EditableZebraListState extends State<EditableZebraList> {
  late final ScrollController scrollController;

  //
  @override
  void initState() {
    scrollController = ScrollController();

    super.initState();
  }

  //
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final padding = const Setting('padding').toDouble;
    final theme = Theme.of(context);
    final scrollbarThickness = widget.showScrollbar ? 8.0 : 0.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          Localized(widget.title).v,
          textAlign: TextAlign.start,
          style: theme.textTheme.titleLarge,
        ),
        SizedBox(height: padding),
        Expanded(
          child: ZebraStripedListView<ConfigurableItem>(
            scrollController: scrollController,
            scrollbarThickness: scrollbarThickness,
            items: widget.items,
            buildItem: (context, item, stripped) => Padding(
              padding: EdgeInsets.all(padding / 2),
              child: Row(
                children: [
                  if (widget.showItemTitle)
                    Expanded(
                      child: Text(item.title),
                    ),
                  !item.isEditable
                      ? Expanded(
                          child: NullableCellWidget(
                            value: item.value,
                          ),
                        )
                      : Expanded(
                          child: EditOnTapField(
                            initialValue: item.value ?? '',
                            label: widget.showItemTitle ? null : item.title,
                            maxLines: 5,
                            onSubmit: (value) async {
                              return Ok(value);
                            },
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/data.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

final sourceProvider = Provider(HashtagDataSource.new);

class HashtagsListView extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final source = ref.watch(sourceProvider);
    return SfDataGrid(
        source: source,
        columnWidthMode: ColumnWidthMode.fill,
        columns: [
          GridColumn(
              columnName: 'name',
              label: Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.centerLeft,
                  child: const Text('Name'))),
          GridColumn(
              columnName: 'lastCheck',
              label: Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.centerLeft,
                  child: const Text('Last Check'))),
          GridColumn(
              columnName: 'mediaCount',
              label: Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.centerLeft,
                  child: const Text('Media Count'))),
        ]);
  }
}

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/api/instash_scrapper.swagger.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class HashtagsListView extends HookConsumerWidget {
  const HashtagsListView(this.data, {super.key});

  final List<HashtagToCheck> data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final source = HashtagDataSource(data);
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

class HashtagDataSource extends DataGridSource {
  HashtagDataSource(List<HashtagToCheck> data) {
    _hashtags = data
        .map((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(
                  columnName: 'lastCheck',
                  value: e.lastCheck?.toIso8601String()),
              DataGridCell<int>(columnName: 'mediaCount', value: e.mediaCount)
            ]))
        .toList();
  }

  List<DataGridRow> _hashtags = [];

  @override
  List<DataGridRow> get rows => _hashtags;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row
            .getCells()
            .map((e) => Container(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(e.value.toString()),
                ))
            .toList());
  }
}

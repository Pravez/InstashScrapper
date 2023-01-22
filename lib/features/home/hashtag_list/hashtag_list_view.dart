import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/api/instash_scrapper.swagger.dart';
import 'package:instash_scrapper/features/home/hashtag_list/hashtag_list_provider.dart';
import 'package:instash_scrapper/shared/loading_state.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class HashtagsListView extends ConsumerStatefulWidget {
  const HashtagsListView({super.key});

  @override
  HashtagsListViewState createState() => HashtagsListViewState();
}

class HashtagsListViewState extends ConsumerState<HashtagsListView> {
  final List<GridColumn> _columns = [
    GridColumn(columnName: "name", label: _generateColumnLabel("Nom")),
    GridColumn(
        columnName: "mediaCount",
        label: _generateColumnLabel("Médias concernés",
            align: Alignment.centerRight)),
    GridColumn(
        columnName: "lastCheck",
        label: _generateColumnLabel("Dernière vérification")),
  ];

  final HashtagToCheckDataSource _source =
      HashtagToCheckDataSource(hashtags: []);

  PlutoGridStateManager? stateManager;

  static _generateColumnLabel(String name, {Alignment? align}) => Container(
      padding: const EdgeInsets.all(16.0),
      alignment: align ?? Alignment.centerLeft,
      child: Text(name));

  @override
  Widget build(BuildContext context) {
    final hashtags = ref.watch(hashtagListProvider).hashtags;
    final loading = ref.watch(hashtagListProvider).loading;

    if (loading is! LoadingState) {
      _source.updateRows(hashtags);
    }

    return Expanded(
      child: SfDataGrid(
        allowSorting: true,
        columnWidthMode: ColumnWidthMode.fill,
        rowHeight: 50,
        source: _source,
        columns: _columns,
      ),
    );
  }
}

class HashtagToCheckDataSource extends DataGridSource {
  HashtagToCheckDataSource({required List<HashtagToCheck> hashtags}) {
    updateRows(hashtags);
  }

  List<DataGridRow> _hashtags = [];

  @override
  List<DataGridRow> get rows => _hashtags;

  updateRows(List<HashtagToCheck> hashtags) {
    _hashtags = hashtags
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<int>(columnName: 'mediaCount', value: e.mediaCount),
              DataGridCell<DateTime>(
                  columnName: 'lastCheck', value: e.lastCheck),
            ]))
        .toList();
    notifyListeners();
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: dataGridCell.columnName == 'mediaCount'
            ? Alignment.centerRight
            : Alignment.centerLeft,
        padding: const EdgeInsets.all(16.0),
        child: Text(dataGridCell.columnName == "lastCheck" ? DateFormat.yMEd("fr").format(dataGridCell.value) : dataGridCell.value.toString()),
      );
    }).toList());
  }
}

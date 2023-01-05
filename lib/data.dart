import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/api/instash_scrapper.swagger.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'home.dart';

class HashtagDataSource extends DataGridSource {
  HashtagDataSource(this.ref) {
    ref.listen(hashtagListProvider, (previous, next) {
      _hashtags = next
          .map((e) => DataGridRow(cells: [
                DataGridCell<String>(columnName: 'name', value: e.name),
                DataGridCell<String>(
                    columnName: 'lastCheck',
                    value: e.lastCheck?.toIso8601String()),
                DataGridCell<int>(columnName: 'mediaCount', value: e.mediaCount)
              ]))
          .toList();
      notifyListeners();
    });
  }

  final Ref ref;

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

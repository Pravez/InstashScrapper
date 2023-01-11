import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/api/instash_scrapper.swagger.dart';
import 'package:instash_scrapper/features/home/hashtag_list/hashtag_list_provider.dart';
import 'package:instash_scrapper/shared/loading_state.dart';
import 'package:pluto_grid/pluto_grid.dart';

class HashtagsListView extends ConsumerStatefulWidget {
  const HashtagsListView({super.key});

  @override
  HashtagsListViewState createState() => HashtagsListViewState();
}

class HashtagsListViewState extends ConsumerState<HashtagsListView> {
  final List<PlutoColumn> columns = [
    PlutoColumn(title: "Name", field: "name", type: PlutoColumnType.text()),
    PlutoColumn(
        title: "Media Count",
        field: "media_count",
        type: PlutoColumnType.number(),
        enableSorting: true),
    PlutoColumn(
        title: "Last check", field: "last_check", type: PlutoColumnType.date())
  ];

  PlutoGridStateManager? stateManager;

  @override
  Widget build(BuildContext context) {
    final hashtags = ref.watch(hashtagListProvider).hashtags;
    final loading = ref.watch(hashtagListProvider).loading;

    if (loading is! LoadingState) {
      updateRows(hashtags);
    }

    return Expanded(
      child: PlutoGrid(
        columns: columns,
        rows: [],
        onLoaded: (event) {
          stateManager = event.stateManager;
        },
        configuration: const PlutoGridConfiguration(
            columnSize: PlutoGridColumnSizeConfig(
                autoSizeMode: PlutoAutoSizeMode.equal,
                resizeMode: PlutoResizeMode.pushAndPull)),
      ),
    );
  }

  updateRows(List<HashtagToCheck> data) {
    if (stateManager != null) {
      stateManager!.removeAllRows();
      stateManager!.appendRows(data
          .map((e) => PlutoRow(cells: {
                'name': PlutoCell(value: e.name),
                'media_count': PlutoCell(value: e.mediaCount),
                'last_check': PlutoCell(value: e.lastCheck)
              }))
          .toList());
    }
  }
}

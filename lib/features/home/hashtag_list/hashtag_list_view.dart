import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/api/instash_scrapper.swagger.dart';
import 'package:instash_scrapper/app/app.dart';
import 'package:instash_scrapper/features/home/hashtag_list/hashtag_list_provider.dart';
import 'package:instash_scrapper/features/home/provider.dart';
import 'package:instash_scrapper/shared/loading_state.dart';
import 'package:pluto_grid/pluto_grid.dart';

class HashtagsListView extends ConsumerStatefulWidget {
  const HashtagsListView({super.key});

  @override
  HashtagsListViewState createState() => HashtagsListViewState();
}

class HashtagsListViewState extends ConsumerState<HashtagsListView> {
  final List<PlutoColumn> columns = [
    PlutoColumn(
        title: "Name",
        field: "name",
        type: PlutoColumnType.text(),
        enableRowChecked: true,
        enableEditingMode: false),
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
    final theme = ref.watch(themeProvider);

    if (loading is! LoadingState) {
      updateRows(hashtags);
    }

    return Expanded(
      child: Card(
        child: PlutoGrid(
          columns: columns,
          rows: List<PlutoRow>.empty(),
          onLoaded: (event) {
            stateManager = event.stateManager;
          },
          onRowChecked: (e) {
            if (e.row != null && e.isChecked != null) {
              if (e.isChecked!) {
                ref
                    .read(selectionProvider.notifier)
                    .update((state) => [...state, e.row!]);
              } else {
                ref.read(selectionProvider.notifier).state.remove(e.row!);
              }
            }
          },
          configuration: const PlutoGridConfiguration(
            style: PlutoGridStyleConfig(
              gridBackgroundColor: Colors.black38
            ),
              columnSize: PlutoGridColumnSizeConfig(
                  autoSizeMode: PlutoAutoSizeMode.equal,
                  resizeMode: PlutoResizeMode.pushAndPull)),
        ),
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

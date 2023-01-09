import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/api/instash_scrapper.swagger.dart';
import 'package:instash_scrapper/features/home/hashtag_list/hashtag_list_provider.dart';
import 'package:instash_scrapper/shared/api_provider.dart';
import 'package:pluto_grid/pluto_grid.dart';

final rowProvider = StateProvider<Set<HashtagToCheck>>((ref) {
  final listProvider = ref.watch(hashtagListProvider);

  return listProvider
      .map((e) => PlutoRow(cells: {
            'name': PlutoCell(value: e.name),
            'media_count': PlutoCell(value: e.mediaCount),
            'last_check': PlutoCell(value: e.lastCheck)
          }))
      .toList();
});

class HashtagsListView extends HookConsumerWidget {
  HashtagsListView({super.key});

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

  late final PlutoGridStateManager stateManager;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rows = ref.watch(rowProvider);

    return Expanded(
      child: PlutoGrid(
        columns: columns,
        rows: rows,
        onLoaded: (event) {
          stateManager = event.stateManager;
        },
        configuration: const PlutoGridConfiguration(
            columnSize: PlutoGridColumnSizeConfig(
                autoSizeMode: PlutoAutoSizeMode.equal,
                resizeMode: PlutoResizeMode.pushAndPull)),
        onChanged: (event) => print(event),
      ),
    );
  }
}

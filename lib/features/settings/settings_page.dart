import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/shared/api_provider.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends ConsumerWidget {
  SettingsPage({Key? key}) : super(key: key);

  TextEditingController serverAddress = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    serverAddress.text = ref.read(apiUrlProvider);

    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => AutoRouter.of(context).navigateBack(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => validateAndClose(context, ref),
          child: const Icon(Icons.check),
        ),
        body: SettingsList(
          sections: [
            SettingsSection(
              title: const Text("Server configuration"),
              tiles: [
                CustomSettingsTile(
                    child: TextField(
                        cursorColor: Colors.grey,
                        controller: serverAddress,
                        decoration: const InputDecoration(
                            filled: true,
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            hintText: 'Addresse du serveur',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 18),
                            prefixIcon: Icon(Icons.edit_location_alt))))
              ],
            )
          ],
        ));
  }

  validateAndClose(BuildContext context, WidgetRef ref) {
    ref.read(apiUrlProvider.notifier).update(serverAddress.text);

    AutoRouter.of(context).navigateBack();
  }
}

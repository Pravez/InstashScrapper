import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/features/settings/provider.dart';
import 'package:instash_scrapper/features/settings/settings_data.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends ConsumerWidget {
  SettingsPage({Key? key}) : super(key: key);

  final TextEditingController serverAddress = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsData = ref.read(settingsProvider);
    serverAddress.text = settingsData.serverAddress;
    username.text = settingsData.username;
    password.text = settingsData.password;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => AutoRouter.of(context).navigateBack(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => validateAndClose(context, ref, settingsData),
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
      ),
    );
  }

  validateAndClose(BuildContext context, WidgetRef ref, SettingsData data) {
    data.save();
    ref.read(settingsProvider.notifier).state = data;

    AutoRouter.of(context).navigateBack();
  }
}

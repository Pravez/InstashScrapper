import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/app/app.dart';
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

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextBox(
          header: "Adresse du serveur",
          prefix: Container(
              margin: const EdgeInsets.only(left: 10),
              child: const Icon(FluentIcons.input_address)),
          controller: serverAddress,
          placeholder: "http://localhost",
        ),
        const SizedBox(height: 20,),
        TextBox(
          header: "Username",
          prefix: Container(
              margin: const EdgeInsets.only(left: 10),
              child: const Icon(FluentIcons.people)),
          controller: username,
          placeholder: "Username",
        ),
        const SizedBox(height: 20,),
        TextBox(
          header: "Password",
          prefix: Container(
              margin: const EdgeInsets.only(left: 10),
              child: const Icon(FluentIcons.password_field)),
          controller: password,
          obscureText: true,
          placeholder: "password",
        )
      ],
    );
  }

  validateAndClose(BuildContext context, WidgetRef ref, SettingsData data) {
    data.save();
    ref.read(settingsProvider.notifier).state = data;

    AutoRouter.of(context).navigateBack();
  }
}

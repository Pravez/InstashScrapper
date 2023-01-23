import 'package:fluent_ui/fluent_ui.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/app/router.dart';
import 'package:instash_scrapper/components/app_navigation.dart';
import 'package:instash_scrapper/features/settings/provider.dart';
import 'package:instash_scrapper/features/settings/settings_data.dart';
import 'package:instash_scrapper/l10n/l10n.dart';
import 'package:instash_scrapper/shared/app_exception.dart';
import 'package:instash_scrapper/shared/utils.dart';

import 'provider.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => SignInPageState();
}

class SignInPageState extends ConsumerState<SignInPage> {
  final _addressController =
      TextEditingController(text: GetIt.I.get<SettingsData>().serverAddress);

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return AppNavigation(
        content: Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 150),
                  Text(context.l10n.sign_in,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 40)),
                  Form(
                    child: Column(
                      children: [
                        TextBox(
                          header: "Server address",
                          placeholder: "http://...",
                          controller: _addressController,
                          prefix: Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: const Icon(FluentIcons.server)),
                          enabled: authState.maybeWhen(
                              loading: () => false, orElse: () => true),
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const SizedBox(height: 30),
                              authState.maybeWhen(
                                  orElse: () => SizedBox(
                                        width: double.infinity,
                                        height: 30,
                                        child: Button(
                                          onPressed: () {
                                            updateServerAddress(ref);
                                            signInResult(
                                                context,
                                                ref
                                                    .read(authProvider.notifier)
                                                    .canReachServer());
                                          },
                                          child: Text(context.l10n.sign_in),
                                        ),
                                      ),
                                  loading: () => const SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: ProgressRing(
                                          strokeWidth: 3,
                                        ),
                                      )),
                            ]),
                      ],
                    ),
                  )
                ])));
  }

  signInResult(BuildContext context, Future<AppException?> result) {
    final router = GetIt.I.get<AppRouter>();
    result.then((value) => router.navigateNamed("/main")).onError(
        (AppException error, stackTrace) => context.showFluentInfoBar(
            title: "An error occured",
            message: error.maybeWhen(
                unauthorized: () =>
                    "Login failed : username or password incorrect",
                orElse: () => "An error occured"),
            severity: InfoBarSeverity.error));
  }

  updateServerAddress(WidgetRef ref) {
    final data = ref.read(settingsProvider);
    data.serverAddress = _addressController.text;
    data.save();
    ref.read(settingsProvider.notifier).update((state) => state = data);
  }
}

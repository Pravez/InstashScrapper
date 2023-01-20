import 'package:fluent_ui/fluent_ui.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/app/router.dart';
import 'package:instash_scrapper/components/app_navigation.dart';
import 'package:instash_scrapper/l10n/l10n.dart';
import 'package:instash_scrapper/shared/app_exception.dart';
import 'package:instash_scrapper/shared/utils.dart';

import 'provider.dart';

class SignInPage extends ConsumerWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                          header: "Username",
                          placeholder: context.l10n.email_hint,
                          controller: _emailController,
                          enabled: authState.maybeWhen(
                              loading: () => false, orElse: () => true),
                        ),
                        TextBox(
                          placeholder: context.l10n.password_hint,
                          controller: _passwordController,
                          obscureText: true,
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
                                            ref
                                                .read(authProvider.notifier)
                                                .signIn(_emailController.text,
                                                    _passwordController.text)
                                                .onError((AppException error,
                                                    stackTrace) {
                                              context.showFluentInfoBar(
                                                  title: "An error occured",
                                                  message: error.maybeWhen(
                                                      unauthorized: () =>
                                                          "Login failed : username or password incorrect",
                                                      orElse: () =>
                                                          "An error occured"),
                                                  severity:
                                                      InfoBarSeverity.error);

                                              return null;
                                            });
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
                              const SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: TextButton(
                                  onPressed: () {
                                    ref
                                        .read(authProvider.notifier)
                                        .ignoreSignIn()
                                        .then((value) => GetIt.I
                                            .get<AppRouter>()
                                            .navigateNamed("/main"));
                                  },
                                  child:
                                      const Text("Continue without signing in"),
                                ),
                              )
                            ]),
                      ],
                    ),
                  )
                ])));
  }
}

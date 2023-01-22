import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instash_scrapper/shared/app_exception.dart';

extension SnackbarMessenger on BuildContext {
  showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));
  }

  showFluentInfoBar(
      {required String title,
      required String message,
      InfoBarSeverity severity = InfoBarSeverity.info}) {
    displayInfoBar(this,
        builder: (context, close) => InfoBar(
              title: Text(title),
              content: Text(message),
              severity: severity,
            ));
  }
}

extension ErrorHandler on Future<AppException?> {
  handleError(BuildContext context) {
    return onError((error, stackTrace) =>
        context.showFluentInfoBar(title: "Error", message: error.toString()));
  }
}

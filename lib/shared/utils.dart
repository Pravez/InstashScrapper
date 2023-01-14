import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension SnackbarMessenger on BuildContext {
  showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));
  }
}

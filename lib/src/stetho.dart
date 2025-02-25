import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'http_overrides.dart';
import 'method_channel_controller.dart';

class Stetho {
  /// Use this command to initialize Flutter Stetho in your project. It is
  /// recommended you only enable this feature in the dev version of your app!
  ///
  /// ### Example
  ///
  /// ```dart
  /// void main() {
  ///   Stetho.initialize();
  ///
  ///   runApp(MyApp());
  /// }
  /// ```
  static Future<void> initialize() async {
    if (Platform.isAndroid || Platform.isIOS) {
      WidgetsFlutterBinding.ensureInitialized();
      HttpOverrides.global = StethoHttpOverrides();
      return MethodChannelController.initialize();
    }
  }
}
